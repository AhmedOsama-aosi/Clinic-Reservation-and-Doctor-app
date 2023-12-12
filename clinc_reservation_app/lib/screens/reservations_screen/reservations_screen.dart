import '/models/models.dart';
import '/screens/doctor_profile/doctor_profile_screen.dart';
import '/screens/reservations_screen/reservation_cubit.dart';
import '/screens/reservations_screen/reservation_states.dart';
import '/shared/components/components.dart';
import '/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReservationsScreen extends StatelessWidget {
  const ReservationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return BlocConsumer<DoctorProfileCubit, DoctorProfileStates>(
    //     listener: (context, state) {},
    //     builder: (context, state) {
    //       var cubit = DoctorProfileCubit.get(context);
    var _scaffoldkey = GlobalKey<ScaffoldState>();
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
                child: BlocBuilder<ReservationCubit, ReservationStates>(
                  builder: (context, state) {
                    list = ReservationCubit.reservationslist;
                    ReservationCubit.reservationCubit =
                        ReservationCubit.get(context);
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: list.length,
                      itemBuilder: (context, index) => statusCardInfo(context,
                          operationId: list[index].reservationId,
                          doctor: list[index].doctor!,
                          date: list[index].date,
                          time: timeAfterCheckIsMorning(list[index]),
                          status: list[index].status),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget statusCardInfo(context,
    {required operationId, required Doctor doctor, date, time, status}) {
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
                  SvgPicture.asset(
                    checksvg(doctor),
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
                                    doctor.fullName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  defaultDetails(
                                    icon: Icons.medication,
                                    iconsize: 14,
                                    iconcolor: primaryblue,
                                    fontsize: 10,
                                    text: doctor.description,
                                    // maxlines: cubit.maxlines
                                  ),
                                  defaultDetails(
                                    icon: Icons.room,
                                    iconsize: 14,
                                    iconcolor: primaryblue,
                                    fontsize: 10,
                                    text: doctor.address,
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
            ReservationCardButtons(
                doctor: doctor, status: status, operatoinid: operationId),
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
      {required this.doctor, required this.status, required this.operatoinid});
  String status;
  var operatoinid;
  Doctor doctor;
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
                      "تعديل الحجز",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      ReservationCubit.reservationCubit = _reservationCubit;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Directionality(
                              textDirection: TextDirection.rtl,
                              child: DoctorProfileScreen(
                                doctor,
                                operationId: operatoinid,
                              )),
                        ),
                      );
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
