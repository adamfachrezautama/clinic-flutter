// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_clinicapp/core/assets/assets.gen.dart';
import 'package:flutter_clinicapp/core/components/buttons.dart';
import 'package:flutter_clinicapp/core/components/spaces.dart';
import 'package:flutter_clinicapp/core/constants/colors.dart';
import 'package:flutter_clinicapp/core/extensions/build_context_ext.dart';
import 'package:flutter_clinicapp/core/extensions/string_ext.dart';
import 'package:flutter_clinicapp/core/utils/convert.dart';
import 'package:flutter_clinicapp/data/models/response/order_response_model.dart';
import 'package:flutter_clinicapp/presentation/history/widgets/loading_vidcall_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CardTelemedisDoctor extends StatelessWidget {
  final OrderModel model;
  const CardTelemedisDoctor({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.deviceWidth,
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(18.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 20,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: model.patient?.image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(40.0),
                    child: Image.network(
                      model.patient!.image!.contains('https')
                          ? model.patient!.image!
                          : "${dotenv.env['BASE_URL']}${model.patient?.image}",
                      width: 80,
                      height: 80,
                    ),
                  )
                : Image.asset(
                    Assets.images.doctorVidcall2.path,
                    width: 87.0,
                    height: 87.0,
                    fit: BoxFit.cover,
                  ),
          ),
          const SpaceWidth(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.service ?? '-',
                  style: const TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Text(
                  model.patient?.name ?? '-',
                  style: const TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                      color: Color(
                        0xffB0BEC3,
                      )),
                ),
                const SpaceHeight(8),
                Text(
                  Convert.formatToReadableDate(
                    model.schedule!.toString(),
                  ),
                  style: const TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                const SpaceHeight(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Bayar",
                          style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                        ),
                        const SpaceHeight(4),
                        Text(
                          model.doctor!.telemedicineFee
                              .toString()
                              .currencyFormatRpV2,
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff677294),
                          ),
                        ),
                      ],
                    ),
                    model.statusService == "Active"
                        ? SizedBox(
                            width: 83,
                            height: 25,
                            child: Button.filled(
                              borderRadius: 4,
                              onPressed: () {
                                context.push(LoadingVidcallPage(
                                    channel: model.id!.toString(),
                                    isDoctor: true,));
                              },
                              label: 'Gabung',
                              fontSize: 12.0,
                            ),
                          )
                        : Container(
                            width: 77,
                            height: 25,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6.0,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xff25B865).withOpacity(
                                0.1,
                              ),
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 8,
                                  width: 8,
                                  decoration: const BoxDecoration(
                                    color: Color(
                                      0xff25B865,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const Text(
                                  "Selesai",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                    color: Color(
                                      0xff25B865,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
