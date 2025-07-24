import 'dart:developer';

import 'package:flutter_clinicapp/core/extensions/string_ext.dart';
import 'package:flutter_clinicapp/core/utils/convert.dart';
import 'package:flutter_clinicapp/data/datasources/auth_local_datasource.dart';
import 'package:flutter_clinicapp/data/datasources/firebase_datasource.dart';
import 'package:flutter_clinicapp/data/models/request/doctor_request_model.dart';
import 'package:flutter_clinicapp/data/models/response/user_model.dart';
import 'package:flutter_clinicapp/presentation/admin/doctor/blocs/add_doctor/add_doctor_bloc.dart';
import 'package:flutter_clinicapp/presentation/chat/blocs/get_doctors/get_doctors_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clinicapp/core/components/buttons.dart';
import 'package:flutter_clinicapp/core/components/custom_text_field.dart';
import 'package:flutter_clinicapp/core/components/custom_text_field_height.dart';
import 'package:flutter_clinicapp/core/components/spaces.dart';
import 'package:flutter_clinicapp/core/constants/colors.dart';
import 'package:flutter_clinicapp/core/extensions/build_context_ext.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/components/image_picker_widget.dart';
import '../../../../data/models/response/specialization_response_model.dart';
import '../blocs/get_specialization/get_specializations_bloc.dart';

class AddDoctorPage extends StatefulWidget {
  const AddDoctorPage({super.key});

  @override
  State<AddDoctorPage> createState() => _AddDoctorPageState();
}

class _AddDoctorPageState extends State<AddDoctorPage> {
  String? _selectedGender;
  TextEditingController? _nameController;
  TextEditingController? _emailController;
  TextEditingController? _sertificationController;
  TextEditingController? _telemedicRateController;
  TextEditingController? _chatPremiumRateController;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  XFile? imageFile;
  SpecializationModel? _selectedSpecialization;
  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _sertificationController = TextEditingController();
    _telemedicRateController = TextEditingController();
    _chatPremiumRateController = TextEditingController();
    context
        .read<GetSpecializationsBloc>()
        .add(const GetSpecializationsEvent.getSpecializations());
    super.initState();
  }

  @override
  void dispose() {
    _nameController?.dispose();
    _emailController?.dispose();
    _sertificationController?.dispose();
    _telemedicRateController?.dispose();
    _chatPremiumRateController?.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context, bool isStart) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStart
          ? (_startTime ?? TimeOfDay.now())
          : (_endTime ?? TimeOfDay.now()),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xff1469F0),
      statusBarBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      bottomNavigationBar: Container(
        height: 52,
        margin: const EdgeInsets.all(20),
        width: context.deviceWidth,
        child: BlocConsumer<AddDoctorBloc, AddDoctorState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              error: (message) {
                context.showSnackBar(message, Colors.red);
              },
              success: (message) async {
                final model = UserModel(
                  id: '-',
                  userName: _nameController!.text,
                  email: _emailController!.text,
                  role: 'doctor',
                );
                await FirebaseDatasource.instance.setUserToDB(model);
                context
                    .read<GetDoctorsBloc>()
                    .add(const GetDoctorsEvent.getDoctors());
                context.showSnackBar(
                  message,
                );
                context.pop();
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return Button.filled(
                  height: 48,
                  onPressed: () async {
                    final telemedicRate = Convert.cleanCurrencyToNumber(
                        _telemedicRateController!.text);
                    final chatPremiumRate = Convert.cleanCurrencyToNumber(
                        _chatPremiumRateController!.text);

                    final startTime = Convert.formatTo24Hour(_startTime!);
                    final endTime = Convert.formatTo24Hour(_endTime!);
                    // remvoe space nameController.text and all lowercase
                    final userData = await AuthLocalDatasource().getUserData();
                    final model = DoctorRequestModel(
                      name: _nameController!.text,
                      email: _emailController!.text,
                      role: 'doctor',
                      status: 'active',
                      gender: _selectedGender!,
                      certification: _sertificationController!.text,
                      specializationId: _selectedSpecialization!.id,
                      telemedicineFee: telemedicRate,
                      chatFee: chatPremiumRate,
                      startTime: startTime,
                      endTime: endTime,
                      clinicId: userData!.data!.user!.clinicId!.toString(),
                      image: imageFile,
                    );
                    context
                        .read<AddDoctorBloc>()
                        .add(AddDoctorEvent.addDoctor(model));
                  },
                  label: 'Simpan',
                  fontSize: 16.0,
                );
              },
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                );
              },
            );
          },
        ),
      ),
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
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.white,
                      )),
                  SpaceWidth(context.deviceWidth * 0.2),
                  const Text(
                    "Tambah Doctor",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SpaceHeight(24),
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
                    "Nama Dokter",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  const SpaceHeight(
                    8,
                  ),
                  CustomTextField(
                    controller: _nameController!,
                    label: 'Masukkan nama Dokter',
                    textInputAction: TextInputAction.next,
                  ),
                  const SpaceHeight(
                    16,
                  ),
                  const Text(
                    "Email Dokter",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  const SpaceHeight(
                    8,
                  ),
                  CustomTextField(
                    controller: _emailController!,
                    label: 'Masukkan Email Dokter',
                    textInputAction: TextInputAction.next,
                  ),
                  const SpaceHeight(
                    16,
                  ),
                  const Text(
                    "Sertifikasi",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  const SpaceHeight(
                    8,
                  ),
                  CustomTextFieldHeight(
                    controller: _sertificationController!,
                    label: 'Masukkan Sertifikasi',
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
                    "Spesialisasi",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  const SpaceHeight(
                    8,
                  ),
                  BlocBuilder<GetSpecializationsBloc, GetSpecializationsState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        success: (data) {
                          _selectedSpecialization = data.data.firstWhere(
                              (element) =>
                                  element.id == _selectedSpecialization?.id,
                              orElse: () => data.data.first);
                          return DropdownButtonHideUnderline(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: DropdownButton<SpecializationModel>(
                                value: _selectedSpecialization,
                                hint: const Text(
                                  "Pilih Spesialisasi",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(
                                      0xff677294,
                                    ),
                                  ),
                                ),
                                isExpanded: true,
                                onChanged: (newValue) {
                                  if (newValue != null) {
                                    _selectedSpecialization = newValue;
                                    log('Selected Spesialisasi: ${_selectedSpecialization!.toMap()}');
                                    setState(() {});
                                  }
                                },
                                items: data.data
                                    .map<DropdownMenuItem<SpecializationModel>>(
                                        (SpecializationModel specialization) {
                                  return DropdownMenuItem<SpecializationModel>(
                                    value: specialization,
                                    child: Text(
                                      specialization.name,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color(
                                          0xff677294,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SpaceHeight(
                    16,
                  ),
                  const Text(
                    "Tarif Telemedis",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  const SpaceHeight(
                    8,
                  ),
                  CustomTextField(
                    controller: _telemedicRateController!,
                    label: 'Masukkan tarif telemedis ',
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      final int priceValue = value.tointegerFromText;
                      _telemedicRateController!.text =
                          priceValue.toString().currencyFormatRpV2;
                      _telemedicRateController!.selection =
                          TextSelection.fromPosition(TextPosition(
                              offset: _telemedicRateController!.text.length));
                    },
                  ),
                  const SpaceHeight(
                    16,
                  ),
                  const Text(
                    "Tarif Chat Premium",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  const SpaceHeight(
                    8,
                  ),
                  CustomTextField(
                    controller: _chatPremiumRateController!,
                    label: 'Masukkan tarif chat premium',
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      final int priceValue = value.tointegerFromText;
                      _chatPremiumRateController!.text =
                          priceValue.toString().currencyFormatRpV2;
                      _chatPremiumRateController!.selection =
                          TextSelection.fromPosition(TextPosition(
                              offset: _chatPremiumRateController!.text.length));
                    },
                  ),
                  const SpaceHeight(
                    16,
                  ),
                  const Text(
                    "Jadwal Praktik",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  const SpaceHeight(
                    8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => _selectTime(context, true),
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.schedule,
                                size: 24.0,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                _startTime != null
                                    ? _startTime!.format(context)
                                    : "Mulai",
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _selectTime(context, false),
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.schedule,
                                size: 24.0,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                _endTime != null
                                    ? _endTime!.format(context)
                                    : "Selesai",
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SpaceHeight(
                    16,
                  ),
                  ImagePickerWidget(
                    label: 'Image',
                    onChanged: (file) {
                      if (file == null) {
                        return;
                      }
                      imageFile = file;
                    },
                  ),
                  const SpaceHeight(24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
