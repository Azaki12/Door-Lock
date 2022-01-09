import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:lottie/lottie.dart';
import 'package:mm_app/cubit/cubit.dart';
import 'package:mm_app/cubit/states.dart';
import 'package:mm_app/home_screen.dart';
import 'package:mm_app/shared/const.dart';
import 'package:mm_app/shared/error_page.dart';
import 'package:mm_app/splash_screen.dart';

import 'helpers/cache_helper.dart';
import 'shared/my_bloc_observer.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();

  inDoor = CacheHelper.getData(key: 'inDoor');
  print(inDoor);
  if (inDoor == null) {
    inDoor = true;
  }
  //inDoor = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          //cubit.setInDoorVar(inDoor);
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: FutureBuilder(
              future: FlutterBluetoothSerial.instance.requestEnable(),
              builder: (context, future) {
                if (future.connectionState == ConnectionState.waiting) {
                  return Scaffold(
                    body: Center(
                        child: Lottie.asset('assets/lottie/turnOnBlue.json')),
                  );
                } else if (future.connectionState == ConnectionState.done) {
                  return SplashScreen();
                } else {
                  return ErrorPage();
                }
              },
              // child: MyHomePage(title: 'Flutter Demo Home Page'),
            ),
          );
        },
      ),
    );
  }
}
