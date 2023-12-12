import 'package:clinic_doctor_app/signin_section/signin_cubit.dart';
import 'package:clinic_doctor_app/signin_section/signin_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components/components.dart';
import '../shared/styles/colors.dart';

class SignInScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var userEmail = TextEditingController();
  var userPhone = TextEditingController();
  var userFirstName = TextEditingController();
  var userLastName = TextEditingController();
  var userBirthDate = TextEditingController();
  var userPassword = TextEditingController();
  var confirmUserPassword = TextEditingController();
  bool isMale = true;
  @override
  Widget build(BuildContext context) {
    const double distancebetweenfields = 8;
    return BlocProvider(
      create: (context) => SigninCubit(),
      child: BlocConsumer<SigninCubit, SigninStates>(
          listener: (BuildContext context, SigninStates state) {},
          builder: (BuildContext context, SigninStates state) {
            SigninCubit signincubit = SigninCubit.get(context);
            return WillPopScope(
              onWillPop: () async {
                signincubit.goToLoginScreen(context);
                return false;
              },
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Text(
                              "اللوجو /اسم التطبيق",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: primaryblue),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: 25,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                splashRadius: 20,
                                onPressed: () {
                                  signincubit.goToLoginScreen(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                ),
                                color: primaryblue,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          "مستخدم جديد",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Form(
                            key: formkey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: defaultFormField(
                                          label: "الاسم الاول",
                                          prefix: Icons.person,
                                          controller: userFirstName,
                                          type: TextInputType.name,
                                          validate: (value) {
                                            if (userFirstName.text == "") {
                                              return "يجب ادخال اسم المستخدم";
                                            } else {
                                              return null;
                                            }
                                          }),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: defaultFormField(
                                          label: "الاسم الاخير",
                                          prefix: Icons.person,
                                          controller: userLastName,
                                          type: TextInputType.name,
                                          validate: (value) {
                                            if (userLastName.text == "") {
                                              return "يجب ادخال اسم المستخدم";
                                            } else {
                                              return null;
                                            }
                                          }),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                    "ملاحظة * : يتم ظهور الاسم لدي الطبيب عند الحجز"),
                                defaultFormField(
                                    label: "تاريخ الميلاد",
                                    prefix: Icons.today,
                                    controller: userBirthDate,
                                    type: TextInputType.number,
                                    validate: (value) {
                                      if (userBirthDate.text == "") {
                                        return "يجب ادخال تاريخ الميلاد";
                                      } else {
                                        return null;
                                      }
                                    }),
                                const SizedBox(
                                  height: distancebetweenfields,
                                ),
                                Row(
                                  children: [
                                    Radio(
                                        value: true,
                                        groupValue: isMale,
                                        onChanged: (bool? value) {
                                          isMale = value!;
                                          signincubit.emit(
                                              SignInChangeRadioButtonState());
                                        }),
                                    const Text(
                                      "ذكر",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    Radio(
                                        value: false,
                                        groupValue: isMale,
                                        onChanged: (bool? value) {
                                          isMale = value!;
                                          signincubit.emit(
                                              SignInChangeRadioButtonState());
                                        }),
                                    const Text(
                                      "انثي",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                                defaultFormField(
                                    label: "البريد الالكتروني",
                                    prefix: Icons.email,
                                    controller: userEmail,
                                    type: TextInputType.emailAddress,
                                    validate: (value) {
                                      if (userEmail.text == "") {
                                        return "يجب ادخال البريد الالكتروني";
                                      } else {
                                        return null;
                                      }
                                    }),
                                const SizedBox(
                                  height: distancebetweenfields,
                                ),
                                defaultFormField(
                                    label: "رقم الهاتف",
                                    prefix: Icons.phone,
                                    controller: userPhone,
                                    type: TextInputType.phone,
                                    validate: (value) {
                                      if (userPhone.text == "") {
                                        return "يجب ادخال رقم الهاتف";
                                      } else {
                                        return null;
                                      }
                                    }),
                                const SizedBox(
                                  height: distancebetweenfields,
                                ),
                                const SizedBox(
                                  height: distancebetweenfields,
                                ),
                                defaultFormField(
                                    label: "كلمة المرور",
                                    prefix: Icons.lock,
                                    suffix: IconButton(
                                        onPressed: () {
                                          signincubit.changevisibilityState(
                                              "signin pass");
                                        },
                                        icon: signincubit.signinPasswordvisibile
                                            ? const Icon(Icons.visibility)
                                            : const Icon(Icons.visibility_off)),
                                    controller: userPassword,
                                    type: TextInputType.name,
                                    lines: 1,
                                    isObscure:
                                        signincubit.signinPasswordvisibile,
                                    validate: (value) {
                                      if (userPassword.text == "") {
                                        return "يجب ادخال كلمة المرور";
                                      } else {
                                        return null;
                                      }
                                    }),
                                const SizedBox(
                                  height: distancebetweenfields,
                                ),
                                defaultFormField(
                                    label: "إعادة كتابة كلمة المرور",
                                    prefix: Icons.lock,
                                    suffix: IconButton(
                                        onPressed: () {
                                          signincubit.changevisibilityState(
                                              "signin confirm pass");
                                        },
                                        icon: signincubit
                                                .signinConfirmPasswordvisibile
                                            ? const Icon(Icons.visibility)
                                            : const Icon(Icons.visibility_off)),
                                    controller: confirmUserPassword,
                                    type: TextInputType.name,
                                    lines: 1,
                                    isObscure: signincubit
                                        .signinConfirmPasswordvisibile,
                                    validate: (value) {
                                      if (confirmUserPassword.text == "") {
                                        return "يجب تأكيد كلمة المرور";
                                      } else if (confirmUserPassword.text !=
                                          userPassword.text) {
                                        return "كلمة المرور غير متطابقة";
                                      } else if (confirmUserPassword.text ==
                                          userPassword.text) {
                                        return null;
                                      }
                                    }),
                                const SizedBox(
                                  height: 40,
                                ),
                                defaultMaterialButton(
                                    text: "تسجيل",
                                    function: () {
                                      if (formkey.currentState!.validate()) {
                                        signincubit.postSignInDetails(context,
                                            firstName: userFirstName.text,
                                            lastName: userLastName.text,
                                            birthdate: userBirthDate.text,
                                            isMale: isMale,
                                            email: userEmail.text,
                                            phoneNumber: userPhone.text,
                                            password: userPassword.text);
                                      }
                                    }),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
