import '/network/remote/cubit/database_cubit.dart';
import '/screens/signin_screen/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'signin_states.dart';

class SigninCubit extends Cubit<SigninStates> {
  SigninCubit() : super(SignInInitalState());
  static SigninCubit get(context) => BlocProvider.of(context);

  bool signinPasswordvisibile = true;
  bool signinConfirmPasswordvisibile = true;

  // void goToSigninScreen(context) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => Directionality(
  //             textDirection: TextDirection.rtl, child: SignInScreen())),
  //   );

  //   emit(SigninInitalState());
  // }

  void postSignInDetails(context,
      {required firstName,
      required lastName,
      required birthdate,
      required isMale,
      required email,
      required phoneNumber,
      required password}) async {
    Map<String, dynamic> posteddata = {
      "firstname": firstName,
      "lastname": lastName,
      "birthdate": birthdate,
      "ismale": isMale,
      "email": email,
      "phone": phoneNumber,
      "password": password,
      //   "deviceToken": UserAccountCubit.deviceToken
    };
    emit(SignInLoadingState());
    Future<dynamic> serverdata =
        DatabaseAPI().postSignInDetails(postdata: posteddata);
    serverdata.then((value) {
      if (value == 'sign in successful') {
        goToLoginScreen(context);
        emit(SignInResultState());
        print('sign in successful');
      } else if (value == 'error in password') {
        print('!!!! error in password');
      } else if (value == 'this email is already exist') {
        print('this email is already exist');
      } else {
        print('!!!!!! sign in error');
      }
    });
  }

  void goToLoginScreen(context) {
    Navigator.pop(context);
  }

  void changevisibilityState(String textField) {
    switch (textField) {
      case "signin pass":
        signinPasswordvisibile = !signinPasswordvisibile;
        break;
      case "signin confirm pass":
        signinConfirmPasswordvisibile = !signinConfirmPasswordvisibile;
        break;
    }

    emit(ChangevisibilityState());
  }
}
