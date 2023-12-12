import '/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorite_cubit.dart';
import 'favorite_states.dart';

// ignore: must_be_immutable
class FavoriteScreen extends StatelessWidget {
  var _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => goToHomeScreen(context: context),
      child: Scaffold(
          key: _scaffoldkey,
          drawer: MyDrawer(),
          appBar: myAppBar(
              context: context,
              titletext: "المفضلة",
              scaffoldkey: _scaffoldkey,
              menufunction: true,
              backbutton: false),
          body: BlocConsumer<FavoriteCubit, FavoriteStates>(
              listener: (context, state) {},
              builder: (context, state) {
                return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: DoctorsLIst(
                        doctorlist: FavoriteCubit.favoriteDataList));
              })),
    );
  }
}
