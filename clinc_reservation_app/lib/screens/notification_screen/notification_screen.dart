import 'package:clinc_reservation_app/styles/colors.dart';

import '/shared/components/components.dart';
import 'package:flutter/material.dart';

import 'notification_cubit.dart';

class NotificationScreen extends StatelessWidget {
  var _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(
            context: context,
            titletext: "الاشعارات",
            scaffoldkey: _scaffoldkey,
            backbutton: true,
            menufunction: false),
        body: ListView.builder(
            // itemCount: NotificationCubit.notificationsList.length,
            itemCount: 15,
            itemBuilder: itemBuilder));
  }

  Widget itemBuilder(context, index) {
    // dynamic notification = NotificationCubit.notificationsList[index];
    return Container(
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17),
        ),
        margin: EdgeInsets.all(10),
        elevation: 3,
        child: InkWell(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => Directionality(
            //           textDirection: TextDirection.rtl,
            //           child: DoctorProfileScreen(doctor))),
            // );
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
                height: 75,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "$index اسم الدكتور",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17.0),
                        ),
                        Spacer(),
                        Text("22/10/2021 8:30 م"),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                // Note: Styles for TextSpans must be explicitly defined.
                                // Child text spans will inherit styles from parent
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(text: 'تم الموافقة علي طلب الحجز'),
                                  TextSpan(
                                      text:
                                          ' يوم الخميس 21 /8/ 2021  -  6:30 م',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
