import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:mm_app/cubit/cubit.dart';
import 'package:mm_app/cubit/states.dart';
import 'package:mm_app/helpers/cache_helper.dart';
import 'package:mm_app/home_screen.dart';
import 'package:mm_app/shared/const.dart';

class OutDoorScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        var cubit = AppCubit.get(context);
        if (state is AppStateSendSuccess) {
          print('Send Msg Buffer : ${cubit.messageBuffer}');
        }
        if (state is AppGetMessage) {
          print('Get Msg Buffer : ${cubit.messageBuffer}');
          if (cubit.messageBuffer == '0') {
            Consts.navigateAndFinishTo(context, Home());
            cubit.changeState();
            CacheHelper.saveData(key: 'inDoor', value: inDoor);
            cubit.closeBluetooth();
          }
        }
      },
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
                            cubit.sendMessage('1');

                            //cubit.changeState();

                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // SliderButton(
                      //   action: () {
                      //     print('aa');
                      //     if (formKey.currentState.validate()) {
                      //       cubit.sendMessage('1');
                      //     }
                      //   },
                      //   buttonColor: Colors.blue,
                      //   radius: 40,
                      //   alignLabel: Alignment.center,
                      //   icon: Icon(Icons.send),
                      //   shimmer: true,
                      //   label: Text(
                      //     'Enter',
                      //     style: GoogleFonts.pacifico().copyWith(
                      //       color: Colors.white,
                      //       fontSize: 20,
                      //     ),
                      //   ),
                      //   dismissible: false,
                      //   //dismissThresholds: 1,
                      //   backgroundColor: Colors.orange,
                      // ),
                      ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState.validate())
                              cubit.sendMessage('1');
                          },
                          child: Text('Enter'))
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
