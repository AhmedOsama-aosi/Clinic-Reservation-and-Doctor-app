import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../doctors_States.dart';
import '../doctors_cubit.dart';

// ignore: must_be_immutable
class CategoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorsCubit, DoctorsStates>(
      buildWhen: (perviousState, currnetState) {
        if (currnetState is ChangeCategoryState) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        DoctorsCubit cubit = DoctorsCubit.get(context);
        return Container(
          height: 120,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: DoctorsCubit.categories.length,
            itemBuilder: (context, index) => Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17),
              ),
              margin: EdgeInsets.all(8),
              elevation: 3,
              color: cubit.selectedCategoryindex == index
                  ? Colors.grey[100]
                  : null,
              child: InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
                onTap: () {
                  cubit.selectcategory(
                      categoryindex: index,
                      categoryid: DoctorsCubit.categories[index]["categoryid"]);
                },
                child: Container(
                    height: 110,
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            DoctorsCubit.categories[index]["categorypicture"],
                            height: 60,
                            width: 60,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            child: Text(
                              "${DoctorsCubit.categories[index]["categoryname"]}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          ),
        );
      },
    );
  }
}
