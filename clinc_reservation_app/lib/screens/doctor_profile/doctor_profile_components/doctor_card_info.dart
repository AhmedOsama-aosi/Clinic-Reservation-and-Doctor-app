import 'package:clinc_reservation_app/models/models.dart';
import 'package:clinc_reservation_app/screens/doctor_profile/doctor_profile_cubit.dart';
import 'package:clinc_reservation_app/screens/doctors_screen/doctors_cubit.dart';
import 'package:clinc_reservation_app/screens/favorite/favorite_cubit.dart';
import 'package:clinc_reservation_app/screens/favorite/favorite_states.dart';
import 'package:clinc_reservation_app/screens/reservations_screen/reservations_screen.dart';
import 'package:clinc_reservation_app/shared/components/components.dart';
import 'package:clinc_reservation_app/styles/colors.dart';
import 'package:clinc_reservation_app/styles/images_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../doctor_profile_states.dart';

// ignore: must_be_immutable
class DoctorCardInfo extends StatelessWidget {
  DoctorCardInfo(this.doctor);

  Doctor doctor;

  @override
  Widget build(BuildContext context) {
    // cubit.isdoctorinfavorite();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Center(
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          checksvg(doctor),
                          height: 55,
                          width: 55,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${doctor.fullName}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  FavoriteButton(doctor: doctor),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 2,
                color: Colors.grey,
              ),
              BlocBuilder<DoctorProfileCubit, DoctorProfileStates>(
                buildWhen: (previous, current) {
                  if (current is SeeDoctorDetails) {
                    return true;
                  } else {
                    return false;
                  }
                },
                builder: (context, state) {
                  DoctorProfileCubit cubit = DoctorProfileCubit.get(context);
                  print(" i am see doctor details and have been rebuilt");

                  return GestureDetector(
                    onTap: () {
                      cubit.doctordetails();
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        defaultDetails(
                            icon: Icons.medication,
                            iconcolor: primaryblue,
                            text: "${doctor.description}",
                            maxlines: state.maxlines),
                        SizedBox(
                          height: 10,
                        ),
                        defaultDetails(
                            icon: Icons.room,
                            iconcolor: primaryblue,
                            text: "${doctor.address}",
                            maxlines: state.maxlines),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    Key? key,
    required this.doctor,
  }) : super(key: key);

  //final DoctorProfileCubit cubit;
  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteStates>(
        buildWhen: (pervious, current) {
      if (current is EditFavoriteState || current is GetFavoriteDataState) {
        return true;
      } else {
        return false;
      }
    }, builder: (context, state) {
      print(" i am favorite button and have been rebuilt");

      FavoriteCubit favoriteCubit = FavoriteCubit.get(context);
      favoriteCubit.isdoctorinfavorite(doctor);
      return InkWell(
        customBorder: CircleBorder(),
        onTap: () {
          favoriteCubit.changeFavoriteState(DoctorsCubit.userId, doctor.id);
        },
        child: CircleAvatar(
          radius: 15,
          backgroundColor: favoriteCubit.favoritecolor == null
              ? Colors.grey[350]
              : favoriteCubit.favoritecolor,
          child: Icon(
            Icons.favorite,
            color: Colors.white,
            size: 20,
          ),
        ),
      );
    });
  }
}
