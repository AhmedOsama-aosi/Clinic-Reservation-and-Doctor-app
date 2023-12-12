import 'package:bloc/bloc.dart';
import '/network/remote/cubit/database_cubit.dart';
import '/screens/user_account_section/user_account_cubit.dart';
import '/screens/reservations_screen/reservation_cubit.dart';
import '/models/models.dart';
import '/screens/doctor_profile/doctor_profile_states.dart';
import '/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorProfileCubit extends Cubit<DoctorProfileStates> {
  DoctorProfileCubit(doctor) : super(DoctorProfileInialState()) {
    emit(LoadingGetCalendarData());
    getcalendarData(doctor);
  }

  static DoctorProfileCubit get(context) => BlocProvider.of(context);
  // Doctor? doctor;
  // var currentyear;
  // int? selecteddayindex;
  // int? selectedtimeindex;
  // var selectedDay;
  // DayTime? timeobject;
  // var selectedTime;
  // String? monthText;
  // var selectedmonth;
  // SelectedAppiontment? appiontment;
  // Color? backcolor;
  // Color? forecolor;
  // Color? favoritecolor;
  void doctordetails() {
    if (state.maxlines == 1) {
      emit(SeeDoctorDetails(maxlinesValue: 10));
    } else {
      emit(SeeDoctorDetails(maxlinesValue: 1));
    }
  }

  void getcalendarData(Doctor doctor) async {
    // doctor = doctor;
    // currentyear = CurrentYear(doctor);
    // monthText = state.currentyear.currentmonth!.text;
    // selectedmonth = state.currentyear.currentmonth!;

    Future<dynamic> serverdata =
        DatabaseAPI().getDoctorAppiontments(doctorId: doctor.id);

    serverdata.then((value) {
      if (value is String) {
        if (value == "doctor Appionment : some thing is worng") {
          print("doctor Appionment : some thing is worng");
        } else {
          print("no connection");
        }
      } else if (value is Map) {
        doctor.setappiontment(value);
        print("Done get Appiontment data");
        emit(GetCalendarData(
            doctorValue: doctor, currentyearValue: CurrentYear(doctor)));
      }
    });
  }

  void nextmonth() {
    // monthText = state.currentyear.nexttmonth!.text;
    // selectedmonth = state.currentyear.nexttmonth!;
    // selecteddayindex = null;
    // selectedtimeindex = null;
    // selectedDay = null;
    // selectedTime = null;
    emit(Selectmonth(
        monthTextValue: DoctorProfileStates.currentyear.nexttmonth!.text,
        selectedmonthValue: DoctorProfileStates.currentyear.nexttmonth!,
        selectedDayValue: null,
        selectedTimeValue: null,
        selecteddayindexValue: null,
        selectedtimeindexValue: null));
  }

  void perviousmonth() {
    // monthText = state.currentyear.currentmonth!.text;
    // selectedmonth = state.currentyear.currentmonth!;
    // selecteddayindex = null;
    // selectedtimeindex = null;
    // selectedDay = null;
    // selectedTime = null;
    emit(Selectmonth(
        monthTextValue: DoctorProfileStates.currentyear.currentmonth!.text,
        selectedmonthValue: DoctorProfileStates.currentyear.currentmonth!,
        selectedDayValue: null,
        selectedTimeValue: null,
        selecteddayindexValue: null,
        selectedtimeindexValue: null));
  }

  void selectDay(currentitem, dayobject) {
    if (currentitem != DoctorProfileStates.selecteddayindex) {
      emit(SelectDay(
          selecteddayindexValue: currentitem,
          selectedDayValue: dayobject,
          selectedtimeindexValue: null,
          selectedTimeValue: null));
      // ///for changes colors of selected widget
      // state.selecteddayindex = currentitem;

      // ///for catch the value of selected widget
      // state.selectedDay = dayobject;

      // ///for reset the value and color of laset selected time widget
      // state.selectedtimeindex = null;
      // state.selectedTime = null;
    } else {
      emit(SelectDay(selecteddayindexValue: null, selectedDayValue: null));

      // state.selecteddayindex = null;
      // state.selectedDay = null;
    }
  }

  void selectTime(currentitem, timeobject) {
    if (currentitem != DoctorProfileStates.selectedtimeindex) {
      emit(SelectTime(
          selectedTimeValue: timeobject.time + timeobject.type,
          selectedtimeindexValue: currentitem,
          timeobjectValue: timeobject));

      // state.selectedtimeindex = currentitem;
      // state.timeobject = timeobject;
      // state.selectedTime = timeobject.time + timeobject.type;
    } else {
      emit(SelectTime(
        selectedTimeValue: null,
        selectedtimeindexValue: null,
      ));
      // state.selectedtimeindex = null;
      // state.selectedTime = null;
    }
  }

  Varialbles setvalues(item, String type) {
    var selected;
    if (type == "day") {
      selected = DoctorProfileStates.selecteddayindex;
    } else if (type == "time") {
      selected = DoctorProfileStates.selectedtimeindex;
    }

    if (item == selected) {
      return Varialbles(
          clicked: true, backcolor: primaryblue, forecolor: Colors.white);
    } else {
      return Varialbles(clicked: false, backcolor: null, forecolor: null);
    }
  }

  void reservation() {
    if (DoctorProfileStates.selectedDay == null ||
        DoctorProfileStates.selectedTime == null) {
      DoctorProfileStates.appiontment = null;
    } else {
      DoctorProfileStates.appiontment = SelectedAppiontment(
          intDay: DoctorProfileStates.selectedDay.intDay,
          intMonth: DoctorProfileStates.selectedDay.intMonth,
          intYear: DoctorProfileStates.selectedDay.intYear,
          stringDay: DoctorProfileStates.selectedDay.stringDay,
          stringMonth: DoctorProfileStates.selectedDay.stringMonth,
          intTime: DoctorProfileStates.selectedTime);
    }
  }

  // void clearperviousvalues(context) {
  //   state.currentyear = null;
  //   state.selectedDay = null;
  //   state.selectedTime = null;
  //   state.selectedmonth = null;

  //   state.selecteddayindex = null;
  //   state.selectedtimeindex = null;
  //   print("the values has been cleared");
  //   // Navigator.pop(context);
  // }

  void postReservationsData(Map<String, dynamic> data) async {
    Map<String, dynamic> posteddata = {
      "userId": UserAccountCubit.userId,
      "doctorId": data["doctorId"],
      "date": data["date"],
      "time": data["time"],
      "isMoring": data["isMoring"],
    };
    Future<dynamic> serverdata =
        DatabaseAPI().postReservationData(postdata: posteddata);
    serverdata.then((value) {
      if (value is String) {
        print("no connection");
      } else {
        print("Done post reservation");
      }
    });
  }

  void editReservationData({required Map<String, dynamic> patcheddata}) async {
    Future<dynamic> serverdata =
        DatabaseAPI().editReservationData(postdata: patcheddata);
    serverdata.then((value) {
      if (value is String) {
        print("no connection");
      } else {
        ReservationCubit.reservationCubit!.getReservationsData();
        print("Done edit reservation");
      }
    });
  }
}

class Varialbles {
  Varialbles({this.backcolor, this.forecolor, required this.clicked});
  Color? backcolor;
  Color? forecolor;
  bool clicked;
}

class SelectedAppiontment {
  String? stringDay;
  int? intDay;
  String? stringMonth;
  int? intMonth;
  int? intYear;
  String? intTime;

  SelectedAppiontment({
    required this.stringDay,
    required this.intDay,
    required this.stringMonth,
    required this.intMonth,
    required this.intYear,
    required this.intTime,
  });
}
