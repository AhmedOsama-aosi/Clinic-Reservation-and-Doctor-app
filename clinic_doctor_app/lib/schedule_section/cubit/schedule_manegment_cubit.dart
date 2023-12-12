import 'package:clinic_doctor_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../profile_section/user_account_cubit.dart';
import '../../shared/styles/colors.dart';
part 'schedule_manegment_state.dart';

class ScheduleManegmentCubit extends Cubit<ScheduleManegmentState> {
  int? selectedtimeindex;
  var selectedmonth;
  CurrentYear? currentYear;
  CalendarDay? theDay;
  DayTime? theTime;
  int? selecteddayindex;
  bool isDayAvilable = false;
  List mapListOfTime = [];
  List<DayTime> timelist = [];
  ScheduleManegmentCubit() : super(ScheduleManegmentInitial()) {
    Doctor doctor = Doctor();
    doctor.appiontment = UserAccountCubit.appointment;
    getcalendarData(doctor);

    List list = [];
    List newlist = [];
    doctor.appiontment.forEach((key, value) {
      list = value["times"];
      for (var item in list) {
        mapListOfTime.add(item);
      }
    });

    mapListOfTime.forEach((element) {
      bool add = true;
      for (int i = 0; i < newlist.length; i++) {
        if (element["time"] == newlist[i]["time"]) {
          add = false;
          break;
        }
      }
      if (add) {
        newlist.add(element);
      }
    });
    mapListOfTime = newlist;
    mapListOfTime.forEach((element) {
      timelist.add(DayTime(element["time"], element["isMorning"], false));
    });
  }
  static ScheduleManegmentCubit get(context) => BlocProvider.of(context);
  void showCurrentDoctorAppointments() {
    Map appointments = {};
    for (int i = 0; i < currentYear!.currentmonth!.dayslist.length; i++) {
      Map dayMap = {};
      CalendarDay? theDay = currentYear!.currentmonth!.dayslist[i];
      if (theDay.timeList!.isNotEmpty) {
        String dayDate =
            "${theDay.intDay}/${theDay.intMonth}/${theDay.intYear}";
        dayMap = {"isAvailable": theDay.isactivated, "times": []};

        List times = [];
        for (int i = 0; i < theDay.timeList!.length; i++) {
          DayTime time = theDay.timeList![i];

          times.add({
            "time": time.time,
            "isMorning": time.isMorning,
            "isAvailable": time.isAvailable
          });
        }
        dayMap.update("times", (value) => times);
        appointments.addAll({dayDate: dayMap});
      }
    }

    print(appointments);
  }

  void nextmonth() {
    selectedmonth = currentYear!.nexttmonth!;
    selecteddayindex = null;
    emit(Selectmonth());
  }

  void perviousmonth() {
    selectedmonth = currentYear!.currentmonth!;
    selecteddayindex = null;
    emit(Selectmonth());
  }

  void getcalendarData(doctor) {
    currentYear = CurrentYear(doctor);
    selectedmonth = currentYear!.currentmonth!;
  }

  void selectDay(currentitem, dayobject) {
    if (currentitem != selecteddayindex) {
      selecteddayindex = currentitem;
      theDay = selectedmonth
          .dayslist[currentitem - selectedmonth.fristDayIndexInWeek];
      bool notfound = true;
      timelist.forEach((element) {
        //element.isAvailable = false;
        for (DayTime item in theDay!.timeList!) {
          if (element.time == item.time &&
              element.isMorning == item.isMorning) {
            element.isAvailable = item.isAvailable;
            notfound = false;
            break;
          }
        }
        if (notfound) {
          element.isAvailable = false;
        }
      });

      emit(SelectDay());
    }
  }

  changeDayStatus(bool? value) {
    isDayAvilable = value!;
    theDay?.isactivated = isDayAvilable;
    emit(ScheduleManegmentInitial());
  }

  changeTimeStatus(bool? value, DayTime _item) {
    bool notFound = true;
    _item.isAvailable = value!;

    emit(ScheduleManegmentInitial());
  }

  Varialbles setvalues(item, String type) {
    var selected;
    if (type == "day") {
      selected = selecteddayindex;
    } else if (type == "time") {
      selected = selectedtimeindex;
    }

    if (item == selected) {
      return Varialbles(
          clicked: true, backcolor: primaryblue, forecolor: Colors.white);
    } else {
      return Varialbles(clicked: false, backcolor: null, forecolor: null);
    }
  }
}

class Varialbles {
  Varialbles({this.backcolor, this.forecolor, required this.clicked});
  Color? backcolor;
  Color? forecolor;
  bool clicked;
}

class Doctor {
  Map appiontment = {
    "13/4/2022": {
      "isAvailable": true,
      "times": [
        {"time": "4:30", "isMorning": false, "isAvailable": true},
        {"time": "5:30", "isMorning": false, "isAvailable": true},
        {"time": "6:30", "isMorning": false, "isAvailable": true},
      ],
    },
    "16/4/2022": {
      "isAvailable": true,
      "times": [
        {"time": "4:30", "isMorning": false, "isAvailable": true},
        {"time": "5:30", "isMorning": false, "isAvailable": true},
        {"time": "6:30", "isMorning": false, "isAvailable": true},
      ],
    },
    "18/4/2022": {
      "isAvailable": true,
      "times": [
        {"time": "4:30", "isMorning": false, "isAvailable": true},
        {"time": "5:30", "isMorning": false, "isAvailable": false},
        {"time": "6:30", "isMorning": false, "isAvailable": true},
      ],
    },
    "19/4/2022": {
      "isAvailable": true,
      "times": [
        {"time": "4:30", "isMorning": false, "isAvailable": true},
        {"time": "5:30", "isMorning": false, "isAvailable": true},
        {"time": "6:30", "isMorning": false, "isAvailable": true},
        {"time": "7:30", "isMorning": false, "isAvailable": true},
      ],
    },
  };
}
