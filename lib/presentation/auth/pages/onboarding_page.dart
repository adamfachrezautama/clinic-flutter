import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clinicapp/core/assets/assets.gen.dart';
import 'package:flutter_clinicapp/core/components/buttons.dart';
import 'package:flutter_clinicapp/core/components/spaces.dart';
import 'package:flutter_clinicapp/core/constants/colors.dart';
import 'package:flutter_clinicapp/core/extensions/build_context_ext.dart';
import 'package:flutter_clinicapp/data/datasources/auth_local_datasource.dart';
import 'package:flutter_clinicapp/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_clinicapp/data/datasources/firebase_datasource.dart';
import 'package:flutter_clinicapp/data/models/response/user_model.dart';

import 'package:flutter_clinicapp/presentation/admin/home/pages/admin_main_page.dart';
import 'package:flutter_clinicapp/presentation/auth/pages/privacy_policy_page.dart';
import 'package:flutter_clinicapp/presentation/doctor/home/pages/doctor_home_page.dart';
import 'package:flutter_clinicapp/presentation/home/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../blocs/login_google/login_google_bloc.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  String? uid;
  Future<void> googleLogin(BuildContext context) async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login dibatalkan")),
        );
        return;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final idToken = googleAuth.idToken;

      if (idToken == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("ID Token kosong, tidak bisa login.")),
        );
        return;
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: idToken,
      );

      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      uid = userCredential.user?.uid ?? '';

      // Baru kirim ke server
      context.read<LoginGoogleBloc>().add(
        LoginGoogleEvent.loginGoogle(idToken),
      );

      log("UID : $uid");
    } catch (e) {
      final snackBar = SnackBar(
        content: Text("Google Login Error: $e"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      log("Google Login Error : $e");
    }
  }


  void _handleOptIn() {
    OneSignal.User.pushSubscription.optIn();
  }

  Future<void> initOneSignalId() async {
    if (!mounted) return;
    await OneSignal.User.getOnesignalId();
    OneSignal.User.pushSubscription.addObserver((state) async {
      log("optedIn1: ${OneSignal.User.pushSubscription.optedIn}");
      log("id: ${OneSignal.User.pushSubscription.id}");
      log("token: ${OneSignal.User.pushSubscription.token}");
      log(state.current.jsonRepresentation());
    });
  }

  @override
  void initState() {
    super.initState();
    initOneSignalId().whenComplete(() => _handleOptIn());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: context.deviceHeight,
              width: context.deviceWidth,
              decoration: const BoxDecoration(
                color: AppColors.primary,
              ),
              child: Column(
                children: [
                  const SpaceHeight(24),
                  Image.asset(
                    Assets.images.logo.path,
                    height: 75,
                    width: 66,
                  ),
                  const SizedBox(height: 24),
                  Image.asset(
                    Assets.images.onboardingDoctor.path,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                width: context.deviceWidth,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(
                      16,
                    ),
                    topLeft: Radius.circular(
                      16,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    const SpaceHeight(16),
                    const Text(
                      "Jaga Kesehatan, Dimana Saja",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SpaceHeight(6),
                    const Text(
                      "Konsultasikan kesehatan Anda kapan saja dan di mana saja bersama profesional terpercaya",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey,
                      ),
                    ),
                    const SpaceHeight(
                      36,
                    ),
                    BlocConsumer<LoginGoogleBloc, LoginGoogleState>(
                      listener: (context, state) {
                        state.maybeWhen(
                          orElse: () {},
                          success: (data) async {
                            log(data.toJson());
                            await AuthLocalDatasource().saveUserData(data);

                            //role
                            if (data.data!.user?.role! == 'doctor') {
                              context.push(const DoctorHomePage());
                              return;
                            } else if (data.data!.user?.role! == 'admin') {
                              context.push(const AdminMainPage());
                              return;
                            }
                            if (data.data!.isNew!) {
                              final existingUser = await FirebaseDatasource
                                  .instance
                                  .getUserByEmail(data.data!.user!.email!);
                              if (existingUser == null) {
                                final model = UserModel(
                                  id: uid!,
                                  userName: data.data!.user!.name!,
                                  email: data.data!.user!.email!,
                                );
                                await FirebaseDatasource.instance
                                    .setUserToDB(model);
                              } else {
                                // Handle the case where the user already exists
                                log("User already exists: ${existingUser.toJson()}");
                              }
                              context.push(const PrivacyPolicyPage());
                            } else {
                              // Update UID for existing user
                              // await FirebaseDatasource.instance
                              //     .updateUidByEmail(
                              //         data.data!.user!.email!, uid!);
                              context.push(const HomePage());
                            }
                            await AuthRemoteDatasource().updateOneSignalToken(
                              OneSignal.User.pushSubscription.id!,
                            );

                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => const PrivacyPolicyPage(),
                            //   ),
                            // );
                          },
                          error: (message) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(message),
                              ),
                            );
                          },
                        );
                      },
                      builder: (context, state) {
                        return state.maybeWhen(orElse: () {
                          return Button.filled(
                            height: 48,
                            onPressed: () {
                              googleLogin(context);
                            },
                            label: 'Masuk dengan Google',
                            icon: Image.asset(
                              Assets.images.google.path,
                              height: 24,
                              width: 24,
                              color: Colors.white,
                            ),
                            fontSize: 14.0,
                          );
                        }, loading: () {
                          return Center(
                              child: const CircularProgressIndicator());
                        });
                      },
                    ),
                    // const SpaceHeight(26),
                    // Button.filled(
                    //     onPressed: () {
                    //       context.push(const DoctorHomePage());
                    //     },
                    //     label: 'Doctor Page'),
                    // const SpaceHeight(26),
                    // Button.filled(
                    //     onPressed: () {
                    //       context.push(const AdminMainPage());
                    //     },
                    //     label: 'Admin Page'),
                    const SpaceHeight(26),
                    const Text(
                      "Powerred by",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey,
                      ),
                    ),
                    const SpaceHeight(6),
                    Image.asset(
                      Assets.images.jf4.path,
                      // height: 60,
                      width: 80,
                      color: AppColors.primary,
                    ),
                    const SpaceHeight(24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
