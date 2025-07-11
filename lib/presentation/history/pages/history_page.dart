import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clinicapp/core/components/spaces.dart';
import 'package:flutter_clinicapp/core/constants/colors.dart';
import 'package:flutter_clinicapp/core/extensions/build_context_ext.dart';
import 'package:flutter_clinicapp/presentation/history/blocs/get_orders_patient/get_orders_patient_bloc.dart';
import 'package:flutter_clinicapp/presentation/history/widgets/card_history.dart';
import 'package:flutter_clinicapp/presentation/history/widgets/empty_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    context
        .read<GetOrdersPatientBloc>()
        .add(const GetOrdersPatientEvent.getOrdersPatient());
    super.initState();
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
                  "History Chat & Telemedis",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            const SpaceHeight(14),
            BlocBuilder<GetOrdersPatientBloc, GetOrdersPatientState>(
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
                      return const Center(child: EmptyWidget());
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
                        return CardHistory(
                          order: data.data![index],
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
