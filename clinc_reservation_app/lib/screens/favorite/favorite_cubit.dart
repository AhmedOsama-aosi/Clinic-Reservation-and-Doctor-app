import 'package:clinc_reservation_app/network/remote/cubit/database_cubit.dart';
import '/models/models.dart';
import '/network/end_points.dart';
import '/network/remote/dio_helper.dart';
import '/screens/doctors_screen/doctors_cubit.dart';
import '/screens/favorite/favorite_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dataexampl.dart';

class FavoriteCubit extends Cubit<FavoriteStates> {
  FavoriteCubit() : super(FavoriteInitialState());

  static FavoriteCubit get(context) => BlocProvider.of(context);

  static List<Doctor> favoriteDataList = [];
  List favoritesdoctorsIds = [];

  Doctor? doctor;
  Color? favoritecolor;

  /// from server
  void getFavoriteData() async {
    print("loading favorite data");

    Future<dynamic> serverdata = DatabaseAPI().getFavoriteData();

    serverdata.then((value) {
      if (value is String) {
        print("no connection");
      } else if (value is List<dynamic>) {
        favoriteDataList = [];
        favoritesdoctorsIds = [];

        ///get the Favorite doctors ids by user id
        ///temporary assign user id from this method also
        _assignServerDataToLocalList(value);

        ///assgin doctors objects from doctorslist with thier ids in favoritesdoctorsIds
        ///and add them to favoriteDataList

        _getDoctorsObjectFromTheirIDsAndAddThem(favoritesdoctorsIds);

        print("done get favorite data");
      }
    });
  }

  void isdoctorinfavorite(Doctor doctor) {
    if (favoriteDataList.indexOf(doctor) != -1) {
      favoritecolor = Colors.red;
    } else {
      favoritecolor = Colors.grey[350];
    }
  }

  void changeFavoriteState(userindex, doctorid) {
    if (favoritecolor == Colors.red) {
      favoritecolor = Colors.grey[350];
      _removeDoctorFromFavorite(userindex, doctorid);
    } else {
      favoritecolor = Colors.red;
      _addDoctorToFavorite(userindex, doctorid);
    }
  }

  void _addDoctorToFavorite(userid, doctorid) {
    favoritesdoctorsIds.add(doctorid);
    patchFavoritedata(userid);
    //emit(EditFavoriteState(favoriteCubit: this, userid: userid));
    updateFavoriteData(userid);
  }

  void _removeDoctorFromFavorite(userid, doctorid) {
    favoritesdoctorsIds.remove(doctorid);
    // emit(EditFavoriteState(favoriteCubit: this, userid: userid));
    updateFavoriteData(userid);
  }

  void updateFavoriteData(userid) {
    patchFavoritedata(userid);

    emit(EditFavoriteState());
  }

  /// to server
  void patchFavoritedata(userid) async {
    Future<dynamic> serverdata = DatabaseAPI().patchFavoritedata(
        userid: userid, favoritesdoctorsIds: favoritesdoctorsIds);
    serverdata.then((value) {
      if (value is String) {
        print("no connection");
      } else {
        emit(PatchFavoriteDataState(this));

        print("done patch favorite data");
      }
    });
  }

  void _assignServerDataToLocalList(theResultData) {
    theResultData.forEach((doctorid) {
      favoritesdoctorsIds.add(doctorid);
    });
  }

  void _getDoctorsObjectFromTheirIDsAndAddThem(favoritesdoctorsIds) {
    /// we make temp list " _favoritesdoctorsIds" becuse we delet items from it to reduse time of searching
    /// so not affect on the real list "favoritesdoctorsIds"
    List _favoritesdoctorsIds = List.from(favoritesdoctorsIds);
    int numoffavoritesdoctors = _favoritesdoctorsIds.length;
    print(numoffavoritesdoctors);
    if (DoctorsCubit.doctorsDataList.isNotEmpty) {
      for (Doctor doctor in DoctorsCubit.doctorsDataList) {
        if (numoffavoritesdoctors != 0) {
          for (dynamic favDoctorId in _favoritesdoctorsIds) {
            if (doctor.id == favDoctorId) {
              favoriteDataList.add(doctor);
              _favoritesdoctorsIds.remove(favDoctorId);

              numoffavoritesdoctors -= 1;
              break;
            }
          }
        } else {
          break;
        }
      }
      emit(GetFavoriteDataState());
    } else {
      emit(ErrorGetFavoriteDataState());
    }
  }

  // void addDoctorToFavorite(index, doctorid) {
  //   eXAMBLuserfavorites[index]["favoritesdoctors"].add(doctorid);
  // }

  // void removeDoctorFromFavorite(index, doctorid) {
  //   eXAMBLuserfavorites[index]["favoritesdoctors"].remove(doctorid);
  // }

  // void getFavoriteData() {
  //   favoriteDataList = [];
  //   List favoritesdoctorsIds = [];

  //   ///get the Favorite doctors ids by user id
  //   for (var item in eXAMBLuserfavorites) {
  //     if (item["userid"] == 1) {
  //       item["favoritesdoctors"].forEach((doctorid) {
  //         favoritesdoctorsIds.add(doctorid);
  //       });
  //       DoctorsCubit.userindex = eXAMBLuserfavorites.indexOf(item);

  //       break;
  //     }
  //   }

  //   ///assgin doctors objects from doctorslist with thier ids in favoritesdoctorsIds
  //   ///and add them to favoriteDataList
  //   int numoffavoritesdoctors = favoritesdoctorsIds.length;
  //   if (DoctorsCubit.doctorsDataList.isNotEmpty) {
  //     for (Doctor doctor in DoctorsCubit.doctorsDataList) {
  //       if (numoffavoritesdoctors != 0) {
  //         for (int favDoctorId in favoritesdoctorsIds) {
  //           if (doctor.id == favDoctorId) {
  //             favoriteDataList.add(doctor);
  //             favoritesdoctorsIds.remove(favDoctorId);

  //             numoffavoritesdoctors -= 1;
  //             break;
  //           }
  //         }
  //       } else {
  //         break;
  //       }
  //     }
  //     emit(GetFavoriteDataState());
  //   } else {
  //     emit(ErrorGetFavoriteDataState());
  //   }
  // }
}
