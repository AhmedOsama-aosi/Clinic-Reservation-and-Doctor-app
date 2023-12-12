import 'package:bloc/bloc.dart';
import '/models/models.dart';
import '/network/remote/cubit/database_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dataexampl.dart';
import 'doctors_States.dart';

class DoctorsCubit extends Cubit<DoctorsStates> {
  DoctorsCubit() : super(DoctorsInitialState());

  static DoctorsCubit get(context) => BlocProvider.of(context);

  static List<Doctor> doctorsDataList = [];
  static List favoriteDataList = [];
  static List<Doctor> doctorsInSelectedCategory = [];
  static List categories = [];
  List<Doctor> searchList = [];
  bool searching = false;
//  DoctorsItemsModel? doctorsItemsModel;
  static int? userId;
  static String? doctersDataStatus;

  void getDoctorsData() async {
    emit(DoctorsLoadingState());
    print("loading");
    doctersDataStatus = "loading";
    Future<dynamic> serverdata = DatabaseAPI().getDoctorsData();

    serverdata.then((value) {
      if (value is String) {
        emit(NoConnectionState());
        doctersDataStatus = "no connection";
      } else if (value is DoctorsItemsModel) {
        doctorsDataList = value.doctorlist;
        doctorsInSelectedCategory.addAll(doctorsDataList);
        doctersDataStatus = "done get data";
        emit(GetDoctorsDataState());
        print("done");
      }
    });
  }

  void getCategoriesData() {
    try {
      categories = eXAMBLcategories;
      // emit(GetDoctorsDataState());
    } catch (e) {}
  }

  void getDoctorsFromCategory(categoryid) {
    doctorsInSelectedCategory = doctorsDataList
        .where((doctor) => doctor.feildid == categoryid.toString())
        .toList();
    emit(ChangeCategoryState());
  }

  // void getDoctorsData() {
  //   try {
  //     emit(DoctorsLoadingState());
  //     doctorsItemsModel = DoctorsItemsModel.fromjson(eXAMBLdoctorslist);
  //     doctorsDataList = doctorsItemsModel!.doctorlist;
  //     doctors.addAll(doctorsDataList);
  //     emit(GetDoctorsDataState());
  //   } catch (e) {}
  // }

  void startsearch() {
    searching = true;
    emit(SearchState());
  }

  void endsearch() {
    searching = false;
    searchList = [];
    emit(DoctorsInitialState());
  }

  bool isSearchResultNull = false;
  void searchDoctors(String searchtext) {
    isSearchResultNull = false;
    searchList = [];

    if (doctorsDataList.length > 0) {
      searchList = doctorsDataList
          .where((element) => element.fullName.contains(searchtext))
          .toList();
      if (searchList.length == 0) {
        isSearchResultNull = true;
      }
      print(searchList.length);
      emit(SearchState());
    }
  }

  List<Doctor> search(
      {required List<Doctor> thelist, required String searchWords}) {
    List<Doctor> result = thelist
        .where((element) => element.fullName.contains(searchWords))
        .toList();
    return result;
  }

  void searchCloseButton(context, searchboxcontroller) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (searchboxcontroller.text == "") {
      searchboxcontroller.clear();
      FocusScope.of(context).requestFocus(FocusNode());
      endsearch();
    } else {
      searchboxcontroller.text = "";
    }
  }

  static const _nonselected = -1;
  int selectedCategoryindex = _nonselected;
  void selectcategory({categoryindex, categoryid}) {
    if (selectedCategoryindex == categoryindex) {
      selectedCategoryindex = _nonselected;
      doctorsInSelectedCategory.clear();
      doctorsInSelectedCategory.addAll(doctorsDataList);
      emit(DoctorsInitialState());
    } else {
      selectedCategoryindex = categoryindex;
      getDoctorsFromCategory(categoryid);
    }
  }
}
