import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clinicapp/core/assets/assets.gen.dart';
import 'package:flutter_clinicapp/core/components/spaces.dart';
import 'package:flutter_clinicapp/core/constants/colors.dart';
import 'package:flutter_clinicapp/core/extensions/build_context_ext.dart';
import 'package:flutter_clinicapp/data/datasources/auth_local_datasource.dart';
import 'package:flutter_clinicapp/data/models/response/login_response_model.dart';
import 'package:flutter_clinicapp/presentation/doctor/chat/blocs/active_orders/active_orders_bloc.dart';
import 'package:flutter_clinicapp/presentation/doctor/chat/blocs/inactive_orders/inactive_orders_bloc.dart';
import 'package:flutter_clinicapp/presentation/doctor/telemedis/widgets/card_telemedis_doctor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TelemedisDoctorPage extends StatefulWidget {
  const TelemedisDoctorPage({super.key});

  @override
  State<TelemedisDoctorPage> createState() => _TelemedisDoctorPageState();
}

class _TelemedisDoctorPageState extends State<TelemedisDoctorPage> {
  @override
  void initState() {
    context.read<ActiveOrdersBloc>().add(
          const ActiveOrdersEvent.getOrder(
            'Telemedis',
            true,
          ),
        );
    context.read<InactiveOrdersBloc>().add(
          const InactiveOrdersEvent.getOrder(
            'Telemedis',
            true,
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xff1469F0),
      statusBarBrightness: Brightness.dark,
    ));
    return DefaultTabController(
      length: 2,
      child: Column(
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
                    FutureBuilder<LoginResponseModel?>(
                        future: AuthLocalDatasource().getUserData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasData) {
                            return Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: const BoxDecoration(
                                color: AppColors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.network(
                                    snapshot.data!.data?.user!.image ?? '',
                                    width: 38.0,
                                    height: 38.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        }),
                  ],
                ),
              ],
            ),
          ),
          const TabBar(
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                color: AppColors.primary,
                width: 2.0,
              ),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            labelPadding: EdgeInsets.symmetric(horizontal: 25.0),
            labelColor: AppColors.primary,
            unselectedLabelColor: Color(0xffB0BEC3),
            tabs: [
              Tab(text: 'Aktif'),
              Tab(text: 'Selesai'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                BlocBuilder<ActiveOrdersBloc, ActiveOrdersState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return const SizedBox.shrink();
                      },
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      success: (data) {
                        if (data.data!.isEmpty) {
                          return const Center(
                            child: Text(
                              'Empty',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                          );
                        }
                        return ListView.separated(
                          padding: const EdgeInsets.all(20),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: data.data!.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SpaceHeight(10);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return CardTelemedisDoctor(
                              model: data.data![index],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                BlocBuilder<InactiveOrdersBloc, InactiveOrdersState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return const SizedBox.shrink();
                      },
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      success: (data) {
                        if (data.data!.isEmpty) {
                          return const Center(
                            child: Text(
                              'Empty',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                          );
                        }
                        return ListView.separated(
                          padding: const EdgeInsets.all(20),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: data.data!.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SpaceHeight(10);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return CardTelemedisDoctor(
                              model: data.data![index],
                            );
                          },
                        );
                      },
                    );
                  },
                ),

                // ListView.separated(
                //   padding: const EdgeInsets.all(20),
                //   shrinkWrap: true,
                //   physics: const NeverScrollableScrollPhysics(),
                //   itemCount: done.length,
                //   separatorBuilder: (BuildContext context, int index) {
                //     return const SpaceHeight(10);
                //   },
                //   itemBuilder: (BuildContext context, int index) {
                //     return CardTelemedisDoctor(model: done[index]);
                //   },
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget menuActive(String title, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 34,
        width: 76,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [
              AppColors.secondary,
              Color(0xff1469F0),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget menuDisable(String title, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 34,
        width: 76,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xffB0BEC3),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              color: Color(0xffB0BEC3),
            ),
          ),
        ),
      ),
    );
  }
}
