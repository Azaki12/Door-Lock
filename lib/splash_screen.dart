import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mm_app/home_screen.dart';
import 'package:mm_app/shared/const.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () {
        setState(() {
          selected = true;
          print('ss');
        });
      },
    );
    Timer(
      const Duration(seconds: 19),
      () {
        Consts.navigateAndFinishTo(
          context,
          Home(),
        );
      },
    );
  }

  bool selected = false;
  bool finished = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      body: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            AnimatedPositioned(
              width: width,
              height: height,
              top: selected ? 100.0 : height / 2,
              duration: const Duration(seconds: 2),
              curve: Curves.bounceOut,
              onEnd: () {
                setState(() {
                  finished = true;
                });
              },
              child: Column(
                children: [
                  Container(
                    child: Center(
                        child: Text(
                      'TEAM A1',
                      style: GoogleFonts.pacifico().copyWith(
                        color: Colors.orange,
                        fontSize: 30,
                      ),
                    )),
                  ),
                  if (finished)
                    Lottie.asset(
                      'assets/lottie/smartLock.json',
                      repeat: false,
                    ),
                  if (finished)
                    Container(
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'Door Lock System',
                            speed: Duration(milliseconds: 100),
                            textStyle: GoogleFonts.pacifico().copyWith(
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                          TypewriterAnimatedText(
                            'Ahmed Zaki',
                            speed: Duration(milliseconds: 100),
                            textStyle: GoogleFonts.pacifico().copyWith(
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                          TypewriterAnimatedText(
                            'AlHassan Ali',
                            speed: Duration(milliseconds: 100),
                            textStyle: GoogleFonts.pacifico().copyWith(
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                          TypewriterAnimatedText(
                            'Ashraf Hesham',
                            speed: Duration(milliseconds: 100),
                            textStyle: GoogleFonts.pacifico().copyWith(
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                          TypewriterAnimatedText(
                            'Ashraf Mohamed',
                            speed: Duration(milliseconds: 100),
                            textStyle: GoogleFonts.pacifico().copyWith(
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
