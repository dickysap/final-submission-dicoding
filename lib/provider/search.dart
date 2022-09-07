import 'package:flutter/cupertino.dart';
import '../Api/api_service.dart';
import '../Api/models/search.dart';

enum SearchState { hasData, loading, error, noData }

class SearchProvider extends ChangeNotifier {
  ApiService apiService;

  SearchProvider({required this.apiService}) {
    searchData(query);
  }

  late SearchRestaurant _searchRestaurant;
  late SearchState _state;
  String _message = '';
  String _query = '';

  SearchRestaurant get result => _searchRestaurant;
  SearchState get state => _state;
  String get message => _message;
  String get query => _query;

  Future<dynamic> searchData(String query) async {
    try {
      _state = SearchState.loading;
      _query = query;
      final searchrestaurant = await apiService.searchRestaurant(query);
      if (searchrestaurant.restaurants.isEmpty) {
        _state = SearchState.noData;
        notifyListeners();
        _message = "Faied Search Restaurant";
      } else {
        _state = SearchState.hasData;
        notifyListeners();
        return _searchRestaurant = searchrestaurant;
      }
    } catch (e) {
      _state = SearchState.error;
      return _message = "Error ---> $e";
    }
  }
}
