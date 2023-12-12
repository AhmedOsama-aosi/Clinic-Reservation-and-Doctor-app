import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/models.dart';
import '../shared/styles/colors.dart';
import '../shared/styles/myicons.dart';
import 'cubit/schedule_manegment_cubit.dart';

// ignore: must_be_immutable
class MyCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //  if (state.runtimeType == GetCalendarData)
    return Container(
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              BlocBuilder<ScheduleManegmentCubit, ScheduleManegmentState>(
                buildWhen: (previous, current) {
                  // if (current is Selectmonth) {
                  //   return true;
                  // } else {
                  //   return false;
                  // }
                  return true;
                },
                builder: (context, state) {
                  ScheduleManegmentCubit cubit =
                      ScheduleManegmentCubit.get(context);

                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    child: Row(
                      children: [
                        IconButton(
                            splashRadius: 20,
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              cubit.nextmonth();
                            },
                            icon: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(22 / 7),
                              child: MyIcons.arrowBack(
                                  color: primaryblue, size: 20),
                            )),
                        Spacer(),
                        Text(
                          "${cubit.selectedmonth.text} ${cubit.selectedmonth.year}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Spacer(),
                        IconButton(
                          splashRadius: 20,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            cubit.perviousmonth();
                          },
                          icon: MyIcons.arrowBack(color: primaryblue, size: 20),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Card(
                elevation: 0,
                child: Column(
                  children: [
                    GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        childAspectRatio: 1.7 / 0.7,
                        crossAxisCount: 7,
                        children: [
                          daystext("السبت"),
                          daystext("الاحد"),
                          daystext("الاثنين"),
                          daystext("الثلاثاء"),
                          daystext("الاربعاء"),
                          daystext("الخميس"),
                          daystext("الجمعة"),
                        ]),
                  ],
                ),
              ),
              BlocBuilder<ScheduleManegmentCubit, ScheduleManegmentState>(
                buildWhen: (previous, current) {
                  if (current is Selectmonth || current is SelectDay) {
                    return true;
                  } else {
                    return false;
                  }
                },
                builder: (context, state) {
                  ScheduleManegmentCubit cubit =
                      ScheduleManegmentCubit.get(context);

                  return GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    //  childAspectRatio: 1.2 / 0.7,
                    // Create a grid with 2 columns. If you change the scrollDirection to
                    // horizontal, this produces 2 rows.
                    crossAxisCount: 7,
                    childAspectRatio: 1.2,
                    // Generate 100 widgets that display their index in the List.
                    children: List.generate(
                        cubit.selectedmonth.numofdays! +
                            cubit.selectedmonth.fristDayIndexInWeek, (index) {
                      return CalenderItemsOfDays(cubit.selectedmonth, index);
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget daystext(daytext) {
  return Center(
    child: Text(
      "$daytext",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
      overflow: TextOverflow.ellipsis,
    ),
  );
}

// ignore: must_be_immutable
class CalenderItemsOfDays extends StatelessWidget {
  CalenderItemsOfDays(this.selectedmonth, this.index, {Key? key})
      : super(key: key);
  late var selectedmonth;
  late var index;

  bool skip = false;
  bool enabled = true;
  late CalendarDay theDay;
  var value;
  @override
  Widget build(BuildContext context) {
    ScheduleManegmentCubit cubit = ScheduleManegmentCubit.get(context);

    if (index < selectedmonth.fristDayIndexInWeek) {
      skip = true;
    } else {
      theDay =
          selectedmonth.dayslist[index - selectedmonth.fristDayIndexInWeek];

      value = cubit.setvalues(index, "day");
      skip = false;
      enabled = theDay.isactivated;
      if (DateTime(theDay.intYear!, theDay.intMonth!, theDay.intDay!).isBefore(
          DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
        enabled = false;
      }
    }

    return skip
        ? Container()
        : Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: value.backcolor,
            elevation: 0,
            shape: CircleBorder(),
            child: InkWell(
              // onTap: enabled
              //     ? () {
              //         cubit.selectDay(index, theDay);
              //       }
              //     : null,
              onTap: () {
                cubit.selectDay(index, theDay);
              },
              child: Center(
                child: Text(
                  // "${widget.selectedmonth.dayslist[widget.index - widget.selectedmonth.fristDayIndexInWeek].numofday}",
                  "${theDay.intDay}",
                  style: TextStyle(
                      color: enabled ? value.forecolor : Colors.grey[400],
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
          );
  }
}
