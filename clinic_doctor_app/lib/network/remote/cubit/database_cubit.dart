import '../../../profile_section/user_account_cubit.dart';
import '../../../reservations_section/reservation_cubit.dart';
import '/models/models.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import '/network/end_points.dart';
import '../dio_helper.dart';

part 'database_state.dart';

class DatabaseAPI {
  bool internetConnected = false;
  // dynamic userId = "615e8ec07ce6c3bed63cc038";
  // dynamic token =
  //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im1oQGdtYWlsLmNvbSIsImlkIjoiNjE1M2I1MTY0ODFmMjM4N2JhNzFiOTM1IiwiaWF0IjoxNjMyODc2Mzc2fQ.fUowFlPUoo6jMMwxm24qJ7noB2cyAkEMSRYne7v-LV4";
  // // Future checkConnection() async {
  //   try {
  //     final result = await InternetAddress.lookup(TESTCONNECTIONURL);
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       print('connected');
  //       internetConnected = true;
  //     }
  //   } on SocketException catch (_) {
  //     print('not connected');
  //     internetConnected = false;
  //   }
  // }
  late io.Socket socket;
  void connectToSocketServer() {
    try {
      socket = io.io(
          BASEURL,
          io.OptionBuilder()
              .setQuery({"userId": UserAccountCubit.userId})
              .setTransports(['websocket']) // for Flutter or Dart VM
              .disableAutoConnect() // disable auto-connection
              .build());
      socket.connect();
      socket.on('reservation', handlerReservationListen);
    } catch (e) {
      print(e);
    }
  }

  void handlerReservationListen(data) {
    if (ReservationCubit.reservationCubit != null) {
      ReservationCubit.reservationCubit?.getReservationsData();
    }
  }

  Future checkConnection() async {
    try {
      serverdata = await DioHelper.getdata(url: '/');
      internetConnected = true;
    } catch (e) {
      BASEURL = 'http://192.168.43.40:3000/';
      try {
        DioHelper.init();
        serverdata = await DioHelper.getdata(url: '/');
        internetConnected = true;
      } catch (e) {
        internetConnected = false;
      }
    }
  }

  var serverdata;

  Future<dynamic> postSignInDetails({required postdata}) async {
    await checkConnection().then((value) async {
      if (internetConnected) {
        serverdata =
            await DioHelper.postdata(url: SIGNIN, posteddata: postdata);
        print("done post signIn data to server");
      }
    });
    if (internetConnected) {
      if (serverdata.data["message"] == "sign in successful") {
        return serverdata.data["message"];
      } else if (serverdata.data["message"] == "error in password") {
        return "error in password";
      } else if (serverdata.data["message"] == "this email is already exist") {
        return "this email is already exist";
      }
    } else {
      return "no connection";
    }
  }

  Future<dynamic> postLoginDetails({required postdata}) async {
    await checkConnection().then((value) async {
      if (internetConnected) {
        serverdata = await DioHelper.postdata(url: LOGIN, posteddata: postdata);
        print("done post email and password data to server");
      }
    });
    if (internetConnected) {
      if (serverdata.data["message"] == "doctor logged in") {
        return serverdata.data["doctor"];
      } else if (serverdata.data["message"] == "password is wrong") {
        return "wrong password";
      } else if (serverdata.data["message"] == "this email not exist") {
        return "this email not exist";
      }
    } else {
      return "no connection";
    }
  }

  // Future<dynamic> getDoctorsData() async {
  //   await checkConnection().then((value) async {
  //     if (internetConnected) {
  //       serverdata = await DioHelper.getdata(url: DOCTORSDATA);
  //       print("done get doctors data from server");
  //     }
  //   });
  //   if (internetConnected) {
  //     if (serverdata.data["message"] == "get doctors successful") {
  //       return DoctorsItemsModel.fromjson(
  //           List<Map<String, dynamic>>.from(serverdata.data["result"]));
  //     } else if (serverdata.data["message"] == "error can\'t get doctors") {
  //       print("can\'t get doctors data");

  //       return "some thing is worng";
  //     }
  //   } else {
  //     return "no connection";
  //   }
  // }

  Future<dynamic> getDoctorAppiontments({doctorId}) async {
    await checkConnection().then((value) async {
      if (internetConnected) {
        serverdata = await DioHelper.getdata(
            url: GETDOCTORAPPIONTMENT,
            query: {"doctorId": doctorId},
            headers: {"Authorization": UserAccountCubit.userToken});
        print("done get Appiontments from server");
      }
    });
    if (internetConnected) {
      if (serverdata.data["message"] == "get appiontment successful") {
        print(serverdata.data["result"]);
        return serverdata.data["result"];
      } else if (serverdata.data["message"] ==
          "error get appiontment for doctor") {
        print("error Appiontments not get");

        return "doctor Appionment : some thing is worng";
      }
    } else {
      return "no connection";
    }
  }

  Future<dynamic> getFavoriteData() async {
    await checkConnection().then((value) async {
      if (internetConnected) {
        serverdata = await DioHelper.getdata(
            url: GETFAVORITESSDATA,
            query: {"userId": UserAccountCubit.userId},
            headers: {"Authorization": UserAccountCubit.userToken});
        print("done get favorites data from server");
      }
    });
    if (internetConnected) {
      if (serverdata.data["message"] == "get favoritedoctros successful") {
        print(serverdata.data["result"]);
        return serverdata.data["result"];
      } else if (serverdata.data["message"] ==
          "error favoritedoctros not get") {
        print("error favoritedoctros not get");

        return "some thing is worng";
      }
    } else {
      return "no connection";
    }
  }

  Future<dynamic> patchFavoritedata(
      {required userid, required favoritesdoctorsIds}) async {
    await checkConnection().then((value) async {
      if (internetConnected) {
        serverdata = await DioHelper.patchdata(
            url: UPDATEFAVORITESSDATA,
            query: {"userId": UserAccountCubit.userId},
            posteddata: {"favoritedoctors": favoritesdoctorsIds});
        print("done patch favorites data to server");
      }
    });
    if (internetConnected) {
      if (serverdata.data["message"] == "favorite doctors has been updated") {
        print(serverdata.data["result"]);
        return serverdata.data["result"];
      } else if (serverdata.data["message"] ==
          "error favorite doctors not updated ") {
        print("error favoritedoctros not updated");

        return "some thing is worng";
      }
    } else {
      return "no connection";
    }
  }

  Future<dynamic> getReservationsData() async {
    try {
      print("getting reservatons");
      await checkConnection().then((value) async {
        if (internetConnected) {
          serverdata = await DioHelper.getdata(
              url: GETRESERVATIONSDATA,
              query: {"doctorId": UserAccountCubit.userId},
              headers: {"Authorization": UserAccountCubit.userToken});
          print("done get Resrvations data from server");
        }
      });
      print("end getting reservatons");
      if (internetConnected) {
        return List<Map<String, dynamic>>.from(serverdata.data);
      } else {
        return "no connection";
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> postReservationData({required postdata}) async {
    try {
      await checkConnection().then((value) async {
        if (internetConnected) {
          serverdata = await DioHelper.postdata(
              url: POSTRESERVATION,
              headers: {"authorization": UserAccountCubit.userToken},
              posteddata: postdata);
          print("done post Resrvation data from server");
        }
      });
      if (internetConnected) {
        if (serverdata.data["message"] == "reservation sent successfully") {
          return serverdata.data["id"];
        } else if (serverdata.data["message"] == "error reservation not sent") {
          print("can\'t post reservation");
        }
      } else {
        return "no connection";
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> accpetReservationData({required operationid}) async {
    try {
      await checkConnection().then((value) async {
        if (internetConnected) {
          serverdata = await DioHelper.patchdata(
              url: ACCEPTRESERVATION,
              headers: {"authorization": UserAccountCubit.userToken},
              posteddata: {"reservationId": operationid});
          print("done cancel Resrvation data from server");
        }
      });
      if (internetConnected) {
        return serverdata.data;
      } else {
        return "no connection";
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> cancelReservation({required operationid}) async {
    try {
      await checkConnection().then((value) async {
        if (internetConnected) {
          serverdata = await DioHelper.patchdata(
              url: CANCELRESERVATION,
              headers: {"authorization": UserAccountCubit.userToken},
              posteddata: {"reservationId": operationid});
          print("done cancel Resrvation data from server");
        }
      });
      if (internetConnected) {
        return serverdata.data;
      } else {
        return "no connection";
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> deleteReservation({required operationid}) async {
    await checkConnection().then((value) async {
      if (internetConnected) {
        serverdata = await DioHelper.patchdata(
            url: DELETERESERVATION,
            headers: {"authorization": UserAccountCubit.userToken},
            posteddata: {"reservationId": operationid});
        print("done delete Resrvation data from server");
      }
    });
    if (internetConnected) {
      return serverdata.data;
    } else {
      return "no connection";
    }
  }

  // Future<DoctorsItemsModel> getDoctorsData() async {
  //   DoctorsItemsModel data = await convertDoctorsData();

  //   return data;
  // }

  // Future<dynamic> convertDoctorsData() async {
  //   Response<dynamic> data = await fetchDoctorsData();
  //   print("done convert data");

  //   return DoctorsItemsModel.fromjson(
  //       List<Map<String, dynamic>>.from(data.data));
  // }

  // Future<Response<dynamic>> fetchDoctorsData() async {
  //   Response<dynamic> data = await DioHelper.getdata(url: DOCTORSDATA);
  //   print("done get data");

  //   return data;
  // }
}
