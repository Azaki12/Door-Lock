import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mm_app/in_door/visitor_screen.dart';
import 'package:mm_app/shared/const.dart';

import 'leaving_screen.dart';

class MainInDoor extends StatefulWidget {
  @override
  State<MainInDoor> createState() => _MainInDoorState();
}

class _MainInDoorState extends State<MainInDoor> with TickerProviderStateMixin {
  bool switchValue = false;

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                !switchValue
                    ? AnimatedDefaultTextStyle(
                        duration: Duration(milliseconds: 900),
                        child: Text(
                          'Visitor',
                          style: GoogleFonts.pacifico().copyWith(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                        style: GoogleFonts.pacifico().copyWith(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      )
                    : Text(
                        'visitor',
                        style: GoogleFonts.pacifico().copyWith(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                Switch(
                    value: switchValue,
                    onChanged: (value) {
                      switchValue = value;
                      setState(() {});
                      cardKey.currentState.toggleCard();
                    }),
                switchValue
                    ? AnimatedDefaultTextStyle(
                        duration: Duration(milliseconds: 900),
                        child: Text(
                          'Leaving',
                          style: GoogleFonts.pacifico().copyWith(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                        style: GoogleFonts.pacifico().copyWith(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )
                    : Text(
                        'Leaving',
                        style: GoogleFonts.pacifico().copyWith(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            FlipCard(
              front: GestureDetector(
                onTap: () {
                  Consts.navigateTo(context, VisitorScreen());
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Lottie.asset(
                    'assets/lottie/visitor.json',
                  ),
                ),
              ),
              back: GestureDetector(
                onTap: () {
                  Consts.navigateTo(context, LeavingScreen());
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Lottie.asset(
                    'assets/lottie/leaving.json',
                  ),
                ),
              ),
              key: cardKey,
              flipOnTouch: false,
            ),
          ],
        ),
      ),
    );
  }
}
