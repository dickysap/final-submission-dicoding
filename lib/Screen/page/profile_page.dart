import 'package:flutter/material.dart';
import 'package:makan_makan/provider/preference_provider.dart';
import 'package:makan_makan/provider/scheduling_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/profile_page';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return ListView(
            children: [
              Material(
                child: ListTile(
                  title: const Text('Aktifkan Notifikasi Promo'),
                  trailing: Consumer<SchedulingProvider>(
                    builder: (context, scheduled, _) {
                      return Switch.adaptive(
                        value: scheduled.isScheduled,
                        onChanged: (value) async {
                          setState(() {
                            scheduled.schedulePromo(value);
                            provider.enableDailyReminder(value);
                          });
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
