import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class BluetoothDeviceListEntry extends StatelessWidget {
  final Function onTap;
  final BluetoothDevice device;

  BluetoothDeviceListEntry({this.onTap, @required this.device});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ListTile(
      leading: Lottie.asset(
        'assets/lottie/bluetoothIcon.json',
      ),
      title: Text(
        device.name ?? "Unknown device",
        style: GoogleFonts.pacifico().copyWith(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      subtitle: Text(
        device.address.toString(),
        style: GoogleFonts.pacifico().copyWith(
          color: Colors.tealAccent,
          fontSize: 10,
        ),
      ),
      trailing: GestureDetector(
        onTap: onTap,
        child: Container(
          width: width / 3.5,
          height: height / 15,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Center(
              child: Text(
            'Connect',
            style: GoogleFonts.pacifico().copyWith(
              color: Colors.white,
              fontSize: 15,
            ),
          )),
        ),
      ),
    );
  }
}
