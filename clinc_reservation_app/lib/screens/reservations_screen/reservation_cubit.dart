import 'package:clinc_reservation_app/models/models.dart';
import 'package:clinc_reservation_app/network/remote/cubit/database_cubit.dart';
import 'package:clinc_reservation_app/screens/doctors_screen/doctors_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'reservation_states.dart';

class ReservationCubit extends Cubit<ReservationStates> {
  ReservationCubit() : super(ReservationInitalState());

  static ReservationCubit get(context) => BlocProvider.of(context);
  static ReservationCubit? reservationCubit;
  static List<ReservationsModel> reservationslist = [];

  void getReservationsData() async {
    Future<dynamic> serverdata = DatabaseAPI().getReservationsData();

    serverdata.then((value) {
      if (value is String) {
        print("no connection");
      } else if (value is List<Map<String, dynamic>>) {
        reservationslist = [];
        ReservationsModel model;

        value.forEach((resrvation) {
          model = ReservationsModel.fromjson(resrvation);
          for (Doctor doctor in DoctorsCubit.doctorsDataList) {
            if (doctor.id == model.doctorid) {
              model.doctor = doctor;
              break;
            }
          }

          reservationslist.insert(0, model);
        });
        emit(ReservationInitalState());
        print("Done get resrvation data");
      }
    });
  }

  void deleteReservation(id) async {
    Future<dynamic> serverdata =
        DatabaseAPI().deleteReservation(operationid: id);
    serverdata.then((value) {
      if (value is String) {
        print("no connection");
      } else {
        emit(ReservationDeleteState());
        print("Done delete reservation");
        getReservationsData();
      }
    });
  }

  void cancelReservation(id) async {
    Future<dynamic> serverdata =
        DatabaseAPI().cancelReservation(operationid: id);
    serverdata.then((value) {
      if (value is String) {
        print("no connection");
      } else {
        emit(ReservationCancelState());
        print("Done cancel reservation");
        getReservationsData();
      }
    });
  }

  // void getReservationsData() {
  //   reservationslist = [];
  //   ReservationsModel model;
  //   eXAMBLclintreservations.forEach((resrvation) {
  //     model = ReservationsModel.fromjson(resrvation);
  //     for (Doctor doctor in DoctorsCubit.doctorsDataList) {
  //       if (doctor.id == model.doctorid) {
  //         model.doctor = doctor;
  //         break;
  //       }
  //     }

  //     reservationslist.add(model);
  //   });
  // }
}
