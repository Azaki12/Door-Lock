import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class Consts {
  static void navigateAndFinishTo(context, widget) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );
  }

  static void navigateTo(context, widget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  static Widget defaultTextForm({
    bool isClickable,
    @required TextEditingController controller,
    @required TextInputType type,
    Function onSubmit,
    Function onChanged,
    Function onTap,
    @required Function validate,
    @required String label,
    @required IconData prefix,
    bool isPassword = false,
    IconData suffix,
    Function onPressed,
  }) =>
      TextFormField(
        style: GoogleFonts.pacifico().copyWith(
          color: Colors.white,
          fontSize: 20,
        ),
        cursorColor: Colors.orange,
        enabled: isClickable,
        obscureText: isPassword,
        validator: validate,
        controller: controller,
        keyboardType: type,
        onFieldSubmitted: onSubmit,
        onChanged: onChanged,
        onTap: onTap,
        decoration: InputDecoration(
          fillColor: Colors.orange,
          filled: true,
          hintText: '$label',
          //labelText: '$label',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          prefixIcon: Icon(
            prefix,
          ),
          suffixIcon: suffix != null
              ? IconButton(
                  icon: Icon(
                    suffix,
                  ),
                  onPressed: onPressed,
                )
              : null,
        ),
      );

  static void showToast({
    @required String message,
    @required ToastStates state,
  }) =>
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        fontSize: 16.0,
      );

// enums

  static Color chooseToastColor(ToastStates state) {
    Color color;

    switch (state) {
      case ToastStates.SUCCESS:
        color = Colors.green;
        break;
      case ToastStates.WARNING:
        color = Colors.amber;
        break;
      case ToastStates.ERROR:
        color = Colors.red;
        break;
    }
    return color;
  }
}

enum ToastStates {
  SUCCESS,
  ERROR,
  WARNING,
}

bool inDoor = true;
