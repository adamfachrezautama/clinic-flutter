import 'package:flutter/material.dart';
import 'package:flutter_clinicapp/core/components/spaces.dart';
import 'package:flutter_clinicapp/core/constants/colors.dart';
import 'package:flutter_clinicapp/core/extensions/build_context_ext.dart';
import 'package:flutter_clinicapp/presentation/admin/doctor/pages/add_doctor_page.dart';
import 'package:flutter_clinicapp/presentation/admin/doctor/widgets/card_doctor_widget.dart';
import 'package:flutter_clinicapp/presentation/admin/doctor/widgets/empty_doctor_widget.dart';
import 'package:flutter_clinicapp/presentation/chat/blocs/get_doctors/get_doctors_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminDoctorPage extends StatefulWidget {
  const AdminDoctorPage({super.key});

  @override
  State<AdminDoctorPage> createState() => _AdminDoctorPageState();
}

class _AdminDoctorPageState extends State<AdminDoctorPage> {
  @override
  void initState() {
    super.initState();
    context.read<GetDoctorsBloc>().add(const GetDoctorsEvent.getDoctors());
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Color(0xff1469F0),
    //   statusBarBrightness: Brightness.dark,
    // ));
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              const Text(
                "Kelola Doctor",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.push(const AddDoctorPage());
                },
                child: const Icon(
                  Icons.add,
                  size: 24.0,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
        const SpaceHeight(14),
        BlocBuilder<GetDoctorsBloc, GetDoctorsState>(
          builder: (context, state) {
            return state.maybeWhen(orElse: () {
              return const SizedBox.shrink();
            }, loading: () {
              return const Center(child: CircularProgressIndicator());
            }, success: (doctors) {
              if (doctors.isEmpty) {
                return Padding(
                  padding: EdgeInsets.only(
                      top: context.deviceHeight * 0.2, left: 20, right: 20),
                  child: const EmptyDoctorWidget(),
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
                  return CardDoctorWidget(
                    doctor: doctors[index],
                  );
                },
              );
            });
          },
        ),
      ],
    );
  }
}
