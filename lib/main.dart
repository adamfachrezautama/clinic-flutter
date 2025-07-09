import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'core/constants/colors.dart';
import 'data/datasources/auth_remote_datasource.dart';
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
              GetSpecialationsBloc(SpecialationRemoteDatasource()),
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
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  //check role
                  if (snapshot.data!.data!.user!.role == 'doctor') {
                    return const DoctorHomePage();
                  } else if (snapshot.data!.data!.user!.role == 'admin') {
                    return const AdminMainPage();
                  }
                  return const HomePage();
                } else {
                  return const DoctorHomePage();
                }
              }
              return const OnboardingPage();
            }),
      ),
    );
  }
}
