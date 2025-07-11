import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clinicapp/core/assets/assets.gen.dart';
import 'package:flutter_clinicapp/core/components/spaces.dart';
import 'package:flutter_clinicapp/core/constants/colors.dart';
import 'package:flutter_clinicapp/core/extensions/build_context_ext.dart';
import 'package:flutter_clinicapp/data/datasources/auth_local_datasource.dart';
import 'package:flutter_clinicapp/data/models/response/login_response_model.dart';
import 'package:flutter_clinicapp/presentation/auth/pages/onboarding_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          width: context.deviceWidth,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.secondary,
                Color(0xff1469F0),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: const Center(
            child: Text(
              "Profile",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: AppColors.white,
              ),
            ),
          ),
        ),
        const SpaceHeight(14),
        Padding(
          padding: const EdgeInsets.all(
            20,
          ),
          child: FutureBuilder<LoginResponseModel?>(
              future: AuthLocalDatasource().getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error'),
                  );
                } else if (snapshot.hasData) {
                  return Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          color: Color(
                            0xffF5F5F5,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.network(
                              snapshot.data!.data?.user?.image ?? '',
                              width: 50.0,
                              height: 50.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SpaceWidth(
                        16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.data?.user?.name ?? '',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            snapshot.data!.data?.user?.email ?? '',
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              color: Color(
                                0xff8C8C8C,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text('Data tidak ditemukan'),
                  );
                }
              }),
        ),
        const SpaceHeight(
          12,
        ),
        _menuItem(Assets.icons.document.path, 'Kebijakan Layanan'),
        const SpaceHeight(16),
        _menuItem(Assets.icons.help.path, 'Bantuan'), const SpaceHeight(16),
        InkWell(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              await GoogleSignIn().signOut();
              await AuthLocalDatasource().removeUserData();
              context.pushReplacement(const OnboardingPage());
            },
            child: _menuItem(Assets.icons.logout.path, 'Keluar')),
        const SpaceHeight(16),
        // Padding(
        //   padding: EdgeInsets.only(top: context.deviceHeight * 0.2, left: 20, right: 20),
        //   child: EmptyWidget(),
        // ),
      ],
    );
  }

  Widget _menuItem(final String image, final String title) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      padding: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: const Color(
              0xff677294,
            ).withOpacity(0.16),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              color: Color(
                0xffF5F5F5,
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                image,
                width: 24.0,
                height: 24.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SpaceWidth(16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: Color(
                0xff000000,
              ),
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
            size: 24,
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
