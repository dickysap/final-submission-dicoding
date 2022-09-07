import 'package:flutter/cupertino.dart';
import '../Api/api_service.dart';
import '../Api/models/restaurant_detail.dart';

enum DetailResultState { noData, hasData, loading, error }

class DetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;
  DetailProvider({required this.apiService, required this.id}) {
    _getDetail(id);
  }

  late DetailRestaurant _detailRestaurant;
  late DetailResultState _state;
  String _message = "";

  String get message => _message;
  DetailRestaurant get result => _detailRestaurant;
  DetailResultState get state => _state;

  Future<dynamic> _getDetail(String id) async {
    try {
      _state = DetailResultState.loading;
      notifyListeners();
      final detail = await apiService.detailRestaurant(id);
      if (detail.error) {
        _state = DetailResultState.noData;
        notifyListeners();
      } else {
        _state = DetailResultState.hasData;
        notifyListeners();
        return _detailRestaurant = detail;
      }
    } catch (e) {
      _state = DetailResultState.error;
      notifyListeners();
      return _message = "Error ---> $e";
    }
  }
}
