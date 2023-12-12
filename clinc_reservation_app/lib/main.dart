import 'dart:io';
import 'package:flutter/services.dart';
import '/network/remote/dio_helper.dart';
import '/screens/doctors_screen/doctors_cubit.dart';
import '/screens/favorite/favorite_cubit.dart';
import '/screens/login_folder/login_screen.dart';
import '/shared/bloc_observer.dart';
import '/shared/cubit/cubit.dart';
import '/shared/cubit/states.dart';
import '/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/reservations_screen/reservation_cubit.dart';
import 'shared/notification_api.dart';

void main() async {
  BlocOverrides.runZoned(
    () {
      // Use cubits...
    },
    blocObserver: MyBlocObserver(),
  );
  await DioHelper.init();
  if (Platform.isAndroid) {
    WidgetsFlutterBinding.ensureInitialized();
    await NotificationApi.init();
    NotificationApi.listenNotifications();
    NotificationApi.firebaseListenNotification();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => DoctorsCubit()
                ..getDoctorsData()
                ..getCategoriesData()),
          BlocProvider(create: (context) => FavoriteCubit()..getFavoriteData()),
          BlocProvider(create: (context) => AppCubit()),
        ],
        child: BlocConsumer<AppCubit, AppStates>(
            listener: (BuildContext context, AppStates state) {},
            builder: (BuildContext context, AppStates state) {
              AppCubit _appcubit = AppCubit.get(context);
              print("appcubit init");
              AppCubit.appCubit = _appcubit;

              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Clinic Reservation',
                theme: ThemeData(
                  primaryColor: primaryblue,
                  primarySwatch: myMaterial_blue,
                  appBarTheme: AppBarTheme(
                    // systemOverlayStyle: SystemUiOverlayStyle.light
                    systemOverlayStyle: SystemUiOverlayStyle(
                      //statusBarIconBrightness: Brightness.dark,
                      statusBarColor: Colors.white,
                      // statusBarBrightness: Brightness.light,
                      statusBarIconBrightness:
                          Brightness.dark, // For Android (dark icons)
                      statusBarBrightness:
                          Brightness.light, // For iOS (dark icons)
                    ),
                    backgroundColor: Colors.white,
                  ),
                  backgroundColor: Colors.white,
                  scaffoldBackgroundColor: Colors.white,
                ),
                home: Directionality(
                    textDirection: TextDirection.rtl,
                    // child: appcubit.selecteditem[appcubit.currentindex]
                    child: _appcubit.isLoggedin
                        ? _appcubit.selecteditem[AppCubit.currentindex]
                        : LoginScreen()),
              );
            }));
  }
}
