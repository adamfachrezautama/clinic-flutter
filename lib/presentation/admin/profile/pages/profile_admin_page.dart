import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clinicapp/core/assets/assets.gen.dart';
import 'package:flutter_clinicapp/core/components/spaces.dart';
import 'package:flutter_clinicapp/core/constants/colors.dart';
import 'package:flutter_clinicapp/core/extensions/build_context_ext.dart';
import 'package:flutter_clinicapp/data/datasources/auth_local_datasource.dart';
import 'package:flutter_clinicapp/presentation/admin/home/blocs/get_clinic/get_clinic_bloc.dart';
import 'package:flutter_clinicapp/presentation/auth/pages/onboarding_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProfileAdminPage extends StatelessWidget {
  const ProfileAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xff1469F0),
      statusBarBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: 80,
              width: context.deviceWidth,
              padding: const EdgeInsets.all(20.0),
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
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        Assets.images.logoHorizontal.path,
                        width: 104.0,
                        height: 22.0,
                        fit: BoxFit.cover,
                      ),
                      BlocBuilder<GetClinicBloc, GetClinicState>(
                        builder: (context, state) {
                          return state.maybeWhen(orElse: () {
                            return Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: const BoxDecoration(
                                color: AppColors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.person,
                                  size: 32,
                                  color: AppColors.primary,
                                ),
                              ),
                            );
                          }, success: (clinics) {
                            return Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: const BoxDecoration(
                                color: AppColors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    '${dotenv.env['BASE_URL']}/storage/${clinics.clinicImage}',
                                    width: 40.0,
                                    height: 40.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            );
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SpaceHeight(14),
            Padding(
              padding: const EdgeInsets.all(
                20,
              ),
              child: BlocBuilder<GetClinicBloc, GetClinicState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return Row(
                        children: [
                          Container(
                            width: 72.0,
                            height: 72.0,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.person,
                                size: 52,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                          const SpaceWidth(
                            16,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Klinik Sehat Prima",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                " ",
                                style: TextStyle(
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
                    },
                    success: (clinics) {
                      return Row(
                        children: [
                          Container(
                            width: 72.0,
                            height: 72.0,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(36),
                                child: Image.network(
                                  '${dotenv.env['BASE_URL']}/storage/${clinics.clinicImage}',
                                  width: 72.0,
                                  height: 72.0,
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
                                clinics.clinicName,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            const SpaceHeight(
              12,
            ),
            _menuItem(Assets.icons.document.path, 'Kebijakan Layanan'),
            const SpaceHeight(16),
            _menuItem(Assets.icons.help.path, 'Bantuan'), const SpaceHeight(16),
            InkWell(
                onTap: () async {
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
        ),
      ),
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
