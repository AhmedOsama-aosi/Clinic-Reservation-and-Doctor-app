abstract class DoctorsStates {}

class DoctorsInitialState extends DoctorsStates {}

class DoctorsLoadingState extends DoctorsStates {}

class GetDoctorsDataState extends DoctorsStates {}

class ChangeCategoryState extends DoctorsStates {}

class SearchState extends DoctorsStates {}

class NoConnectionState extends DoctorsStates {}

class ErrorGetDoctorsDataState extends DoctorsStates {
  String? error;
  ErrorGetDoctorsDataState(this.error);
}
