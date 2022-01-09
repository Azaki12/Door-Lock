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

class LeavingScreen extends StatefulWidget {
  @override
  State<LeavingScreen> createState() => _LeavingScreenState();
}

class _LeavingScreenState extends State<LeavingScreen>
    with TickerProviderStateMixin {
  AnimationController _openController;
  bool isClicked = false;

  @override
  void initState() {
    super.initState();
    _openController = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.indigo.shade900,
          appBar: AppBar(
            title: Text(
              'Leaving',
              style: GoogleFonts.pacifico().copyWith(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
            backgroundColor: Colors.indigo.shade600,
          ),
          body: Center(
            child: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cubit.messageBuffer == '1'
                        ? Text(
                            'Door is opened',
                            style: GoogleFonts.pacifico().copyWith(
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          )
                        : Text(
                            'Door is closed',
                            style: GoogleFonts.pacifico().copyWith(
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        // case closed
                        isClicked = !isClicked;
                        _openController.forward();
                        cubit.sendMessage('1');
                        cubit.changeState();
                        CacheHelper.saveData(key: 'inDoor', value: inDoor);
                        Timer(
                          const Duration(seconds: 2),
                          () => cubit.closeBluetooth(),
                        );

                        Timer(
                          const Duration(seconds: 3),
                          () => Consts.navigateAndFinishTo(context, Home()),
                        );
                      },
                      child: Lottie.asset(
                        'assets/lottie/doorOpen.json',
                        controller: _openController,
                        onLoaded: (composition) {
                          _openController..duration = composition.duration;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
