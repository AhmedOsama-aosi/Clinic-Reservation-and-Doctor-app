import 'package:clinic_doctor_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/components/components.dart';
import 'calendar_card.dart';
import 'cubit/schedule_manegment_cubit.dart';

class ScheduleManegmentScreen extends StatelessWidget {
  var _scaffoldkey = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ScheduleManegmentCubit(),
        child: Scaffold(
          key: _scaffoldkey,
          drawer: const MyDrawer(),
          appBar: myAppBar(
              context: context,
              titletext: "ادارة المواعيد",
              scaffoldkey: _scaffoldkey,
              menufunction: true,
              backbutton: false),
          body: BlocBuilder<ScheduleManegmentCubit, ScheduleManegmentState>(
              builder: (context, state) {
            ScheduleManegmentCubit cubit = ScheduleManegmentCubit.get(context);
            return Stack(
              children: [
                myTopBlueBackgroundRectangle(),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyCalendar(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            const Text(
                              "متاح :",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const Spacer(),
                            Checkbox(
                                value: cubit.theDay?.isactivated ?? false,
                                onChanged: (value) =>
                                    cubit.changeDayStatus(value)),
                            const SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 4.0),
                        child: Text(
                          "المواعيد المتاحة :",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 20.0),
                        child: GridView.count(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            childAspectRatio: 2.6,
                            crossAxisCount: 2,
                            children: List.generate(
                                cubit.theDay?.timeList?.length ?? 0,
                                // cubit.timelist.length,
                                (index) {
                              DayTime _time = cubit.theDay!.timeList![index];
                              //DayTime _time = cubit.timelist[index];

                              return Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 4.0, vertical: 4.0),
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      textDirection: TextDirection.ltr,
                                      children: [
                                        Text(
                                          "${_time.time}" + "${_time.type}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const Spacer(),
                                        Checkbox(
                                            value: _time.isAvailable,
                                            onChanged: (value) =>
                                                cubit.changeTimeStatus(
                                                    value, _time)),
                                      ],
                                    ),
                                  ));
                            })),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20.0),
                        child: defaultMaterialButton(
                            text: "اضافة موعد",
                            function: () {
                              showBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      height: 400,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Text(
                                            "اضافة موعد",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          SizedBox(
                                            height: 200,
                                            width: double.infinity - 200,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(30.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: ListWheelScrollView(
                                                        itemExtent: 60,
                                                        children: List.generate(
                                                            60,
                                                            (index) => Text(
                                                                  "${index + 1}",
                                                                  style:
                                                                      const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        30,
                                                                  ),
                                                                ))),
                                                  ),
                                                  Expanded(
                                                    child: ListWheelScrollView(
                                                        useMagnifier: false,
                                                        overAndUnderCenterOpacity:
                                                            0.2,
                                                        perspective: 0.01,
                                                        //squeeze: 1.5,
                                                        itemExtent: 70,
                                                        children: List.generate(
                                                            12,
                                                            (index) => Text(
                                                                  "${index + 1}",
                                                                  style:
                                                                      const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        30,
                                                                  ),
                                                                ))),
                                                  ),
                                                  Expanded(
                                                    child: ListWheelScrollView(
                                                        itemExtent: 60,
                                                        children: const [
                                                          Text(
                                                            "ص",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 30,
                                                            ),
                                                          ),
                                                          Text(
                                                            "م",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 30,
                                                            ),
                                                          ),
                                                        ]),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: defaultMaterialButton(
                                                text: "اضافة ",
                                                function: () {}),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                              //  cubit.showCurrentDoctorAppointments();
                            }),
                      )
                    ],
                  ),
                ),
              ],
            );
          }),
        ));
  }
}
