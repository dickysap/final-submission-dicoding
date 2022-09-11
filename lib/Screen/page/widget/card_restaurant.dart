import 'package:flutter/material.dart';
import 'package:makan_makan/Api/models/element.dart';
import 'package:makan_makan/Screen/page/detail.dart';
import 'package:makan_makan/provider/database_provider.dart';
import 'package:provider/provider.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isAddToCart(restaurant.id),
          builder: (context, snapshot) {
            var isBookemarked = snapshot.data ?? false;
            return Material(
              child: ListTile(
                trailing: isBookemarked
                    ? IconButton(
                        onPressed: () => provider.removeCart(restaurant.id),
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      )
                    : IconButton(
                        onPressed: () => provider.addShoppingCart(restaurant),
                        icon: Icon(Icons.favorite_border),
                        color: Colors.red),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: Hero(
                  tag: restaurant.getImage(),
                  child: Image.network(
                    restaurant.getImage(),
                    width: 100,
                  ),
                ),
                title: Text(
                  restaurant.name,
                ),
                subtitle: Text(restaurant.city),
                onTap: () {
                  Navigator.pushNamed(context, DetailPage.routeName,
                      arguments: restaurant.id);
                },
              ),
            );
          },
        );
      },
    );
  }
}
