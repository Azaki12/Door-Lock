import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mm_app/cubit/cubit.dart';
import 'package:mm_app/cubit/states.dart';
import 'package:mm_app/shared/chat_page.dart';

import 'shared/connection.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.indigo.shade900,
            appBar: AppBar(
              backgroundColor: Colors.indigo[600],
              title: Text(
                'Connect to Device',
                style: GoogleFonts.pacifico().copyWith(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            body: SelectBondedDevicePage(
              onChatPage: (device1) {
                if (device1.name == 'HC-05') {
                  cubit.setServer(device1);
                  cubit.createConnection();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ChatPage(server: cubit.getServer());
                      },
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
