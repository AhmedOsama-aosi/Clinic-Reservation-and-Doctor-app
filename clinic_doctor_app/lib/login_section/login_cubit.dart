import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../network/remote/cubit/database_cubit.dart';
import '../profile_section/user_account_cubit.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';
import '../shared/shared_preferance_api.dart';
import '../signin_section/signin_screen.dart';
import 'login_screen.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);
  static String result = "";
//  bool loginPasswordIsObscure = true;
  void goToSigninScreen(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Directionality(
              textDirection: TextDirection.rtl, child: SignInScreen())),
    );
    // islogin = false;
  }

  void changevisibilityState() {
    print(
        "From Cubit  state.loginPasswordIsObscure : ${ChangevisibilityState.loginPasswordIsObscure} ");

    emit(ChangevisibilityState(
        isobuscurevalue: !ChangevisibilityState.loginPasswordIsObscure));
  }

  void postLogInDetails(
      {required context, required email, required password}) async {
    Map<String, dynamic> posteddata = {
      "email": email,
      "password": password,
      "deviceToken": UserAccountCubit.deviceToken
    };
    emit(LoginLoadingState());
    Future<dynamic> serverdata =
        DatabaseAPI().postLoginDetails(postdata: posteddata);
    serverdata.then((value) {
      if (value is String) {
        if (value == "wrong password") {
          result = "wrong password";
          print("password is wrong");

          emit(LoginResultState());
        } else if (value == "this email not exist") {
          result = "this email not exist";
          emit(LoginResultState());
        } else if (value == "no connection") {
          print("no connection");
        }
      } else {
        print(value['id']);
        saveLogInDetails(email, password);
        UserAccountCubit.userId = value['id'];
        UserAccountCubit.userToken = value['token'];
        UserAccountCubit.firstname = value['firstname'];
        // UserAccountCubit.lastname = value['lastname'];
        UserAccountCubit.email = value['email'];
        UserAccountCubit.phone = value['phone'];
        UserAccountCubit.birthDate = value['birthdate'];
        UserAccountCubit.isMale = value['ismale'];
        UserAccountCubit.appointment = value['appointments'];
        DatabaseAPI().connectToSocketServer();
        final _appCubit = AppCubit.get(context);
        AppCubit.currentindex = 0;
        _appCubit.isLoggedin = true;
        _appCubit.emit(HomePage());

        result = "log in successfully";
      }
    });
  }

  void saveLogInDetails(email, password) {
    SharedPrefApi.set(key: "email", value: email, type: "string");
    SharedPrefApi.set(key: "pass", value: password, type: "string");
  }

  Future<Map> getLogInDetails() async {
    final email = await SharedPrefApi.get(key: "email", type: "string");
    final pass = await SharedPrefApi.get(key: "pass", type: "string");

    print(email);
    print(pass);
    return {"email": email, "pass": pass};
  }
}
