import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../shared/components/components.dart';
import '../shared/styles/colors.dart';
import '../shared/styles/images_path.dart';
import 'home_screen.dart';

class PatientDetails extends StatelessWidget {
  const PatientDetails({
    Key? key,
    required this.patientlist,
  }) : super(key: key);

  final List patientlist;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: patientlist.length,
          itemBuilder: (context, index) {
            Map patient = patientlist[index];
            return MyCard(
                borderRadius: 17,
                margin: const EdgeInsets.all(10),
                widget: InkWell(
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
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            SvgPicture.asset(
                              patientlist[index]["ismale"] ? boy_svg : girl_svg,
                              height: 55,
                              width: 55,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                            style:
                                                const TextStyle(fontSize: 13),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textDirection: TextDirection.rtl,
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
                                            style:
                                                const TextStyle(fontSize: 13),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textDirection: TextDirection.rtl,
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
                ));
          }),
    );
  }
}
