part of 'database_cubit.dart';

abstract class DatabaseStates extends Equatable {
  const DatabaseStates();

  @override
  List<Object> get props => [];
}

class DatabaseInitial extends DatabaseStates {}

//class NoConnectionState extends DatabaseStates {}

class DataBaseDoctorsLoadingState extends DatabaseStates {}

class DataBaseDoctorsGetDataSuccessState extends DatabaseStates {}

class DataBaseDoctorsGetDataErrorState extends DatabaseStates {}

// class DatabaseInitial extends DatabaseStates {}
// class DatabaseInitial extends DatabaseStates {}
// class DatabaseInitial extends DatabaseStates {}
// class DatabaseInitial extends DatabaseStates {}
// class DatabaseInitial extends DatabaseStates {}
