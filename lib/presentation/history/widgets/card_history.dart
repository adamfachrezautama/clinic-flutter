// ignore_for_file: public_member_api_docs, sort_ructors_first
import 'package:flutter/material.dart';
import 'package:flutter_clinicapp/core/assets/assets.gen.dart';
import 'package:flutter_clinicapp/core/components/spaces.dart';
import 'package:flutter_clinicapp/core/constants/colors.dart';
import 'package:flutter_clinicapp/core/extensions/build_context_ext.dart';
import 'package:flutter_clinicapp/core/extensions/string_ext.dart';
import 'package:flutter_clinicapp/core/utils/convert.dart';
import 'package:flutter_clinicapp/data/models/response/order_response_model.dart';
import 'package:flutter_clinicapp/presentation/chat/pages/chat_with_doctor_page.dart';
import 'package:flutter_clinicapp/presentation/history/widgets/loading_vidcall_page.dart';
import 'package:flutter_clinicapp/presentation/telemedis/blocs/agora_token/agora_token_bloc.dart';
import 'package:flutter_clinicapp/presentation/telemedis/pages/vidcall_page.dart';
import 'package:flutter_clinicapp/presentation/telemedis/pages/video_call_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardHistory extends StatelessWidget {
  final OrderModel order;
  const CardHistory({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (order.service == "Telemedis") {
          context.push(LoadingVidcallPage(channel: order.id!.toString(),
              isDoctor: false));
        } else {
          context.push(
            ChatWithDoctorPage(
              order: order,
            ),
          );
        }
      },
      child: Container(
        width: context.deviceWidth,
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
          boxShadow: [
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
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: order.doctor!.image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Image.network(
                            order.doctor!.image!.contains('https')
                                ? order.doctor!.image!
                                : "${Variables.baseUrl}${order.doctor!.image}",
                            width: 87,
                            height: 87,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(
                          Assets.images.doctor1.path,
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
                        order.service ?? "-",
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        order.doctor?.name ?? "-",
                        style: const TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          color: Color(
                            0xffB0BEC3,
                          ),
                        ),
                      ),
                      const SpaceHeight(8),
                      Text(
                        "${Convert.formatToReadableDate(order.schedule.toString())}, Pukul ${Convert.formatToReadableTime(order.schedule.toString())}",
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
                              Text(
                                order.price.toString().currencyFormatRpV2,
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff677294),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 24,
                            width: 77,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
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
                                Text(
                                  "${order.status}",
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                    color: Color(
                                      0xff25B865,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
