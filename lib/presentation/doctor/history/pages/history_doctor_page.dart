import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clinicapp/core/components/spaces.dart';
import 'package:flutter_clinicapp/core/constants/colors.dart';
import 'package:flutter_clinicapp/core/extensions/build_context_ext.dart';
import 'package:flutter_clinicapp/presentation/doctor/history/blocs/history_order_doctor/history_order_doctor_bloc.dart';
import 'package:flutter_clinicapp/presentation/doctor/history/widgets/card_doctor_history.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryDoctorPage extends StatefulWidget {
  const HistoryDoctorPage({super.key});

  @override
  State<HistoryDoctorPage> createState() => _HistoryDoctorPageState();
}

class _HistoryDoctorPageState extends State<HistoryDoctorPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<HistoryOrderDoctorBloc>()
        .add(const HistoryOrderDoctorEvent.getOrder());
  }

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
                  "History",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            const SpaceHeight(14),
            BlocBuilder<HistoryOrderDoctorBloc, HistoryOrderDoctorState>(
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
            // Padding(
            //   padding: EdgeInsets.only(
            //       top: context.deviceHeight * 0.2, left: 20, right: 20),
            //   child: const EmptyWidget(),
            // ),
          ],
        ),
      ),
    );
  }
}
