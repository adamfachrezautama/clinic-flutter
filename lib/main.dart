import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clinicapp/presentation/admin/doctor/blocs/add_doctor/add_doctor_bloc.dart';
import 'package:flutter_clinicapp/presentation/admin/doctor/blocs/delete_doctor/delete_doctor_bloc.dart';
import 'package:flutter_clinicapp/presentation/admin/doctor/blocs/get_specialization/get_specializations_bloc.dart';
import 'package:flutter_clinicapp/presentation/admin/doctor/blocs/update_doctor/update_doctor_bloc.dart';
import 'package:flutter_clinicapp/presentation/admin/home/blocs/get_clinic/get_clinic_bloc.dart';
import 'package:flutter_clinicapp/presentation/admin/home/blocs/get_orders_clinic/get_orders_clinic_bloc.dart';
import 'package:flutter_clinicapp/presentation/admin/home/pages/admin_main_page.dart';
import 'package:flutter_clinicapp/presentation/auth/blocs/check_user/check_user_bloc.dart';
import 'package:flutter_clinicapp/presentation/auth/blocs/create_user/create_user_bloc.dart';
import 'package:flutter_clinicapp/presentation/auth/blocs/get_user_email/get_user_email_bloc.dart';
import 'package:flutter_clinicapp/presentation/auth/blocs/login/login_bloc.dart';
import 'package:flutter_clinicapp/presentation/auth/blocs/login_google/login_google_bloc.dart';
import 'package:flutter_clinicapp/presentation/auth/blocs/logout/logout_bloc.dart';
import 'package:flutter_clinicapp/presentation/auth/blocs/update_google_id/update_google_id_bloc.dart';
import 'package:flutter_clinicapp/presentation/auth/blocs/update_user/update_user_bloc.dart';
import 'package:flutter_clinicapp/presentation/auth/pages/onboarding_page.dart';
import 'package:flutter_clinicapp/presentation/chat/blocs/bloc/chat_expired_bloc.dart';
import 'package:flutter_clinicapp/presentation/chat/blocs/create_order/create_order_bloc.dart';
import 'package:flutter_clinicapp/presentation/chat/blocs/get_doctors/get_doctors_bloc.dart';
import 'package:flutter_clinicapp/presentation/chat/blocs/get_doctors_active/get_doctors_active_bloc.dart';
import 'package:flutter_clinicapp/presentation/chat/blocs/xendit_callback/xendit_callback_bloc.dart';
import 'package:flutter_clinicapp/presentation/doctor/chat/blocs/active_orders/active_orders_bloc.dart';
import 'package:flutter_clinicapp/presentation/doctor/chat/blocs/inactive_orders/inactive_orders_bloc.dart';
import 'package:flutter_clinicapp/presentation/doctor/history/blocs/history_order_doctor/history_order_doctor_bloc.dart';
import 'package:flutter_clinicapp/presentation/doctor/home/pages/doctor_home_page.dart';
import 'package:flutter_clinicapp/presentation/history/blocs/get_orders_patient/get_orders_patient_bloc.dart';
import 'package:flutter_clinicapp/presentation/home/pages/home_page.dart';
import 'package:flutter_clinicapp/presentation/telemedis/blocs/add_agora_call/add_agora_call_bloc.dart';
import 'package:flutter_clinicapp/presentation/telemedis/blocs/agora_token/agora_token_bloc.dart';
import 'package:flutter_clinicapp/presentation/telemedis/blocs/get_agor_calls/get_agor_calls_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'core/constants/colors.dart';
import 'data/datasources/agora_remote_datasource.dart';
import 'data/datasources/auth_local_datasource.dart';
import 'data/datasources/auth_remote_datasource.dart';
import 'data/datasources/doctor_remote_datasource.dart';
import 'data/datasources/order_remote_datasource.dart';
import 'data/datasources/specialization_remote_datasource.dart';
import 'data/datasources/user_remote_datasource.dart';
import 'data/models/response/login_response_model.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(); // WAJIB: load .env di awal
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  OneSignal.Debug.setLogLevel(OSLogLevel.debug);
  // NOTE: Replace with your own app ID from https://www.onesignal.com
  OneSignal.initialize('d6036950-6428-49c7-bd09-98565dd3f5c0');
  OneSignal.Notifications.requestPermission(true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.primary,
      statusBarBrightness: Brightness.dark,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => LoginGoogleBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => CheckUserBloc(UserRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => CreateUserBloc(UserRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => GetUserEmailBloc(UserRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => UpdateGoogleIdBloc(UserRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => UpdateUserBloc(UserRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => GetDoctorsBloc(DoctorRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => AddDoctorBloc(DoctorRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => UpdateDoctorBloc(DoctorRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => DeleteDoctorBloc(DoctorRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => GetOrdersClinicBloc(OrderRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => CreateOrderBloc(OrderRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => GetAgorCallsBloc(AgoraRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => AddAgoraCallBloc(AgoraRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => ActiveOrdersBloc(OrderRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => InactiveOrdersBloc(OrderRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => HistoryOrderDoctorBloc(OrderRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => GetDoctorsActiveBloc(DoctorRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => GetOrdersPatientBloc(OrderRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) =>
              GetSpecializationsBloc(SpecializationRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => XenditCallbackBloc(OrderRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => GetClinicBloc(DoctorRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => ChatExpiredBloc(),
        ),
        BlocProvider(
          create: (context) => AgoraTokenBloc(AgoraRemoteDatasource()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: AppBarTheme(
            color: AppColors.white,
            elevation: 0,
            titleTextStyle: GoogleFonts.poppins(
              color: AppColors.primary,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
            iconTheme: const IconThemeData(
              color: AppColors.primary,
            ),
          ),
        ),
          home: FutureBuilder<LoginResponseModel?>(
            future: AuthLocalDatasource().getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(body: Center(child: CircularProgressIndicator()));
              }

              if (snapshot.hasData && snapshot.data?.data?.user != null) {
                final role = snapshot.data!.data!.user!.role;

                if (role == 'doctor') {
                  return const DoctorHomePage();
                } else if (role == 'admin') {
                  return const AdminMainPage();
                } else {
                  return const HomePage();
                }
              }

              // Jika belum login / tidak ada data
              return const OnboardingPage();
            },
          )
      ),
    );
  }
}
