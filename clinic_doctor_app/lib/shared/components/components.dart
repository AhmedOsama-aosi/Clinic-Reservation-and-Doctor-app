import 'package:flutter/services.dart';

import '../../profile_section/user_account_cubit.dart';
import '../styles/colors.dart';
import '../styles/images_path.dart';
import '../styles/myicons.dart';
import '/shared/cubit/cubit.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyCard extends StatelessWidget {
  MyCard({
    Key? key,
    required this.borderRadius,
    required this.margin,
    required this.widget,
  });

  final Widget widget;
  final double borderRadius;
  final EdgeInsetsGeometry margin;
  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        margin: margin,
        elevation: 3,
        child: widget);
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: ListView(
          children: [
            Container(
              color: primaryblue,
              height: 200,
              child: Center(
                child: InkWell(
                  onTap: () {
                    AppCubit.get(context).changeIndex(3);
                  },
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
                        // "${UserAccountCubit.firstname + UserAccountCubit.lastname}",
                        "${UserAccountCubit.firstname}",
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
            ),
            ListTile(
              onTap: () {
                AppCubit.get(context).changeIndex(0);
              },
              leading: Icon(
                Icons.medication,
                color: primaryblue,
              ),
              title: Text(
                "الرئيسية",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                AppCubit.get(context).changeIndex(1);
              },
              leading: Icon(
                Icons.favorite,
                color: primaryblue,
              ),
              title: Text(
                "ادارة المواعيد",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                AppCubit.get(context).changeIndex(2);
              },
              leading: Icon(
                Icons.today,
                color: primaryblue,
              ),
              title: Text(
                "الحجوزات",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget myTopBlueBackgroundRectangle({double heightvalue = 120}) {
  return Container(
    color: primaryblue,
    height: heightvalue,
    width: double.infinity,
  );
}

// ignore: must_be_immutable

AppBar myAppBar(
    {required BuildContext context,
    required String titletext,
    scaffoldkey,
    required bool menufunction,
    required bool backbutton,
    void backbuttonFunction()?}) {
  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle(
      //statusBarIconBrightness: Brightness.dark,
      statusBarColor: primaryblue,
      // statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light, // For Android (dark icons)
      statusBarBrightness: Brightness.light, // For iOS (dark icons)
    ),
    title: Text(
      titletext,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    leading: !menufunction
        ? null
        : IconButton(
            onPressed: () => scaffoldkey.currentState!.openDrawer(),
            icon: MyIcons.menuButton(color: Colors.white)),
    elevation: 0,
    backgroundColor: primaryblue,
    automaticallyImplyLeading: false,
    actions: !backbutton
        ? null
        : [
            IconButton(
                onPressed: backbuttonFunction ??
                    () {
                      Navigator.pop(context);
                    },
                icon: MyIcons.arrowBack(color: Colors.white)),
          ],
  );
}

Widget defaultMaterialButton(
    {IconData? icon, String? text, required void function()?}) {
  return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      color: primaryblue,
      height: 52,
      minWidth: double.infinity,
      child: text != null
          ? Text(
              text,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )
          : Icon(
              icon,
              color: Colors.white,
              size: 25,
            ),
      onPressed: function);
}

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  // Function? onChange,
  bool readonly = false,
  int? lines,
  bool isObscure = false,
  FormFieldValidator<String>? validate,
  required String label,
  TextAlign align = TextAlign.start,
  IconData? prefix,
  Widget? suffix,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: isObscure,
    textAlign: align,
    readOnly: readonly,
    onFieldSubmitted: onSubmit,
    validator: validate,
    maxLines: lines,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.only(bottom: 8, left: 6, right: 6),
      labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      labelText: label,
      prefixIcon: prefix != null ? Icon(prefix) : null,
      suffixIcon: suffix != null ? suffix : null,
    ),
  );
}

Widget defaultTitle(String value,
        {double size = 21, weight = FontWeight.bold, padding = 10.0}) =>
    Padding(
      padding: EdgeInsets.all(padding),
      child: Text(
        value,
        style:
            TextStyle(color: Colors.black, fontWeight: weight, fontSize: size),
      ),
    );

Widget defaultDetails(
    {text,
    icon,
    double iconsize = 18,
    maxlines,
    iconcolor,
    double fontsize = 13,
    fontWeight = FontWeight.normal}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        icon,
        size: iconsize,
        color: iconcolor,
      ),
      SizedBox(
        width: 4,
      ),
      Expanded(
        child: Text(
          text,
          style: TextStyle(
              fontSize: fontsize, fontWeight: fontWeight, height: 1.2),
          maxLines: maxlines,
          overflow: TextOverflow.ellipsis,
          textDirection: TextDirection.rtl,
        ),
      ),
    ],
  );
}

String checksvg(source) {
  if (source.picture == null || source.picture == "") {
    if (source.isMale) {
      return boydoctor_svg;
    } else {
      return girldoctor_svg;
    }
  } else {
    return source.picture;
  }
}

Future<bool> goToHomeScreen({context}) async {
  AppCubit.get(context).changeIndex(0);

  return false;
}

String timeAfterCheckIsMorning(source) {
  if (source.isMoring) {
    return source.time + "ص";
  } else {
    return source.time + "م";
  }
}

// ignore: must_be_immutable
// class DoctorsLIst extends StatelessWidget {
//   DoctorsLIst({
//     required this.doctorlist,
//   });
//   List<Doctor> doctorlist;
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         shrinkWrap: true,
//         physics: NeverScrollableScrollPhysics(),
//         itemCount: doctorlist.length,
//         itemBuilder: (context, index) {
//           Doctor doctor = doctorlist[index];
//           return Container(
//             child: Card(
//               clipBehavior: Clip.antiAliasWithSaveLayer,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(17),
//               ),
//               margin: EdgeInsets.all(10),
//               elevation: 3,
//               child: InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => Directionality(
//                             textDirection: TextDirection.rtl,
//                             child: DoctorProfileScreen(doctor))),
//                   );
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Container(
//                       height: 75,
//                       width: double.infinity,
//                       child: Row(
//                         children: [
//                           SvgPicture.asset(
//                             checksvg(doctor),
//                             height: 55,
//                             width: 55,
//                           ),
//                           SizedBox(
//                             width: 15,
//                           ),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Expanded(
//                                   flex: 1,
//                                   child: Text(
//                                     //  "د.${DoctorsCubit.doctorsDataList[index]["teacher_name"]}",
//                                     "${doctor.fullName}",
//                                     style:
//                                         TextStyle(fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 1,
//                                   child: Row(
//                                     children: [
//                                       Icon(
//                                         Icons.medication,
//                                         size: 18,
//                                         color: primaryblue,
//                                       ),
//                                       Expanded(
//                                         child: Text(
//                                           "${doctor.description}",
//                                           style: TextStyle(fontSize: 13),
//                                           maxLines: 1,
//                                           overflow: TextOverflow.ellipsis,
//                                           textDirection: TextDirection.rtl,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 1,
//                                   child: Row(
//                                     children: [
//                                       Icon(
//                                         Icons.room,
//                                         size: 18,
//                                         color: primaryblue,
//                                       ),
//                                       Expanded(
//                                         child: Text(
//                                           "${doctor.address}",
//                                           style: TextStyle(fontSize: 13),
//                                           maxLines: 1,
//                                           overflow: TextOverflow.ellipsis,
//                                           textDirection: TextDirection.rtl,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       )),
//                 ),
//               ),
//             ),
//           );
//         });
//   }
// }
