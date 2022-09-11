import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:makan_makan/Screen/page/widget/card_restaurant.dart';
import 'package:makan_makan/provider/database_provider.dart';
import 'package:provider/provider.dart';

class BookmarksPage extends StatelessWidget {
  static const roteName = '/bookmarks_page';
  static const String bookmarksTitle = 'Bookmarks';

  const BookmarksPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultStateDatabase.hasData) {
          return ListView.builder(
            itemCount: provider.shoppingCart.length,
            itemBuilder: (context, index) {
              return CardRestaurant(restaurant: provider.shoppingCart[index]);
            },
          );
        } else {
          return Center(
            child: Material(
              child: Text(provider.message),
            ),
          );
        }
      },
    ));
  }
}
