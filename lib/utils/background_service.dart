import 'dart:math';
import 'dart:ui';
import 'dart:isolate';

import 'package:makan_makan/Api/api_service.dart';
import 'package:makan_makan/main.dart';
import 'package:makan_makan/utils/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('Alarm fired!');
    final NotificationHelper notificationHelper = NotificationHelper();
    var result = await ApiService().restaurantResult();

    final _random = Random();
    var restaurant =
        result.restaurants[_random.nextInt(result.restaurants.length)];

    await notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, restaurant);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
