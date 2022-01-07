import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mm_app/cubit/cubit.dart';
import 'package:mm_app/cubit/states.dart';
import 'package:mm_app/helpers/cache_helper.dart';
import 'package:mm_app/home_screen.dart';
import 'package:mm_app/shared/const.dart';
import 'package:mm_app/shared/slider_button/slider.dart';

class OutDoorScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.indigo.shade900,
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/lottie/loginPage.json'),
                      SizedBox(
                        height: 40,
                      ),
                      Consts.defaultTextForm(
                        controller: emailController,
                        type: TextInputType.text,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'cant be empty';
                          }
                          if (value != 'admin') {
                            return 'wrong user';
                          }
                          return null;
                        },
                        label: 'User Name',
                        prefix: Icons.person,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Consts.defaultTextForm(
                        controller: passwordController,
                        type: TextInputType.text,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'cant be empty';
                          }
                          if (value != 'admin') {
                            return 'wrong password';
                          }
                          return null;
                        },
                        label: 'Password',
                        prefix: Icons.lock,
                        isPassword: true,
                        onSubmit: (value) {
                          if (formKey.currentState.validate()) {
                            print('entrer');
                            cubit.changeState();
                            cubit.sendMessage('1');
                            CacheHelper.saveData(key: 'inDoor', value: inDoor);
                            Consts.navigateAndFinishTo(context, Home());
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (formKey.currentState.validate()) {
                            cubit.changeState();
                            cubit.sendMessage('1');
                            Timer(
                              const Duration(seconds: 2),
                              () => cubit.closeBluetooth(),
                            );
                            Consts.navigateAndFinishTo(context, Home());
                          }
                        },
                        child: SliderButton(
                          action: () {
                            if (formKey.currentState.validate()) {
                              cubit.changeState();
                              cubit.sendMessage('1');
                              Timer(
                                const Duration(seconds: 2),
                                () => cubit.closeBluetooth(),
                              );
                              Timer(
                                const Duration(seconds: 3),
                                () =>
                                    Consts.navigateAndFinishTo(context, Home()),
                              );
                            }
                          },
                          buttonColor: Colors.blue,
                          radius: 40,
                          alignLabel: Alignment.center,
                          icon: Icon(Icons.send),
                          shimmer: true,
                          label: Text(
                            'Enter',
                            style: GoogleFonts.pacifico().copyWith(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          dismissible: false,
                          backgroundColor: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
