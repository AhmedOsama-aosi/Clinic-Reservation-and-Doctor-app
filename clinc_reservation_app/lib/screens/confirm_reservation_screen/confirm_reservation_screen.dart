import '/screens/doctor_profile/doctor_profile_cubit.dart';
import '/screens/doctor_profile/doctor_profile_states.dart';
import '/shared/components/components.dart';
import '/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConfirmReservationScreen extends StatelessWidget {
  ConfirmReservationScreen({this.operationId});
  var operationId;
  bool clicked = false;
  String datevalue = "";
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: myAppBar(
              context: context,
              titletext: "تاكيد الحجز",
              menufunction: false,
              backbutton: true,
              backbuttonFunction: () {
                Navigator.pop(context);
                if (clicked) Navigator.pop(context);
              }),
          body: Stack(
            children: [
              Column(
                children: [
                  myTopBlueBackgroundRectangle(heightvalue: 100),
                  Expanded(
                    child: SingleChildScrollView(
                      child:
                          BlocBuilder<DoctorProfileCubit, DoctorProfileStates>(
                        builder: (context, state) {
                          DoctorProfileCubit cubit =
                              DoctorProfileCubit.get(context);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 150,
                              ),
                              clicked
                                  ? Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        "تم ارسال طلب الحجز ",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        color: primaryblue,
                                        height: 52,
                                        minWidth: double.infinity,
                                        onPressed: () {
                                          cubit.reservation();
                                          var _appiontment =
                                              DoctorProfileStates.appiontment;
                                          datevalue =
                                              "${_appiontment?.stringDay} ${_appiontment?.intDay} ${_appiontment?.stringMonth} ${_appiontment?.intYear}";

                                          operationId == null
                                              ? cubit.postReservationsData({
                                                  "doctorId":
                                                      DoctorProfileStates
                                                          .doctor!.id,
                                                  "date": datevalue,
                                                  "time":
                                                      "${DoctorProfileStates.timeobject!.time}",
                                                  "isMoring":
                                                      DoctorProfileStates
                                                          .timeobject!
                                                          .isMorning,
                                                })
                                              : cubit.editReservationData(
                                                  patcheddata: {
                                                      "reservationId":
                                                          operationId,
                                                      "date": datevalue,
                                                      "time":
                                                          "${DoctorProfileStates.timeobject!.time}",
                                                      "isMoring":
                                                          DoctorProfileStates
                                                              .timeobject!
                                                              .isMorning,
                                                    });
                                          clicked = true;
                                          cubit.emit(SuccessReservation());
                                        },
                                        child: Text(
                                          "تأكيد",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              ReservationCardInfo(),
            ],
          ),
        ),
        onWillPop: () async {
          Navigator.pop(context);
          if (clicked) Navigator.pop(context);
          //  if (clicked) state = CloseState(context);
          return false;
        });
  }
}

class ReservationCardInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Center(
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          checksvg(DoctorProfileStates.doctor!),
                          height: 55,
                          width: 55,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${DoctorProfileStates.doctor!.fullName}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 2,
                color: Colors.grey,
              ),
              BlocBuilder<DoctorProfileCubit, DoctorProfileStates>(
                buildWhen: (previous, current) {
                  if (current is SeeDoctorDetails) {
                    return true;
                  } else {
                    return false;
                  }
                },
                builder: (context, state) {
                  DoctorProfileCubit cubit = DoctorProfileCubit.get(context);
                  var _appiontment = DoctorProfileStates.appiontment;
                  return GestureDetector(
                    onTap: () {
                      cubit.doctordetails();
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        defaultDetails(
                            icon: Icons.medication,
                            iconcolor: primaryblue,
                            text: "${DoctorProfileStates.doctor!.description}",
                            maxlines: state.maxlines),
                        SizedBox(
                          height: 7,
                        ),
                        defaultDetails(
                            icon: Icons.room,
                            iconcolor: primaryblue,
                            text: "${DoctorProfileStates.doctor!.address}",
                            maxlines: state.maxlines),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: 2,
                              child: defaultDetails(
                                  icon: Icons.today,
                                  iconcolor: primaryblue,
                                  text:
                                      "${_appiontment?.stringDay} ${_appiontment?.intDay} ${_appiontment?.stringMonth} ${_appiontment?.intYear}",
                                  fontWeight: FontWeight.bold,
                                  maxlines: state.maxlines),
                            ),
                            Expanded(
                              child: defaultDetails(
                                  icon: Icons.alarm,
                                  iconcolor: primaryblue,
                                  text: "${_appiontment?.intTime}",
                                  fontWeight: FontWeight.bold,
                                  maxlines: state.maxlines),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
