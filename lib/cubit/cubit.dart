import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:mm_app/cubit/states.dart';
import 'package:mm_app/shared/const.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInit());
  BluetoothDevice server;

  BluetoothConnection connection;
  String messageBuffer = '';
  bool isConnecting = true;
  bool get isConnected => connection != null && connection.isConnected;
  bool isDisconnecting = false;

  static AppCubit get(context) => BlocProvider.of(context);

  void setInDoorVar(bool value) {
    inDoor = value;
    emit(AppCreateConnectionSuccess());
  }

  void changeState() {
    inDoor = !inDoor;
    emit(AppStateChange());
  }

  void onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data

    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);

    messageBuffer = (backspacesCounter > 0
        ? messageBuffer.substring(0, messageBuffer.length - backspacesCounter)
        : messageBuffer + dataString);
  }

  void sendMessage(String text) async {
    print(text);
    if (text.length > 0) {
      try {
        connection.output.add(utf8.encode(text));
        await connection.output.allSent;
        emit(AppStateSendSuccess());
      } catch (e) {
        // Ignore error, but notify state
        emit(AppStateSendError());
      }
    }
  }

  void createConnection() {
    emit(AppCreateConnectionLoading());
    BluetoothConnection.toAddress(server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      emit(AppCreateConnectionSuccess());

      isConnecting = false;
      isDisconnecting = false;

      connection.input.listen(onDataReceived).onDone(() {
        // Example: Detect which side closed the connection
        // There should be `isDisconnecting` flag to show are we are (locally)
        // in middle of disconnecting process, should be set before calling
        // `dispose`, `finish` or `close`, which all causes to disconnect.
        // If we except the disconnection, `onDone` should be fired as result.
        // If we didn't except this (no flag set), it means closing by remote.
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      emit(AppCreateConnectionError());
      //print(error);
    });
  }

  void closeConnection() {
    isDisconnecting = true;
    connection.dispose();
    connection = null;
  }

  void closeBluetooth() {
    connection.close();
    FlutterBluetoothSerial.instance.disconnect();
  }

  void setServer(BluetoothDevice s) {
    server = s;
    emit(AppStateConnectionInit());
  }

  getServer() {
    return server;
  }

  getMessage() {
    return messageBuffer;
  }
}
