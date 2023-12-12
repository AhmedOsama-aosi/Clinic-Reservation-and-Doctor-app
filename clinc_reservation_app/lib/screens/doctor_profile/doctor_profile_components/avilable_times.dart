import 'package:clinc_reservation_app/models/models.dart';
import 'package:clinc_reservation_app/screens/doctor_profile/doctor_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../doctor_profile_states.dart';

// ignore: must_be_immutable
class AvilableTimes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorProfileCubit, DoctorProfileStates>(
      buildWhen: (previous, current) {
        if (current is Selectmonth ||
            current is SelectDay ||
            current is SelectTime) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        DoctorProfileCubit cubit = DoctorProfileCubit.get(context);
        var _selectedday = DoctorProfileStates.selectedDay;
        return _selectedday == null
            ? Container()
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.3 / 0.7,
                  // Create a grid with 2 columns. If you change the scrollDirection to
                  // horizontal, this produces 2 rows.
                  crossAxisCount: 4,
                  // Generate 100 widgets that display their index in the List.
                  children:
                      List.generate(_selectedday.timeList.length, (index) {
                    return AvilableTimesItems(
                        index, _selectedday.timeList[index]);
                  }),
                ),
              );
      },
    );
  }
}

// ignore: must_be_immutable
class AvilableTimesItems extends StatelessWidget {
  AvilableTimesItems(this.index, this.timeobject);
  int index;
  DayTime timeobject;
  bool enabled = true;
  @override
  Widget build(BuildContext context) {
    var cubit = DoctorProfileCubit.get(context);
    var value = cubit.setvalues(index, "time");
    if (timeobject.isAvailable) {
      enabled = true;
    } else {
      enabled = false;
    }
    return Card(
      color: value.backcolor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: !enabled
            ? null
            : () {
                cubit.selectTime(index, timeobject);
              },
        child: Center(
          child: Text(
            "${timeobject.time} ${timeobject.type}",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: !enabled ? Colors.grey[400] : value.forecolor),
          ),
        ),
      ),
    );
  }
}
