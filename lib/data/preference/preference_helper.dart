import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static const dailyPromo = 'DAILY_Promo';

  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  Future<bool> get isPromoActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyPromo) ?? false;
  }

  void setPromo(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyPromo, value);
  }
}
