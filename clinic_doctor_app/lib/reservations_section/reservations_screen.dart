import 'package:flutter/widgets.dart';

import '../models/models.dart';
import '../shared/styles/colors.dart';
import '../shared/styles/images_path.dart';
import '/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'reservation_cubit.dart';
import 'reservation_states.dart';

class ReservationsScreen extends StatelessWidget {
  ReservationsScreen({Key? key}) : super(key: key);
  // List list = [
  //   {
  //     "name": "محمود السيد",
  //     "phone": "0165465",
  //     "time": "12:30ص",
  //     "date": "12/05/2022",
  //     "ismale": true,
  //     "status": "waiting"
  //   },
  //   {
  //     "name": "عبدالله خالد",
  //     "phone": "0165465",
  //     "time": "12:30ص",
  //     "date": "12/05/2022",
  //     "ismale": true,
  //     "status": "success"
  //   },
  //   {
  //     "name": "مروة علي",
  //     "phone": "0165465",
  //     "time": "12:30ص",
  //     "date": "12/05/2022",
  //     "ismale": false,
  //     "status": "canceled"
  //   },
  // ];
  Future<bool> goToHomeScreen({context}) async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // return BlocConsumer<DoctorProfileCubit, DoctorProfileStates>(
    //     listener: (context, state) {},
    //     builder: (context, state) {
    //       var cubit = DoctorProfileCubit.get(context);
    final _scaffoldkey = GlobalKey<ScaffoldState>();
    List<ReservationsModel> list;

    return WillPopScope(
      onWillPop: () => goToHomeScreen(context: context),
      child: Scaffold(
        key: _scaffoldkey,
        drawer: MyDrawer(),
        appBar: myAppBar(
            context: context,
            titletext: "الحجوزات",
            scaffoldkey: _scaffoldkey,
            menufunction: true,
            backbutton: false),
        body: Column(
          children: [
            Expanded(
              child: BlocProvider(
                create: (context) => ReservationCubit()..getReservationsData(),
                child: BlocConsumer<ReservationCubit, ReservationStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    list = ReservationCubit.reservationslist;
                    ReservationCubit.reservationCubit =
                        ReservationCubit.get(context);
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: list.length,
                      itemBuilder: (context, index) => statusCardInfo(context,
                          operationId: list[index].reservationId,
                          patient: list[index].patient,
                          date: list[index].date,
                          time: timeAfterCheckIsMorning(list[index]),
                          status: list[index].status),
                      // itemBuilder: (context, index) => statusCardInfo(
                      //   context,
                      //   patient: list[index],
                      // ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget statusCardInfo(context,
    {required operationId, required Map patient, date, time, status})
// Widget statusCardInfo(context, {required Map patient})
{
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Card(
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SvgPicture.asset(
                  //   checksvg(doctor),
                  //   height: 55,
                  //   width: 55,
                  // ),
                  SvgPicture.asset(
                    patient["ismale"] ? boy_svg : girl_svg,
                    height: 55,
                    width: 55,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: 20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "${patient["firstname"]} ${patient["lastname"]}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  defaultDetails(
                                    icon: Icons.phone,
                                    iconsize: 14,
                                    iconcolor: primaryblue,
                                    fontsize: 10,
                                    text: patient["phone"],
                                    // maxlines: cubit.maxlines
                                  ),
                                ],
                              ),
                            ),
                            StatusMessage(status),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _defaultIconTemplete(icon: Icons.today),
                            SizedBox(
                              width: 5,
                            ),
                            _defaulttextTemplete(text: date),
                            SizedBox(
                              width: 10,
                            ),
                            _defaultIconTemplete(icon: Icons.alarm),
                            SizedBox(
                              width: 5,
                            ),
                            _defaulttextTemplete(text: time),
                            Spacer()
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 2,
              color: Colors.grey,
            ),
            // ReservationCardButtons(
            //     patient: patient, status: status, operatoinid: operationId),
            ReservationCardButtons(
                patient: patient, status: status, operatoinid: operationId),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _defaultIconTemplete({required IconData icon}) {
  return Padding(
    padding: const EdgeInsets.only(top: 1.0),
    child: Icon(
      icon,
      size: 14,
      color: primaryblue,
    ),
  );
}

Widget _defaulttextTemplete({required String text}) {
  return Text(
    text,
    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
  );
}

// ignore: must_be_immutable
class ReservationCardButtons extends StatelessWidget {
  ReservationCardButtons(
      {required this.patient, required this.status, required this.operatoinid});
  String status;
  var operatoinid;
  Map patient;
  @override
  Widget build(conetex) {
    return BlocBuilder<ReservationCubit, ReservationStates>(
        builder: (context, state) {
      ReservationCubit _reservationCubit = ReservationCubit.get(context);

      switch (status) {
        case "waiting":
          return Row(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    color: primaryblue,
                    height: 45,
                    minWidth: double.infinity,
                    child: Text(
                      "موافقة",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      _reservationCubit.accpetReservation(operatoinid);
                      // ReservationCubit.reservationCubit = _reservationCubit;
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => Directionality(
                      //         textDirection: TextDirection.rtl,
                      //         child: DoctorProfileScreen(
                      //           doctor,
                      //           operationId: operatoinid,
                      //         )),
                      //   ),
                      // );
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: primaryblue, width: 1.5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    color: Colors.white,
                    height: 45,
                    minWidth: double.infinity,
                    onPressed: () {
                      _reservationCubit.cancelReservation(operatoinid);
                    },
                    child: Text(
                      "الغاء",
                      style: TextStyle(
                          color: primaryblue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          );
        case "success":
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: primaryblue, width: 1.5),
                borderRadius: BorderRadius.circular(6),
              ),
              color: Colors.white,
              height: 45,
              minWidth: double.infinity,
              onPressed: () {
                _reservationCubit.cancelReservation(operatoinid);
              },
              child: Text(
                "الغاء الحجز",
                style:
                    TextStyle(color: primaryblue, fontWeight: FontWeight.bold),
              ),
            ),
          );
        case "canceled":
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: primaryblue, width: 1.5),
                borderRadius: BorderRadius.circular(6),
              ),
              color: Colors.white,
              height: 45,
              minWidth: double.infinity,
              onPressed: () {
                _reservationCubit.deleteReservation(operatoinid);
              },
              child: Text(
                "حذف",
                style:
                    TextStyle(color: primaryblue, fontWeight: FontWeight.bold),
              ),
            ),
          );

        default:
          return Container();
      }
    });
  }
}

// ignore: must_be_immutable
class StatusMessage extends StatelessWidget {
  StatusMessage(this.status);
  String status;
  @override
  Widget build(context) {
    switch (status) {
      case "waiting":
        return Center(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xffD5EAFF)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: Text(
                "في انتظار الموافقة",
                style: TextStyle(
                    color: primaryblue,
                    fontWeight: FontWeight.bold,
                    fontSize: 9),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      case "success":
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 19.5),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xffC4FFDA)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: Text(
                "تم الحجز",
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 9),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      case "canceled":
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 18.5),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xffFFD5D5)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: Text(
                "تم الالغاء",
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 9),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );

      default:
        return Container();
    }
  }
}
