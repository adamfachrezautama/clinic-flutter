import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clinicapp/core/components/buttons.dart';
import 'package:flutter_clinicapp/core/components/custom_text_field.dart';
import 'package:flutter_clinicapp/core/components/spaces.dart';
import 'package:flutter_clinicapp/core/constants/colors.dart';
import 'package:flutter_clinicapp/core/extensions/build_context_ext.dart';
import 'package:flutter_clinicapp/data/models/request/user_request_model.dart';
import 'package:flutter_clinicapp/presentation/auth/blocs/update_user/update_user_bloc.dart';
import 'package:flutter_clinicapp/presentation/home/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataPenggunaPage extends StatefulWidget {
  const DataPenggunaPage({super.key});

  @override
  State<DataPenggunaPage> createState() => _DataPenggunaPageState();
}

class _DataPenggunaPageState extends State<DataPenggunaPage> {
  String? _selectedGender;
  String? birthDate;
  TextEditingController? nameController;
  TextEditingController? dateController;
  TextEditingController? phoneController;
  TextEditingController? addressController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    dateController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
  }

  @override
  void dispose() {
    nameController?.dispose();
    dateController?.dispose();
    phoneController?.dispose();
    addressController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xff1469F0),
      statusBarBrightness: Brightness.dark,
    ));
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              width: context.deviceWidth,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                children: [
                  IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.white,
                    ),
                  ),
                  const Text(
                    "Data Pasien",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SpaceHeight(12),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              width: context.deviceWidth,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 24,
                    offset: Offset(0, 11),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Nama Sesuai KTP",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  const SpaceHeight(
                    8,
                  ),
                  CustomTextField(
                    controller: nameController!,
                    label: 'Sinta Saras',
                    textInputAction: TextInputAction.next,
                  ),
                  const SpaceHeight(
                    16,
                  ),
                  const Text(
                    "Tanggal Lahir",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  const SpaceHeight(
                    8,
                  ),
                  CustomTextField(
                    controller: dateController!,
                    label: 'dd-mm-yyyy',
                    readOnly: true,
                    textInputAction: TextInputAction.next,
                    suffixIcon: GestureDetector(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );

                        if (date != null) {
                          setState(() {
                            //datetime format
                            birthDate =
                                "${date.day}-${date.month}-${date.year}";
                            birthDate =
                                "${date.day}-${date.month}-${date.year}";
                            dateController!.text =
                                "${date.day}-${date.month}-${date.year}";
                          });
                        }
                      },
                      child: const Icon(
                        Icons.calendar_today,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SpaceHeight(
                    16,
                  ),
                  const Text(
                    "Jenis Kelamin",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  const SpaceHeight(
                    8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Pria',
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value;
                              });
                            },
                            activeColor: Colors.blue,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedGender = 'Pria';
                              });
                            },
                            child: const Text(
                              'Pria',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                color: Color(
                                  0xff677294,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SpaceWidth(28),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Wanita',
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value;
                              });
                            },
                            activeColor: AppColors.primary,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedGender = 'Wanita';
                              });
                            },
                            child: const Text(
                              'Wanita',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                color: Color(
                                  0xff677294,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SpaceHeight(
                    16,
                  ),
                  const Text(
                    "No Handphone",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  const SpaceHeight(
                    8,
                  ),
                  CustomTextField(
                    controller: phoneController!,
                    label: '',
                    keyboardType: TextInputType.number,
                    prefixIcon: Container(
                      width: 54,
                      height: 54,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '+62',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              color: Color(
                                0xff677294,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  const SpaceHeight(
                    16,
                  ),
                  const Text(
                    "Alamat Domisili",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  const SpaceHeight(
                    8,
                  ),
                  CustomTextField(
                    controller: addressController!,
                    label: 'Jl. Jago Flutter No. 32',
                    maxLines: 3,
                    textInputAction: TextInputAction.done,
                  ),
                  const SpaceHeight(10)
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 52,
        margin: const EdgeInsets.all(20),
        width: context.deviceWidth,
        child: BlocConsumer<UpdateUserBloc, UpdateUserState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              error: (message) {
                context.showSnackBar(message, Colors.red);
              },
              success: (user) {
                context.showSnackBar(
                    "Data berhasil disimpan", AppColors.primary);
                context.push(const HomePage());
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(orElse: () {
              return Button.filled(
                height: 48,
                onPressed: () {
                  final model = UserRequestModel(
                    name: nameController!.text,
                    address: addressController!.text,
                    //datetime format
                    birthDate: birthDate!,
                    gender: _selectedGender!,
                    phoneNumber: "62${phoneController!.text}",
                  );

                  context
                      .read<UpdateUserBloc>()
                      .add(UpdateUserEvent.updateUser(model));

                  // AwesomeDialog(
                  //   context: context,
                  //   customHeader: const Icon(
                  //     Icons.check_circle,
                  //     size: 80,
                  //     color: AppColors.primary,
                  //   ),
                  //   btnOk: Container(
                  //     margin: const EdgeInsets.only(bottom: 20),
                  //     child: Button.filled(
                  //       onPressed: () {
                  //         context.push(const HomePage());
                  //       },
                  //       label: 'Lanjut',
                  //       fontSize: 16.0,
                  //     ),
                  //   ),
                  //   dialogType: DialogType.success,
                  //   animType: AnimType.bottomSlide,
                  //   title: 'Berhasil',
                  //   desc: 'Data berhasil disimpan',
                  //   btnOkOnPress: () {
                  //     context.push(const HomePage());
                  //   },
                  // ).show();
                },
                label: 'Simpan',
                fontSize: 16.0,
              );
            }, loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            });
          },
        ),
        // Button.filled(
        //   height: 48,
        //   onPressed: () {
        //     context.push(const HomePage());
        //   },
        //   label: 'Simpan',
        //   fontSize: 16.0,
        // ),
      ),
    );
  }
}
