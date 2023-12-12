import 'package:flutter/material.dart';
import '/models/models.dart';
import '/screens/doctor_profile/doctor_profile_cubit.dart';

abstract class DoctorProfileStates {
  int maxlines = 1;
  static Doctor? doctor;
  static String? getCalendarData;
  static var currentyear;
  static int? selecteddayindex;
  static int? selectedtimeindex;
  static var selectedDay;
  static DayTime? timeobject;
  static var selectedTime;
  String? monthText;
  static var selectedmonth;
  static SelectedAppiontment? appiontment;
  Color? backcolor;
  Color? forecolor;
  Color? favoritecolor;
}

class DoctorProfileInialState extends DoctorProfileStates {
  DoctorProfileInialState() {
    DoctorProfileStates.doctor = null;
    DoctorProfileStates.currentyear = null;
    DoctorProfileStates.selecteddayindex = null;
    DoctorProfileStates.selectedtimeindex = null;
    DoctorProfileStates.selectedDay = null;
    DoctorProfileStates.selectedmonth = null;
    DoctorProfileStates.appiontment = null;
    DoctorProfileStates.selectedTime = null;
    DoctorProfileStates.timeobject = null;
    // currentyear = null;
    // selectedDay = null;
    // selectedTime = null;
    // selectedmonth = null;
    // selecteddayindex = null;
    // selectedtimeindex = null;
  }
}

class SeeDoctorDetails extends DoctorProfileStates {
  SeeDoctorDetails({required int maxlinesValue}) {
    maxlines = maxlinesValue;
  }
}

class LoadingGetCalendarData extends DoctorProfileStates {
  LoadingGetCalendarData() {
    DoctorProfileStates.getCalendarData = "wating";
  }
}

class GetCalendarData extends DoctorProfileStates {
  GetCalendarData({
    doctorValue,
    currentyearValue,
  }) {
    DoctorProfileStates.doctor = doctorValue;
    DoctorProfileStates.currentyear = currentyearValue;
    monthText = DoctorProfileStates.currentyear.currentmonth!.text;
    DoctorProfileStates.selectedmonth =
        DoctorProfileStates.currentyear.currentmonth!;
    DoctorProfileStates.getCalendarData = "done";
  }
}

class Selectmonth extends DoctorProfileStates {
  Selectmonth(
      {monthTextValue,
      selectedmonthValue,
      selecteddayindexValue,
      selectedtimeindexValue,
      selectedDayValue,
      selectedTimeValue}) {
    monthText = monthTextValue;
    DoctorProfileStates.selectedmonth = selectedmonthValue;
    DoctorProfileStates.selecteddayindex = selecteddayindexValue;
    DoctorProfileStates.selectedtimeindex = selectedtimeindexValue;
    DoctorProfileStates.selectedDay = selectedDayValue;
    DoctorProfileStates.selectedTime = selectedTimeValue;
  }
}

class SelectDay extends DoctorProfileStates {
  SelectDay(
      {selecteddayindexValue,
      selectedDayValue,
      selectedtimeindexValue,
      selectedTimeValue}) {
    print(DoctorProfileStates.selectedmonth);
    DoctorProfileStates.selecteddayindex = selecteddayindexValue;

    ///for catch the value of selected widget
    DoctorProfileStates.selectedDay = selectedDayValue;

    ///for reset the value and color of laset selected time widget
    DoctorProfileStates.selectedtimeindex = selectedtimeindexValue;
    DoctorProfileStates.selectedTime = selectedTimeValue;
  }
}

class SelectTime extends DoctorProfileStates {
  SelectTime({
    selectedtimeindexValue,
    timeobjectValue,
    selectedTimeValue,
  }) {
    DoctorProfileStates.selectedtimeindex = selectedtimeindexValue;
    DoctorProfileStates.timeobject = timeobjectValue;
    DoctorProfileStates.selectedTime = selectedTimeValue;
  }
}

class MakeReservation extends DoctorProfileStates {}

class CloseState extends DoctorProfileStates {
  // CloseState(context) {
  //   DoctorProfileCubit.get(context).clearperviousvalues(context);
  // }
}

class SuccessReservation extends DoctorProfileStates {}
