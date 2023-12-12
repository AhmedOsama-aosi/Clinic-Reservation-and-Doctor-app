import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../doctors_States.dart';
import '/shared/components/components.dart';
import '/styles/colors.dart';
import 'package:flutter/material.dart';

import '../doctors_cubit.dart';

// ignore: must_be_immutable
class SearchBox extends StatelessWidget {
  SearchBox(this.cubit, this.searchboxcontroller);
  DoctorsCubit cubit;
  TextEditingController searchboxcontroller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Card(
            elevation: 3.5,
            shadowColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              height: 40,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  _searchIconButton(),
                  _searchField(),
                  cubit.searching ? _closeIconButton(context) : Container(),
                ],
              ),
            )));
  }

  Widget _closeIconButton(BuildContext context) {
    return IconButton(
      splashRadius: 15,
      onPressed: () {
        cubit.searchCloseButton(context, searchboxcontroller);
      },
      icon: Icon(
        Icons.close,
        color: primaryblue,
        size: 25,
      ),
    );
  }

  Widget _searchIconButton() {
    return Container(
      height: 25,
      width: 25,
      child: IconButton(
        padding: EdgeInsets.zero,
        splashRadius: 15,
        onPressed: () {
          cubit.startsearch();
          //  searchbox.requestFocus();
        },
        icon: Icon(
          Icons.search,
          color: primaryblue,
          //size: 25,
        ),
      ),
    );
  }

  Widget _searchField() {
    return Expanded(
      child: TextField(
        textAlign: TextAlign.start,
        controller: searchboxcontroller,

        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          //alignLabelWithHint: true,
          contentPadding: EdgeInsets.only(bottom: 8, left: 6, right: 6),
          // alignLabelWithHint: true,
          hintMaxLines: 1,
          hintText: "بحث...",
        ),
        // onSubmitted: (value) {
        //   searchbox.unfocus();
        // },
        onTap: () {
          if (cubit.searching == false) cubit.startsearch();
        },

        onChanged: (value) {
          cubit.searchDoctors(value);
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class ShowSearchResult extends StatelessWidget {
  ShowSearchResult(this.cubit);
  DoctorsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            defaultTitle("نتائج البحث"),
            cubit.isSearchResultNull
                ? buildNoResultFound()
                : DoctorsLIst(
                    doctorlist: cubit.searchList,
                  ),
          ],
        ),
      ),
    );
  }

  Widget buildNoResultFound() {
    return Center(
      child: Text(
        "لا يوجد نتائج",
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
