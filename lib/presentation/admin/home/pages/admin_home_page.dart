import 'package:flutter/material.dart';
import 'package:flutter_clinicapp/core/assets/assets.gen.dart';
import 'package:flutter_clinicapp/core/components/spaces.dart';
import 'package:flutter_clinicapp/core/constants/colors.dart';
import 'package:flutter_clinicapp/core/extensions/build_context_ext.dart';
import 'package:flutter_clinicapp/core/extensions/string_ext.dart';
import 'package:flutter_clinicapp/presentation/admin/home/blocs/get_clinic/get_clinic_bloc.dart';
import 'package:flutter_clinicapp/presentation/admin/home/blocs/get_orders_clinic/get_orders_clinic_bloc.dart';
import 'package:flutter_clinicapp/presentation/doctor/history/widgets/card_doctor_history.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<GetClinicBloc>().add(const GetClinicEvent.getDetail());
    context
        .read<GetOrdersClinicBloc>()
        .add(const GetOrdersClinicEvent.getOrders());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 140,
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
                    const SpaceHeight(20),
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
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    '${dotenv.env['BASE_URL']}/storage/${data.clinicImage}',
                                    width: 40.0,
                                    height: 40.0,
                                    fit: BoxFit.fill,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SpaceHeight(
                136,
              ),
              BlocBuilder<GetOrdersClinicBloc, GetOrdersClinicState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return const SizedBox.shrink();
                    },
                    loading: () {
                      return const Center(
                        child:
                            CircularProgressIndicator(color: AppColors.primary),
                      );
                    },
                    success: (data) {
                      if (data.data!.isEmpty) {
                        return const Center(
                          child: Text("Data Kosong"),
                        );
                      }
                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.data!.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SpaceHeight(12);
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return CardDoctorHistory(
                            model: data.data![index],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 100.0,
              left: 20.0,
              right: 20.0,
            ),
            width: context.deviceWidth,
            height: 153,
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [
                  AppColors.secondary,
                  Color(0xff1469F0),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<GetClinicBloc, GetClinicState>(
                  builder: (context, state) {
                    return state.maybeWhen(orElse: () {
                      return const SizedBox.shrink();
                    }, loading: () {
                      return const Center(child: CircularProgressIndicator());
                    }, success: (data) {
                      return Text(
                        data.clinicName,
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white),
                      );
                    });
                  },
                ),
                BlocBuilder<GetClinicBloc, GetClinicState>(
                  builder: (context, state) {
                    return state.maybeWhen(orElse: () {
                      return const SizedBox.shrink();
                    }, loading: () {
                      return const Center(child: CircularProgressIndicator());
                    }, success: (data) {
                      return Text(
                        "Income : ${data.totalIncome.toString().currencyFormatRpV2}",
                        style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white),
                      );
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Pasien",
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white,
                          ),
                        ),
                        BlocBuilder<GetClinicBloc, GetClinicState>(
                          builder: (context, state) {
                            return state.maybeWhen(orElse: () {
                              return const SizedBox.shrink();
                            }, loading: () {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }, success: (data) {
                              return Text(
                                "${data.totalPatient}",
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.white,
                                ),
                              );
                            });
                          },
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Dokter",
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white,
                          ),
                        ),
                        BlocBuilder<GetClinicBloc, GetClinicState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () {
                                return const SizedBox.shrink();
                              },
                              loading: () {
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                              success: (data) {
                                return Text(
                                  "${data.totalDoctor}",
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.white,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
