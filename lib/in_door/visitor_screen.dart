import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mm_app/cubit/cubit.dart';
import 'package:mm_app/cubit/states.dart';
import 'package:mm_app/shared/const.dart';

import 'main_indoor.dart';

class VisitorScreen extends StatefulWidget {
  @override
  State<VisitorScreen> createState() => _VisitorScreenState();
}

class _VisitorScreenState extends State<VisitorScreen>
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
            backgroundColor: Colors.indigo[600],
          ),
          body: Center(
            child: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cubit.getMessage() == '0'
                        ? Text(
                            'Door is Closed',
                            style: GoogleFonts.pacifico().copyWith(
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          )
                        : Text(
                            'Door is Open',
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
                        if (!isClicked) {
                          // case closed
                          isClicked = !isClicked;
                          _openController.forward();
                          cubit.sendMessage('1');
                          print(cubit.messageBuffer);
                          Timer(
                            const Duration(seconds: 6),
                            () => Consts.navigateAndFinishTo(
                              context,
                              MainInDoor(),
                            ),
                          );
                        }
                      },
                      child: Lottie.asset(
                        'assets/lottie/doorOpen.json',
                        controller: _openController,
                        onLoaded: (composition) {
                          _openController..duration = composition.duration;
                        },
                      ),
                    ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     _openController..forward();
                    //   },
                    //   child: Text('open'),
                    // ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     _openController..reverse();
                    //   },
                    //   child: Text('Close'),
                    // ),
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
