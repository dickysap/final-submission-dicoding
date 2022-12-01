import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:makan_makan/Api/api_service.dart';
import 'package:makan_makan/Api/models/element.dart';
import 'package:makan_makan/Screen/page/bookmarks_page.dart';
import 'package:makan_makan/Screen/page/detail.dart';
import 'package:makan_makan/Screen/page/home.dart';
import 'package:makan_makan/Screen/page/profile_page.dart';
import 'package:makan_makan/Screen/page/review.dart';
import 'package:makan_makan/Screen/page/search.dart';
import 'package:makan_makan/Screen/splash_screen.dart';
import 'package:makan_makan/common/navigation.dart';
import 'package:makan_makan/data/database_helper.dart';
import 'package:makan_makan/data/preference/preference_helper.dart';
import 'package:makan_makan/provider/database_provider.dart';
import 'package:makan_makan/provider/preference_provider.dart';
import 'package:makan_makan/provider/restaurant_result.dart';
import 'package:makan_makan/provider/scheduling_provider.dart';
import 'package:makan_makan/utils/background_service.dart';
import 'package:makan_makan/utils/notification_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ResultProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
            create: (_) => PreferencesProvider(
                preferencesHelper: PreferencesHelper(
                    sharedPreferences: SharedPreferences.getInstance()))),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        )
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Warung Tiwi',
            theme: ThemeData(
              primarySwatch: Colors.orange,
            ),
            initialRoute: SplashScreen.routeName,
            routes: {
              SplashScreen.routeName: (context) => const SplashScreen(),
              HomePage.routeName: (context) => const HomePage(),
              DetailPage.routeName: (context) => DetailPage(
                  restaurant:
                      ModalRoute.of(context)?.settings.arguments as Restaurant),
              SearchPage.routeName: (context) => const SearchPage(),
              ReviewPage.routeName: (context) => ReviewPage(
                  id: ModalRoute.of(context)?.settings.arguments as String),
              BookmarksPage.roteName: (context) => const BookmarksPage(),
              ProfilePage.routeName: (context) => const ProfilePage()
            },
          );
        },
      ),
    );
  }
}
