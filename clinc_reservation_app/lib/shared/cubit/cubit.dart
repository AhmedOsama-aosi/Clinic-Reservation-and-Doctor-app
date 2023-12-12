import 'package:clinc_reservation_app/screens/doctors_screen/doctors_screen.dart';
import 'package:clinc_reservation_app/screens/favorite/favorite_screen.dart';
import 'package:clinc_reservation_app/screens/reservations_screen/reservations_screen.dart';
import 'package:clinc_reservation_app/screens/user_account_section/user_account_screen.dart';
import 'package:clinc_reservation_app/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//import 'package:path_provider/path_provider.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  static late AppCubit appCubit;

  static int currentindex = 0;
  List<Widget> selecteditem = [
    DoctorsScreen(),
    FavoriteScreen(),
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
        emit(DoctorsPage());
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
