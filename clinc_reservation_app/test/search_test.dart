import 'package:clinc_reservation_app/models/models.dart';
import 'package:clinc_reservation_app/screens/doctors_screen/doctors_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("test search function", () {
    List<Doctor> thelist = [
      Doctor.fromMap({"name": "د.وفاء عطية", "isMale": false, "feildid": "2"}),
      Doctor.fromMap({"name": "د.وحيد فريد", "isMale": true, "feildid": "1"}),
      Doctor.fromMap({"name": "د.صلاح فتحي", "isMale": true, "feildid": "4"}),
    ];
    DoctorsCubit doctorsCubit = DoctorsCubit();
    List<Doctor> result =
        doctorsCubit.search(thelist: thelist, searchWords: "فتحي");
    // print(result[0].fullName);
    expect(result[0].fullName, "د.صلاح فتحي");
  });
}
