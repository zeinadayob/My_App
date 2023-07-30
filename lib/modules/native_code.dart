import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeCodeScreen extends StatefulWidget {


  @override
  State<NativeCodeScreen> createState() => _NativeCodeScreenState();
}

class _NativeCodeScreenState extends State<NativeCodeScreen> {
  // هنشاء القناة بين CLIENT و تركيبة IOS & ANDROID
  static const platform = MethodChannel('samples.flutter.dev/battery');
  String ?batteryLevel = 'Unknown battery level. ';
  void getButteryLevel()
  {
    platform.invokeMethod('getBatteryLevel').then((value) {
      setState(() {
        batteryLevel = 'Battery level at $value % .';
      });
    }).catchError((error)
    {
      setState(() {
        batteryLevel= 'Failed to get battery level: "${error.message}".';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:
        [
          ElevatedButton(
              onPressed: (){},
              child: Text('Get battery level')),
          Text(batteryLevel!),
        ],
      ),),
    );
  }
}
