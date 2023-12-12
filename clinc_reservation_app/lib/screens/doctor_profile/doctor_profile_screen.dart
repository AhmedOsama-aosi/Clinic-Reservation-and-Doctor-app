import '/models/models.dart';
import '/screens/confirm_reservation_screen/confirm_reservation_screen.dart';
import '/screens/doctor_profile/doctor_profile_components/avilable_times.dart';
import '/screens/doctor_profile/doctor_profile_states.dart';
import '/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'doctor_profile_components/calendar_card.dart';
import 'doctor_profile_components/doctor_card_info.dart';
import 'doctor_profile_cubit.dart';
//import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class DoctorProfileScreen extends StatelessWidget {
  DoctorProfileScreen(this.doctor, {this.operationId});
  Doctor doctor;
  var operationId;
  @override
  Widget build(BuildContext context) {
    print("i am before consumer in doctor profile");
    //DoctorProfileCubit.get(context).clearperviousvalues(context);

    // DoctorProfileCubit cubit = DoctorProfileCubit.get(context);

    //  if (cubit.currentyear == null) cubit.getcalendarData(doctor);

    return BlocProvider(
      create: (context) => DoctorProfileCubit(doctor),
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return false;
        },
        child: Scaffold(
          appBar: myAppBar(
            context: context,
            titletext: "تحديد موعد",
            menufunction: false,
            backbutton: true,
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  myTopBlueBackgroundRectangle(),
                  Expanded(
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overscroll) {
                        overscroll.disallowIndicator();
                        return true;
                      },
                      child:
                          BlocBuilder<DoctorProfileCubit, DoctorProfileStates>(
                              buildWhen: (previous, current) {
                        if (current is LoadingGetCalendarData ||
                            current is GetCalendarData) {
                          return true;
                        } else {
                          return false;
                        }
                      }, builder: (context, state) {
                        if (DoctorProfileStates.getCalendarData == "wating") {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 100,
                                ),
                                defaultTitle("حدد اليوم :"),

                                ///custom class to show the avilable days to select between them
                                MyCalendar(),

                                defaultTitle("المواعيد المتاحة :"),

                                ///custom class to show the avilable times for the selected date
                                AvilableTimes(),

                                defaultTitle("تم تحديد :"),

                                ///custom class to show what selected by the user
                                ShowSelectedAppiontment(),

                                ///custom button to check if day and time selected before going to confirm page
                                TheButton(
                                  operationId: operationId,
                                ),
                              ],
                            ),
                          );
                        }
                      }),
                    ),
                  )
                ],
              ),
              DoctorCardInfo(doctor),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TheButton extends StatelessWidget {
  TheButton({this.operationId});
  var operationId;
  @override
  Widget build(BuildContext context) {
    print("i am thebutton and i have been rebuilt");
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: defaultMaterialButton(
          text: "حجز",
          function: () {
            DoctorProfileCubit cubit = DoctorProfileCubit.get(context);
            cubit.reservation();
            if (DoctorProfileStates.selectedDay == null ||
                DoctorProfileStates.selectedTime == null) {
              final snackBar = SnackBar(
                  duration: Duration(seconds: 1, milliseconds: 5),
                  backgroundColor: Colors.red,
                  content: Text("يجب تحديد اليوم والميعاد"));

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                          value: cubit,
                          child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: ConfirmReservationScreen(
                                  operationId: operationId)),
                        )),
              );
            }
          }),
    );
  }
}

// ignore: must_be_immutable
class ShowSelectedAppiontment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorProfileCubit, DoctorProfileStates>(
        buildWhen: (previous, current) {
      if (current is Selectmonth ||
          current is SelectDay ||
          current is SelectTime) {
        return true;
      } else {
        return false;
      }
    }, builder: (context, state) {
      print(" i am show selected appiontment and have been rebuilt");
      DoctorProfileCubit cubit = DoctorProfileCubit.get(context);
      var _selecteddaty = DoctorProfileStates.selectedDay;
      return _selecteddaty == null
          ? Container()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                //   "يوم الخميس 21 أغسطس 2021 الساعة 6:30 م",
                "يوم ${_selecteddaty?.stringDay} ${_selecteddaty?.intDay} ${_selecteddaty?.stringMonth} ${_selecteddaty?.intYear} ${DoctorProfileStates.selectedTime == null ? "" : " الساعة " + DoctorProfileStates.selectedTime} ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            );
    });
  }
}
