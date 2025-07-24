import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clinicapp/core/assets/assets.gen.dart';
import 'package:flutter_clinicapp/core/components/spaces.dart';
import 'package:flutter_clinicapp/core/constants/colors.dart';
import 'package:flutter_clinicapp/core/extensions/build_context_ext.dart';
import 'package:flutter_clinicapp/data/datasources/auth_local_datasource.dart';
import 'package:flutter_clinicapp/data/models/response/login_response_model.dart';
import 'package:flutter_clinicapp/presentation/chat/blocs/get_doctors_active/get_doctors_active_bloc.dart';
import 'package:flutter_clinicapp/presentation/telemedis/widgets/card_doctor_telemedis.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../admin/doctor/blocs/get_specialization/get_specializations_bloc.dart';
import '../../chat/widgets/specialation_menu.dart';

class TelemedisPage extends StatefulWidget {
  const TelemedisPage({super.key});

  @override
  State<TelemedisPage> createState() => _TelemedisPageState();
}

class _TelemedisPageState extends State<TelemedisPage> {
  final searchController = TextEditingController();
  int indexValue = 0;
  @override
  void initState() {
    super.initState();
    context
        .read<GetDoctorsActiveBloc>()
        .add(const GetDoctorsActiveEvent.getDoctors());
    context
        .read<GetSpecializationsBloc>()
        .add(const GetSpecializationsEvent.getSpecializations());
  }

  void onSpecializationTap(int index, int specializationId) {
    searchController.clear();
    indexValue = index;
    context
        .read<GetDoctorsActiveBloc>()
        .add(GetDoctorsActiveEvent.spealicationDoctor(specializationId));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xff1469F0),
      statusBarBrightness: Brightness.dark,
    ));
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
                    const SpaceHeight(10),
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
                              if (snapshot.hasData) {
                                return CircleAvatar(
                                  radius: 20,
                                  backgroundImage:  (snapshot.data?.data?.user?.image?.isNotEmpty ?? false)
                                      ? NetworkImage(snapshot.data!.data!.user!.image!)
                                      : const AssetImage('assets/images/user-default.png') as ImageProvider, // Fallback image
                                );
                              }
                              return const SizedBox.shrink();
                            }),
                      ],
                    ),
                  ],
                ),
              ),
              const SpaceHeight(
                136,
              ),
              BlocBuilder<GetDoctorsActiveBloc, GetDoctorsActiveState>(
                builder: (context, state) {
                  return state.maybeWhen(orElse: () {
                    return const SizedBox.shrink();
                  }, success: (doctors) {
                    if (doctors.isEmpty) {
                      return Padding(
                        padding:
                            EdgeInsets.only(top: context.deviceHeight * 0.2),
                        child: const Center(
                          child: Text('Doctors not found'),
                        ),
                      );
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.all(20),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: doctors.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SpaceHeight(10);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return CardDoctorTelemedis(
                          model: doctors[index],
                        );
                      },
                    );
                  }, loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  });
                },
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 80.0,
              left: 20.0,
              right: 20.0,
            ),
            width: context.deviceWidth,
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 20,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 55,
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(
                          6,
                        ),
                      ),
                      child: Image.asset(
                        Assets.icons.hand.path,
                        width: 38.0,
                        height: 34.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SpaceWidth(16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Video Call Dokter di Ayo Sehat',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Layanan telemedis yang siap siaga untuk bantu kamu hidup lebih sehat.',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SpaceHeight(8),
                Container(
                  width: context.deviceWidth,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(
                      0xffF5F5F5,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search,
                        color: Color(0xff8C8C8C),
                      ),
                      const SpaceWidth(16),
                      Expanded(
                        child: TextFormField(
                          controller: searchController,
                          onChanged: (value) {
                            if (value.length > 3) {
                              context.read<GetDoctorsActiveBloc>().add(
                                  GetDoctorsActiveEvent.searchDoctors(value));
                            }
                            if (value.isEmpty) {
                              context.read<GetDoctorsActiveBloc>().add(
                                  const GetDoctorsActiveEvent
                                      .fetchAllFromState());
                            }
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Cari dokter atau spesialis',
                            hintStyle: TextStyle(
                              color: Color(
                                0xff8C8C8C,
                              ),
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SpaceHeight(
                  10,
                ),
                SizedBox(
                  width: context.deviceWidth,
                  height: 26,
                  child:
                      BlocBuilder<GetSpecializationsBloc, GetSpecializationsState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return const SizedBox.shrink();
                        },
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        success: (data) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: data.data.length + 1,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == 0) {
                                return SpecializationMenu(
                                  label: 'Semua',
                                  isActive: indexValue == index,
                                  onPressed: () => onSpecializationTap(index, 0),
                                );
                              } else {
                                final specialization = data.data[index - 1];
                                return Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: SpecializationMenu(
                                    label: specialization.name,
                                    isActive: indexValue == index,
                                    onPressed: () => onSpecializationTap(
                                        index, specialization.id),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
