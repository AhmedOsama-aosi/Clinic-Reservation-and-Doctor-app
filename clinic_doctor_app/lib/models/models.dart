// class DoctorsItemsModel {
//   List<Doctor> doctorlist = [];
//   DoctorsItemsModel.fromjson(List<Map<String, dynamic>> json) {
//     json.forEach((value) {
//       doctorlist.add(Doctor.fromMap(value));
//     });
//   }
// }

// class Doctor {
//   //attributes = fields in table
//   var _doctorId;
//   late String _fullName;
//   late bool _isMale;
//   String? _picture;
//   late var _feildid;
//   String? _description;
//   String? _address;
//   dynamic _appiontment;
//   // String? _doctorfield;
//   // String? _address;
//   // String? _notes;

//   Doctor.fromMap(Map<String, dynamic> json) {
//     _doctorId = json['id'];
//     _fullName = json['name'];
//     _isMale = json['isMale'];
//     _picture = json['picture'];
//     _feildid = json['feildid'];
//     _description = json['description'];
//     _address = json['address'];
//   }

//   Map<String, dynamic> toMap() => {
//         'id': _doctorId,
//         'name': _fullName,
//         'isMale': _isMale,
//         'picture': _picture,
//         'feildid': _feildid,
//         'description': _description,
//         'address': _address,
//         // 'Address': _address,
//         // 'Notes': _notes,
//       };

//   // Doctor(dynamic doctor) {
//   //   _doctorId = doctor['teacher_cpr'];
//   //   _fullName = doctor['teacher_name'];
//   //   _phoneNumber = doctor['teacher_tel'];
//   //   _address = doctor['Address'];
//   //   _notes = doctor['Notes'];
//   // }
//   dynamic get id => _doctorId!;
//   String get fullName => _fullName;
//   bool get isMale => _isMale;
//   String? get picture => _picture;
//   dynamic get feildid => _feildid;
//   String get description => _description!;
//   String get address => _address!;
//   dynamic get appiontment => _appiontment;
//   setappiontment(appiontment) => _appiontment = appiontment;
//   // String get address => _address!;
//   // String get notes => _notes!;
// }

import '../schedule_section/cubit/schedule_manegment_cubit.dart';

class CurrentYear {
  CalendarMonth? currentmonth;
  CalendarMonth? nexttmonth;
  CurrentYear(doctor) {
    var year = DateTime.now().year;
    var month = DateTime.now().month;

    this.currentmonth = CalendarMonth(doctor,
        year: year,
        value: month,
        start: DateTime(year, month),
        end: DateTime(year, month + 1));
    this.nexttmonth = CalendarMonth(doctor,
        year: month == 12 ? year + 1 : year,
        value: month == 12 ? 1 : month + 1,
        start: DateTime(year, month + 1),
        end: DateTime(year, month + 2));
  }
}

class CalendarMonth {
  int? year;
  String? text;
  dynamic value;
  int? numofdays;
  int? fristDayIndexInWeek;
  Map monthlist = {
    1: "يناير",
    2: "فبراير",
    3: "مارس",
    4: "ابريل",
    5: "مايو",
    6: "يونيه",
    7: "يوليه",
    8: "اغسطس",
    9: "سبتمبر",
    10: "اكتوبر",
    11: "نوفمبر",
    12: "ديسمبر",
  };
  List<CalendarDay> dayslist = [];
  Map dayIndexInCalendar = {
    1: 2,
    2: 3,
    3: 4,
    4: 5,
    5: 6,
    6: 0,
    7: 1,
  };
  CalendarMonth(
    doctor, {
    int? year,
    int? value,
    DateTime? start,
    DateTime? end,
  }) {
    this.year = year;
    this.value = value;
    this.text = monthlist[value];
    this.numofdays = end!.difference(start!).inDays;
    this.dayslist = [];
    for (var i = 1; i <= this.numofdays!; i++) {
      dayslist.add(CalendarDay(doctor,
          value: i,
          weekday: DateTime(DateTime.now().year, this.value, i).weekday,
          nummonth: this.value,
          stringmonth: this.text,
          numyear: this.year));
      this.fristDayIndexInWeek = dayIndexInCalendar[dayslist[0].intWeekDay];
    }
  }
}

class CalendarDay {
  int? intDay;
  int? intWeekDay;
  String? stringDay;
  int? intMonth;
  String? stringMonth;
  int? intYear;
  bool isactivated = true;
  List<DayTime>? timeList = [];
  Map daylist = {
    1: "الاثنين",
    2: "الثلاثاء",
    3: "الاربعاء",
    4: "الخميس",
    5: "الجمعة",
    6: "السبت",
    7: "الاحد",
  };

  CalendarDay(Doctor doctor, {value, weekday, nummonth, stringmonth, numyear}) {
    intDay = value;
    intWeekDay = weekday;
    stringDay = daylist[weekday];
    stringMonth = stringmonth;
    intMonth = nummonth;
    intYear = numyear;

    String date = "$intDay/$intMonth/$intYear";
    try {
      // Map currentobject = eXAMBLdayslist["${doctor.id}"][date];
      Map currentobject = doctor.appiontment[date];
      if (currentobject["status"] == "avilable") {
        for (var item in currentobject["times"]) {
          timeList!.add(
              DayTime(item["time"], item["isMorning"], item["isAvailable"]));
        }
      } else {
        isactivated = false;
      }

      // dayshastimes[date][0].foreach((item) {
      //   this
      //       .timeList!
      //       .add(DayTime(item["time"], item["isMorning"], item["isAvailable"]));
      // });
    } catch (e) {
      //print(e.toString());
    }
    if (timeList!.isEmpty) {
      isactivated = false;
    }
  }
}

class DayTime {
  String? time;
  bool isMorning;
  bool isAvailable;
  String? type;
  DayTime(this.time, this.isMorning, this.isAvailable) {
    if (isMorning) {
      type = "ص";
    } else {
      type = "م";
    }
  }
}

class ReservationsModel {
  late dynamic _reservationId;
  late String _status;
  late dynamic _patientId;
  late dynamic _doctorId;
  late String _date;
  late String _time;
  late bool _isMoring;
  late Map _patient;
  ReservationsModel.fromjson(Map<String, dynamic> json) {
    _reservationId = json["reservationId"];
    _status = json["status"];
    _patientId = json["userId"];
    _doctorId = json["doctorId"];
    _date = json["date"];
    _time = json["time"];
    _isMoring = json["isMoring"];
    _patient = json["user"];
  }
  dynamic get reservationId => _reservationId;
  String get status => _status;
  dynamic get patientid => _patientId;
  dynamic get doctorid => _doctorId;
  String get date => _date;
  String get time => _time;
  bool get isMoring => _isMoring;
  Map get patient => _patient;
}
