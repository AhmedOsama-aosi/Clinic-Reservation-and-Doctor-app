import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_account_states.dart';

class UserAccountCubit extends Cubit<UserAccountStates> {
  UserAccountCubit() : super(UserAccountInitalState());
  static UserAccountCubit get(context) => BlocProvider.of(context);
  // static  dynamic userId = "615e8ec07ce6c3bed63cc038";
  // static dynamic userToken =
  //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im1oQGdtYWlsLmNvbSIsImlkIjoiNjE1M2I1MTY0ODFmMjM4N2JhNzFiOTM1IiwiaWF0IjoxNjMyODc2Mzc2fQ.fUowFlPUoo6jMMwxm24qJ7noB2cyAkEMSRYne7v-LV4";
  // static dynamic deviceToken =
  //     "f3ILLKyzTP-FzPc-u_PPVR:APA91bG6SgLlo4at2tpRRZFHaIBfO7lqM1FAOFrCiaj1gz4jcUfY1yhYuB5oVy8JuJOr8cRUMyXma2QD_uXd1z1axbmEL18xiVgcwzsrUGipH58HrfdOhyuBWQAR0eqIS5rwZiPfgIb2";
  static late dynamic userId;
  static late dynamic userToken;
  static late dynamic deviceToken;
  static late dynamic firstname;
  static dynamic lastname = '';
  static dynamic email = '';
  static dynamic phone = '';
  static dynamic birthDate = '';
  static dynamic isMale = '';
}
