import 'package:clinc_reservation_app/shared/cubit/cubit.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeBottomNavBarState extends AppStates {}

class AppCreatDataBaseState extends AppStates {}

class AppOpendDataBaseState extends AppStates {}

class AppInsertDataBaseState extends AppStates {}

class AppGetDataBaseState extends AppStates {}

class AppUpdateDataBaseState extends AppStates {}

class AppCreateClint extends AppStates {}

//pages

class DoctorsPage extends AppStates {}

class FavoritePage extends AppStates {}

class ReservationsPage extends AppStates {}

class UserAccountPage extends AppStates {}
