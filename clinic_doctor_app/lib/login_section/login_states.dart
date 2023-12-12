abstract class LoginStates {}

class LoginInitialState extends LoginStates {
  LoginInitialState() {
    ChangevisibilityState.loginPasswordIsObscure = true;
  }
}

class ChangevisibilityState extends LoginStates {
  ChangevisibilityState({isobuscurevalue}) {
    loginPasswordIsObscure = isobuscurevalue;
  }
  static bool loginPasswordIsObscure = false;
}

class LoginResultState extends LoginStates {}

class LoginLoadingState extends LoginStates {}
