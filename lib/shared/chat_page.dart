import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mm_app/cubit/cubit.dart';
import 'package:mm_app/cubit/states.dart';
import 'package:mm_app/in_door/main_indoor.dart';
import 'package:mm_app/out_door/outdoor_screen.dart';
import 'package:mm_app/shared/const.dart';

class ChatPage extends StatefulWidget {
  final BluetoothDevice server;

  const ChatPage({this.server});

  @override
  _ChatPage createState() => new _ChatPage();
}

class _ChatPage extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppCreateConnectionSuccess) {
          Consts.showToast(message: 'Success', state: ToastStates.SUCCESS);
        }
        if (state is AppCreateConnectionError) {
          Consts.showToast(message: 'Error', state: ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return state is AppCreateConnectionLoading
            ? Scaffold(
                backgroundColor: Colors.indigo.shade900,
                body: Center(
                  child: Lottie.asset(
                    'assets/lottie/loading.json',
                  ),
                ),
              )
            : state is AppCreateConnectionSuccess
                ? Scaffold(
                    // appBar: AppBar(
                    //   title: (isConnecting
                    //       ? Text(
                    //           'Connecting to ' + widget.server.name,
                    //         )
                    //       : Text(
                    //           'Connected with ' + widget.server.name,
                    //         )),
                    // ),
                    body: SafeArea(
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        width: double.infinity,
                        child: inDoor ? MainInDoor() : OutDoorScreen(),
                      ),
                    ),
                  )
                : Scaffold(
                    backgroundColor: Colors.indigo.shade900,
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            'assets/lottie/connectionError.json',
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            'Make Sure you are connecting to the right device',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.pacifico().copyWith(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
      },
    );
  }
}

// MaterialButton(
// color: Colors.transparent,
// onPressed: isConnected ? () => _sendMessage('1') : null,
// child:
// ClipOval(child: Image.asset('assets/images/ledOn.png')),
// ),
