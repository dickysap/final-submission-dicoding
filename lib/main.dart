import 'package:flutter/material.dart';
import 'package:makan_makan/Screen/page/detail.dart';
import 'package:makan_makan/Screen/page/home.dart';
import 'package:makan_makan/Screen/page/review.dart';
import 'package:makan_makan/Screen/page/search.dart';
import 'package:makan_makan/Screen/splash_screen.dart';
import 'package:makan_makan/data/database_helper.dart';
import 'package:makan_makan/provider/database_provider.dart';
import 'package:provider/provider.dart';

void main() {
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
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        )
      ],
      child: MaterialApp(
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
              id: ModalRoute.of(context)?.settings.arguments as String),
          SearchPage.routeName: (context) => const SearchPage(),
          ReviewPage.routeName: (context) => ReviewPage(
              id: ModalRoute.of(context)?.settings.arguments as String)
        },
      ),
    );
  }
}
