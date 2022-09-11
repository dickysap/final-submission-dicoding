import 'package:flutter/material.dart';
import 'package:makan_makan/utils/notification_helper.dart';
import 'package:provider/provider.dart';
import 'package:makan_makan/Api/api_service.dart';
import 'package:makan_makan/Screen/page/list.dart';
import 'package:makan_makan/provider/restaurant_result.dart';

class HomePage extends StatelessWidget {
  final NotificationHelper _notificationHelper = NotificationHelper();
  static const routeName = '/home_page';
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ResultProvider>(
      create: (_) => ResultProvider(apiService: ApiService()),
      child: const ListPage(),
    );
  }
}
