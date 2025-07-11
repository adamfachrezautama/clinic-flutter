// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_clinicapp/core/assets/assets.gen.dart';
import 'package:flutter_clinicapp/core/components/spaces.dart';
import 'package:flutter_clinicapp/core/constants/colors.dart';
import 'package:flutter_clinicapp/core/extensions/build_context_ext.dart';
import 'package:flutter_clinicapp/core/extensions/string_ext.dart';
import 'package:flutter_clinicapp/core/utils/convert.dart';
import 'package:flutter_clinicapp/data/models/response/order_response_model.dart';

class CardDoctorHistory extends StatelessWidget {
  final OrderModel model;
  const CardDoctorHistory({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.deviceWidth,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(16.0),
        ),
        border: Border.all(
          color: const Color(0xffE0E8F2).withOpacity(
            0.6,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 52.0,
                height: 52.0,
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.secondary,
                      Color(0xff1469F0),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Image.asset(
                  Assets.icons.emptyWallet.path,
                  fit: BoxFit.cover,
                ),
              ),
              const SpaceWidth(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          model.service ?? '-',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          model.price?.toString().currencyFormatRpV2 ?? '0',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          model.patient?.name ?? '-',
                          style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        Text(
                          model.doctor?.name ?? "",
                          style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    const SpaceHeight(4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ID transaksi",
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff26273A).withOpacity(0.6)),
                        ),
                        Text(
                          Convert.formatToReadableDate(
                            model.schedule!.toString(),
                          ),
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff26273A).withOpacity(0.6)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          model.id.toString(),
                          style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        Text(
                          Convert.formatToReadableDate(
                            model.schedule!.toString(),
                          ),
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff26273A).withOpacity(0.6)),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
