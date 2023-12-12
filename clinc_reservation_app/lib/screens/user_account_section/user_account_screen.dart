import '/shared/components/components.dart';
import '/shared/cubit/cubit.dart';
import '/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_account_cubit.dart';

import 'user_account_states.dart';

class UserAccountScreen extends StatelessWidget {
  var _scaffoldkey = GlobalKey<ScaffoldState>();

  ///for edititng next future
  // var formkey = GlobalKey<FormState>();
  // var userEmail = TextEditingController();
  // var userPhone = TextEditingController();
  // var userName = TextEditingController();
  // var userPassword = TextEditingController();
  // var confirmUserPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    const double distancebetweenfields = 8;
    return BlocProvider(
      create: (context) => UserAccountCubit(),
      child: BlocConsumer<UserAccountCubit, UserAccountStates>(
          listener: (BuildContext context, UserAccountStates state) {},
          builder: (BuildContext context, UserAccountStates state) {
            UserAccountCubit signincubit = UserAccountCubit.get(context);
            return WillPopScope(
              onWillPop: () async {
                AppCubit.get(context).changeIndex(0);
                return false;
              },
              child: Scaffold(
                key: _scaffoldkey,
                drawer: MyDrawer(),
                appBar: myAppBar(
                    context: context,
                    titletext: "الحساب",
                    scaffoldkey: _scaffoldkey,
                    menufunction: true,
                    backbutton: true,
                    backbuttonFunction: () {
                      AppCubit.get(context).changeIndex(0);
                    }),
                body: Stack(
                  children: [
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(children: [
                        SizedBox(
                          height: 150,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 18.0),
                          child: Row(
                            children: [
                              Text(
                                "بيانات الحساب",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Spacer(),
                              Text(
                                "تعديل",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: primaryblue),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Card(
                              elevation: 5,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18.0, vertical: 8.0),
                                child: Column(
                                  children: [
                                    userInfoRow(
                                        title: "الاسم الاول",
                                        data: UserAccountCubit.firstname),
                                    userInfoRow(
                                        title: "الاسم الاخير",
                                        data: UserAccountCubit.lastname),
                                    userInfoRow(
                                        title: "رقم الهاتف",
                                        data: UserAccountCubit.phone),
                                    userInfoRow(
                                        title: "البريد الالكتروني",
                                        data: UserAccountCubit.email),
                                    userInfoRow(
                                        title: "تاريخ الميلاد",
                                        data: "1/1/1980"),
                                    userInfoRow(title: "النوع", data: "ذكر"),
                                  ],
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 60,
                        )
                      ]),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: defaultMaterialButton(
                              text: "تسجيل الخروج",
                              function: () {
                                AppCubit.get(context).signOut();
                              }),
                        ),
                      ),
                    ),
                    Container(
                      color: primaryblue,
                      height: 140,
                      width: double.infinity,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Spacer(),
                            Icon(
                              Icons.account_circle_outlined,
                              size: 60,
                              color: Colors.white,
                            ),
                            Text(
                              "اسم المستخدم",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget userInfoRow({required String title, required String data}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          // Spacer(),
          Expanded(
            child: Text(
              data,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            ),
          )
        ],
      ),
    );
  }
}
