import 'package:flutter/material.dart';
import 'package:makan_makan/Screen/page/detail.dart';
import 'package:makan_makan/utils/notification_helper.dart';
import 'package:provider/provider.dart';
import 'package:makan_makan/Api/api_service.dart';
import 'package:makan_makan/Screen/page/list.dart';
import 'package:makan_makan/provider/restaurant_result.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(DetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.cast();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ResultProvider>(
      create: (_) => ResultProvider(apiService: ApiService()),
      child: const ListPage(),
    );
  }
}
