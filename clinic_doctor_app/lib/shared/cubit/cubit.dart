import 'package:clinic_doctor_app/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home_section/home_screen.dart';
import '../../profile_section/user_account_screen.dart';
import '../../reservations_section/reservations_screen.dart';
import '../../schedule_section/schedule_manegment_screen.dart';

//import 'package:path_provider/path_provider.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  static late AppCubit appCubit;

  static int currentindex = 0;
  List<Widget> selecteditem = [
    HomeScreen(),
    ScheduleManegmentScreen(),
    ReservationsScreen(),
    UserAccountScreen(),
  ];
  // static bool islight = false;
  bool isLoggedin = false;
  void signOut() {
    isLoggedin = false;
    emit(AppInitialState());
  }

  // void doBeforeStart() async {
  //   await DioHelper.init();
  //   if (Platform.isAndroid) {
  //     WidgetsFlutterBinding.ensureInitialized();
  //     await NotificationApi.init();
  //     NotificationApi.listenNotifications();
  //     NotificationApi.firebaseListenNotification();
  //   }
  // }

  void changeIndex(int index) {
    currentindex = index;

    switch (index) {
      case 0:
        emit(HomePage());
        break;
      case 1:
        emit(FavoritePage());
        break;
      case 2:
        emit(ReservationsPage());
        break;
      case 3:
        emit(UserAccountPage());
        break;
    }
  }
}
