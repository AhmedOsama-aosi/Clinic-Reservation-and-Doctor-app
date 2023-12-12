import 'package:clinic_doctor_app/shared/cubit/states.dart';
import 'package:clinic_doctor_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_section/login_screen.dart';
import 'network/remote/dio_helper.dart';
import 'shared/cubit/cubit.dart';

void main() async {
  await DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      // statusBarColor: Colors.white, //or set color with: Color(0xFF0000FF)
      statusBarColor: Color(0x00FFFFFF),
      // Status bar brightness (optional)
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.light, // For iOS (dark icons)
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()),
      ],
      child: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          AppCubit _appcubit = AppCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Doctor App',
            theme: ThemeData(
              primaryColor: primaryblue,
              primarySwatch: myMaterial_blue,
              appBarTheme: const AppBarTheme(
                // systemOverlayStyle: SystemUiOverlayStyle.light
                systemOverlayStyle: SystemUiOverlayStyle(
                  //statusBarIconBrightness: Brightness.dark,
                  statusBarColor: Colors.white,
                  // statusBarBrightness: Brightness.light,
                  statusBarIconBrightness:
                      Brightness.dark, // For Android (dark icons)
                  statusBarBrightness: Brightness.light, // For iOS (dark icons)
                ),
                backgroundColor: Colors.white,
              ),
              backgroundColor: Colors.white,
              scaffoldBackgroundColor: Colors.white,
            ),
            home: Directionality(
                textDirection: TextDirection.rtl,
                child: _appcubit.isLoggedin
                    ? _appcubit.selecteditem[AppCubit.currentindex]
                    : LoginScreen()),
            // Directionality(
            //     textDirection: TextDirection.rtl, child: ReservationsScreen()),
          );
        },
      ),
    );
  }
}
