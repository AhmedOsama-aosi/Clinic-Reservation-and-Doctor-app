import 'package:clinc_reservation_app/screens/notification_screen/notification_cubit.dart';
import 'package:clinc_reservation_app/screens/notification_screen/notification_screen.dart';

import '/styles/myicons.dart';

import '/shared/notification_api.dart';

import '/screens/doctors_screen/components/categories.dart';
import '/screens/doctors_screen/components/search.dart';
import '/screens/doctors_screen/doctors_States.dart';
import '/screens/doctors_screen/doctors_cubit.dart';
import '/shared/components/components.dart';
import '/styles/colors.dart';
import '/styles/images_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DoctorsScreen extends StatelessWidget {
  late DoctorsCubit doctorscubit;
  TextEditingController searchboxcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    doctorscubit = DoctorsCubit.get(context);
    var _scaffoldkey = GlobalKey<ScaffoldState>();
    return WillPopScope(
      onWillPop: () async {
        if (doctorscubit.searching) {
          doctorscubit.searchCloseButton(context, searchboxcontroller);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        key: _scaffoldkey,
        drawer: MyDrawer(),
        appBar: _buildAppBar(_scaffoldkey, context),
        body: Column(
          children: [
            _topbody(),
            //SearchBox(doctorscubit, searchboxcontroller),
            SizedBox(
              height: 5,
            ),
            _mainbody(),
          ],
        ),
      ),
    );
  }

  BlocBuilder<DoctorsCubit, DoctorsStates> _topbody() {
    return BlocBuilder<DoctorsCubit, DoctorsStates>(
      buildWhen: (previous, current) {
        if (current is SearchState || previous is SearchState) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        return SearchBox(doctorscubit, searchboxcontroller);
      },
    );
  }

  BlocBuilder<DoctorsCubit, DoctorsStates> _mainbody() {
    return BlocBuilder<DoctorsCubit, DoctorsStates>(
      // buildWhen: (previousState, currentState) {
      //   if (currentState is SearchState ||
      //       currentState is GetDoctorsDataState ||
      //       currentState is ChangeCategoryState ||
      //       currentState is DoctorsInitialState) {
      //     return true;
      //   } else {
      //     return false;
      //   }
      // },
      builder: (context, state) {
        if (state is SearchState) {
          return ShowSearchResult(doctorscubit);
        } else {
          return MainScreen(
            cubit: doctorscubit,
            state: state,
          );
        }
      },
    );
  }

  AppBar _buildAppBar(GlobalKey<ScaffoldState> _scaffoldkey, context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        "اسم التطبيق",
        style: TextStyle(color: primaryblue, fontWeight: FontWeight.bold),
      ),
      elevation: 0,
      actions: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Align(
                alignment: Alignment.center,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  splashRadius: 30,
                  icon: Icon(
                    Icons.notifications,
                    color: primaryblue,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Directionality(
                              textDirection: TextDirection.rtl,
                              child: NotificationScreen())),
                    );
                    // NotificationApi.showNotify();
                  },
                ),
              ),
            ),
            // Container(),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 30,
                height: 30,
                child: Card(
                  color: Colors.red,
                  shape: CircleBorder(),
                  child: Center(
                    child: Text(
                      "+9",
                      style: TextStyle(color: Colors.white),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 7,
        ),
      ],
      leading: IconButton(
          onPressed: () => _scaffoldkey.currentState!.openDrawer(),
          icon: MyIcons.menuButton()),
    );
  }
}

class MainScreen extends StatelessWidget {
  MainScreen({required this.cubit, required this.state});
  DoctorsCubit cubit;
  DoctorsStates state;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            defaultTitle("التخصصات"),
            CategoriesList(),
            ShowDoctors(state),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ShowDoctors extends StatelessWidget {
  ShowDoctors(this.state);
  DoctorsStates state;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        defaultTitle("الاطباء"),
        DoctorsCubit.doctersDataStatus == "no connection"
            ? Center(
                child: Text("لا يوجد اتصال بالانترنت"),
              )
            : DoctorsCubit.doctersDataStatus == "loading"
                ? Center(
                    child: CircularProgressIndicator(
                      color: primaryblue,
                    ),
                  )
                : DoctorsCubit.doctersDataStatus == "done get data"
                    ? DoctorsLIst(
                        doctorlist: DoctorsCubit.doctorsInSelectedCategory)
                    : Container(),
      ],
    );
  }
}

// ignore: must_be_immutable


