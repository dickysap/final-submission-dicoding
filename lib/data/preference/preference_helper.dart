import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static const darkTheme = 'DARK_THEME';
  static const dailyNews = 'DAILY_NEWS';

  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  Future<bool> get isPromoActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyNews) ?? false;
  }

  void setPromo(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyNews, value);
  }
}
