import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:mm_app/cubit/cubit.dart';
import 'package:mm_app/cubit/states.dart';
import 'package:mm_app/in_door/main_indoor.dart';
import 'package:mm_app/out_door/outdoor_screen.dart';
import 'package:mm_app/shared/const.dart';

class VerificationScreen extends StatelessWidget {
  var verificationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.indigo[900],
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/lottie/verify.json'),
              Consts.defaultTextForm(
                  controller: verificationController,
                  type: TextInputType.text,
                  isPassword: true,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'cant be empty';
                    }
                    return null;
                  },
                  label: 'MCU Code',
                  prefix: Icons.lock,
                  onSubmit: (value) {
                    cubit.sendMessage(verificationController.text);
                  }),
              ElevatedButton(
                onPressed: () {
                  cubit.sendMessage(verificationController.text);
                },
                child: Text('send'),
              ),
            ],
          ),
        );
      },
      listener: (context, state) {
        if (state is AppStateSendError) {
          Consts.showToast(
              message: 'Error in Sending', state: ToastStates.ERROR);
        }
        if (state is AppStateSendSuccess) {
          Consts.showToast(message: 'Done', state: ToastStates.SUCCESS);
          inDoor
              ? Consts.navigateTo(context, MainInDoor())
              : Consts.navigateTo(context, OutDoorScreen());
        }
      },
    );
  }
}
