import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:makan_makan/data/preference/preference_helper.dart';

class PreferenceProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferenceProvider({required this.preferencesHelper}) {
    _getDetailPromo();
  }
  bool _isPromos = false;
  bool get isPromos => _isPromos;

  void _getDetailPromo() async {
    _isPromos = await preferencesHelper.isPromoActive;
    notifyListeners();
  }

  void enableDailyNews(bool value) {
    preferencesHelper.setPromo(value);
    _getDetailPromo();
  }
}
