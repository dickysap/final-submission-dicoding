import 'package:flutter/material.dart';
import 'package:makan_makan/provider/database_provider.dart';
import 'package:provider/provider.dart';
import '../../../Api/models/element.dart';
import '../detail.dart';

class SearchResult extends StatelessWidget {
  final Restaurant restaurant;
  const SearchResult({Key? key, required this.restaurant}) : super(key: key);

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
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      )
                    : IconButton(
                        onPressed: () => provider.addShoppingCart(restaurant),
                        icon: const Icon(Icons.favorite_border),
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
