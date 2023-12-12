import 'package:clinic_doctor_app/reservations_section/reservations_screen.dart';
import 'package:clinic_doctor_app/shared/styles/images_path.dart';
import 'package:flutter/material.dart';
import 'package:clinic_doctor_app/shared/components/components.dart';
import 'package:clinic_doctor_app/shared/styles/colors.dart';
import 'package:clinic_doctor_app/shared/styles/myicons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  List patientlist = [
    {
      "fullName": "محمود السيد",
      "phone": "0165465",
      "time": "12:30ص",
      "ismale": true,
      "status": "waiting"
    },
    {
      "fullName": "عبدالله خالد",
      "phone": "0165465",
      "time": "12:30ص",
      "ismale": true,
      "status": "success"
    },
    {
      "fullName": "مروة علي",
      "phone": "0165465",
      "time": "12:30ص",
      "ismale": false,
      "status": "canceled"
    },
    {
      "fullName": "محمود السيد",
      "phone": "0165465",
      "time": "12:30ص",
      "ismale": true,
      "status": "waiting"
    },
    {
      "fullName": "عبدالله خالد",
      "phone": "0165465",
      "time": "12:30ص",
      "ismale": true,
      "status": "success"
    },
    {
      "fullName": "مروة علي",
      "phone": "0165465",
      "time": "12:30ص",
      "ismale": false,
      "status": "canceled"
    },
    {
      "fullName": "محمود السيد",
      "phone": "0165465",
      "time": "12:30ص",
      "ismale": true,
      "status": "waiting"
    },
    {
      "fullName": "عبدالله خالد",
      "phone": "0165465",
      "time": "12:30ص",
      "ismale": true,
      "status": "success"
    },
    {
      "fullName": "مروة علي",
      "phone": "0165465",
      "time": "12:30ص",
      "ismale": false,
      "status": "canceled"
    },
  ];
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  List<Widget> todayAppointment = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      drawer: const MyDrawer(),
      appBar: _buildAppBar(_scaffoldkey, context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
                margin: const EdgeInsets.all(10),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "عدد الحالات اليوم",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      Text(
                        "${patientlist.length}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "حجوزات في انتظار الموافقة",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.only(right: 5.0),
                            child: Text(
                              "15",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                              onTap: (() => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: ReservationsScreen()),
                                    ),
                                  )),
                              child: Row(children: [
                                const Text(
                                  "الحجوزات",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 5.0, right: 5.0),
                                  child: MyIcons.arrowBack(
                                      color: primaryblue, size: 25),
                                )
                              ])),
                          // Transform(
                          //     alignment: Alignment.center,
                          //     transform: Matrix4.rotationY(22 / 7),
                          //     child:),
                        ],
                      )
                    ],
                  ),
                )),
            Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
                margin: const EdgeInsets.all(10),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Text(
                            "الجدول الزمني لليوم",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                        ],
                      ),
                      GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        childAspectRatio: 0.72,
                        crossAxisCount: 7,
                        children: List.generate(patientlist.length, (index) {
                          return Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 4.0, vertical: 4.0),
                              elevation: 3,
                              child: SizedBox(
                                height: 95,
                                width: 68,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${index + 1}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${patientlist[index]["time"]}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.5),
                                      )
                                    ],
                                  ),
                                ),
                              ));
                        }),
                      )
                    ],
                  ),
                )),
            const SizedBox(
              height: 5,
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: patientlist.length,
                itemBuilder: (context, index) {
                  Map patient = patientlist[index];
                  return Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                    margin: const EdgeInsets.all(10),
                    elevation: 3,
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SizedBox(
                            height: 75,
                            width: double.infinity,
                            child: Row(
                              children: [
                                Text(
                                  "${index + 1}",
                                  style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                SvgPicture.asset(
                                  patientlist[index]["ismale"]
                                      ? boy_svg
                                      : girl_svg,
                                  height: 55,
                                  width: 55,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          //  "د.${DoctorsCubit.doctorsDataList[index]["teacher_name"]}",
                                          "${patient["fullName"]}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.phone,
                                              size: 18,
                                              color: primaryblue,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "${patient["phone"]}",
                                                style: const TextStyle(
                                                    fontSize: 13),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textDirection:
                                                    TextDirection.rtl,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.alarm,
                                              size: 18,
                                              color: primaryblue,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "${patient["time"]}",
                                                style: const TextStyle(
                                                    fontSize: 13),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textDirection:
                                                    TextDirection.rtl,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                StatusMessage(patient["status"]),
                              ],
                            )),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

AppBar _buildAppBar(GlobalKey<ScaffoldState> _scaffoldkey, context) {
  return AppBar(
    centerTitle: true,
    title: const Text(
      "اسم التطبيق",
      style: TextStyle(color: primaryblue, fontWeight: FontWeight.bold),
    ),
    elevation: 0,
    actions: [
      Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Align(
              alignment: Alignment.center,
              child: IconButton(
                padding: EdgeInsets.zero,
                splashRadius: 30,
                icon: const Icon(
                  Icons.notifications,
                  color: primaryblue,
                  size: 30,
                ),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => Directionality(
                  //           textDirection: TextDirection.rtl,
                  //           child: NotificationScreen())),
                  // );
                  // NotificationApi.showNotify();
                },
              ),
            ),
          ),
          // Container(),
          const Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              width: 30,
              height: 30,
              child: Card(
                color: Colors.red,
                shape: CircleBorder(),
                child: Center(
                  child: Text(
                    "+9",
                    style: TextStyle(color: Colors.white),
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(
        width: 7,
      ),
    ],
    leading: IconButton(
        onPressed: () => _scaffoldkey.currentState!.openDrawer(),
        icon: MyIcons.menuButton()),
  );
}

class StatusMessage extends StatelessWidget {
  StatusMessage(this.status);
  String status;
  @override
  Widget build(context) {
    switch (status) {
      case "waiting":
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 19.5),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xffD5EAFF)),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: Text(
                "في انتظار",
                style: TextStyle(
                    color: primaryblue,
                    fontWeight: FontWeight.bold,
                    fontSize: 9),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      case "success":
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 19.5),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xffC4FFDA)),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: Text(
                "تم الكشف",
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 9),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      case "canceled":
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 18.5),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xffFFD5D5)),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: Text(
                "تم الالغاء",
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 9),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );

      default:
        return Container();
    }
  }
}
