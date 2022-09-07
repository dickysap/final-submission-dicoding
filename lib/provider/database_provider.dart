import 'package:flutter/cupertino.dart';
import 'package:makan_makan/Api/models/element.dart';
import 'package:makan_makan/data/database_helper.dart';

enum ResultStateDatabase { noData, hasData, loading, error }

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getShoppingCart();
  }

  late ResultStateDatabase _state;
  ResultStateDatabase get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _shoppingCart = [];
  List<Restaurant> get shoppingCart => _shoppingCart;

  void _getShoppingCart() async {
    _shoppingCart = await databaseHelper.getShoppingCart();

    if (_shoppingCart.length > 0) {
      _state = ResultStateDatabase.hasData;
    } else {
      _state = ResultStateDatabase.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addShoppingCart(Restaurant restaurant) async {
    try {
      await databaseHelper.insertShoppingCart(restaurant);
      _getShoppingCart();
    } catch (e) {
      _state = ResultStateDatabase.error;
      _message = 'Error $e';
    }
  }

  Future<bool> isAddToCart(String id) async {
    final readyAtCart = await databaseHelper.getShoppingCartById(id);
    return readyAtCart.isNotEmpty;
  }

  void removeCart(String id) async {
    try {
      await databaseHelper.removeShoppingCart(id);
      _getShoppingCart();
    } catch (e) {
      _state = ResultStateDatabase.error;
      _message = 'Error $e';
      notifyListeners();
    }
  }
}
