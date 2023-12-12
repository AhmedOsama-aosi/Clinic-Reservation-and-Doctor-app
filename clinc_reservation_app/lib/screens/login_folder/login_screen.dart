import 'package:local_auth/local_auth.dart';

import '../../shared/local_auth_api.dart';
import '/screens/login_folder/login_cubit.dart';
import '/screens/login_folder/login_states.dart';
import '/screens/signin_screen/signin_screen.dart';
import '/shared/components/components.dart';
import '/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var username = TextEditingController();
  var userpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginCubit(),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "اللوجو",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: primaryblue),
                  ),
                  Text(
                    "اسم التطبيق",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryblue),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "تسجيل الدخول",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        defaultFormField(
                            label: "اسم المستخدم",
                            prefix: Icons.person,
                            controller: username,
                            type: TextInputType.name,
                            onSubmit: (value) {
                              //FocusScope.of(context).nextFocus();
                            },
                            validate: (value) {
                              if (username.text == "") {
                                return "يجب ادخال اسم المستخدم";
                              } else if (LoginCubit.result ==
                                  "this email not exist") {
                                LoginCubit.result = "";
                                return "يرجي التأكد من البريد الالكتروني";
                              } else {
                                return null;
                              }
                            }),
                        SizedBox(
                          height: 25,
                        ),
                        BlocBuilder<LoginCubit, LoginStates>(
                          buildWhen: (previousstat, currentstat) {
                            if (currentstat is ChangevisibilityState) {
                              return true;
                            } else {
                              return false;
                            }
                          },
                          builder: (context, state) {
                            LoginCubit logincubit = LoginCubit.get(context);

                            return defaultFormField(
                                label: "كلمة المرور",
                                prefix: Icons.lock,
                                suffix: IconButton(
                                    splashRadius: 23,
                                    onPressed: () {
                                      logincubit.changevisibilityState();
                                    },
                                    icon: Icon(ChangevisibilityState
                                            .loginPasswordIsObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                                controller: userpassword,
                                type: TextInputType.name,
                                lines: 1,
                                isObscure: ChangevisibilityState
                                    .loginPasswordIsObscure,
                                validate: (value) {
                                  if (userpassword.text == "") {
                                    return "يجب ادخال كلمة المرور";
                                  } else if (LoginCubit.result ==
                                      "wrong password") {
                                    LoginCubit.result = "";
                                    return "كلمة المرور غير صحيحة";
                                  } else {
                                    return null;
                                  }
                                });
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextButton(
                            onPressed: () async {
                              final isAuthenticated =
                                  await LocalAuthApi.hasBiometrics();
                              final biometrics =
                                  await LocalAuthApi.getBiometrics();
                              print(biometrics);
                              final fingerprint = biometrics
                                  .contains(BiometricType.fingerprint);
                              print('fingerprint : $fingerprint');
                            },
                            child: Text("نسيت كلمة المرور ؟")),
                        SizedBox(
                          height: 40,
                        ),
                        BlocConsumer<LoginCubit, LoginStates>(
                          listener: (context, state) {
                            if (state is LoginResultState) {
                              formkey.currentState!.validate();
                            }
                          },
                          buildWhen: (pervious, current) {
                            if (current is LoginResultState ||
                                current is LoginLoadingState) {
                              return true;
                            } else {
                              return false;
                            }
                          },
                          builder: (context, state) {
                            if (state is LoginLoadingState) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              return Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: defaultMaterialButton(
                                        text: "تسجيل الدخول",
                                        function: () {
                                          if (formkey.currentState!
                                              .validate()) {
                                            LoginCubit logincubit =
                                                LoginCubit.get(context);

                                            logincubit.postLogInDetails(
                                                context: context,
                                                email: username.text,
                                                password: userpassword.text);
                                            // logincubit.saveLogInDetails(
                                            //     username.text,
                                            //     userpassword.text);
                                          }
                                        }),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: defaultMaterialButton(
                                        icon: Icons.fingerprint,
                                        function: () async {
                                          final isAuthenticated =
                                              await LocalAuthApi.authenticate();
                                          if (isAuthenticated) {
                                            LoginCubit logincubit =
                                                LoginCubit.get(context);

                                            final loginDetails =
                                                await logincubit
                                                    .getLogInDetails();
                                            logincubit.postLogInDetails(
                                                context: context,
                                                email: loginDetails["email"],
                                                password: loginDetails["pass"]);

                                            // ScaffoldMessenger.of(context)
                                            //     .showSnackBar(const SnackBar(
                                            //   content: Text('تم تسجيل الدخول '),
                                            //   backgroundColor: primaryblue,
                                            // ));
                                          }
                                        }),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Text(
                              "مستخدم جديد ؟",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: SignInScreen())),
                                  );
                                },
                                child: Text("سجل الان")),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
