import 'package:flutter/material.dart';
import 'package:makan_makan/Api/models/menus.dart';

menuList(List<dynamic> menu, MenuType menuType) {
  return SliverPadding(
      padding: const EdgeInsets.all(8),
      sliver: SliverGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: menu.map((e) {
          return Container(
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 1)],
            ),
            child: Column(
              children: [
                Expanded(
                  child: (menuType == MenuType.food)
                      ? Image.asset('assets/img/foods.jpg')
                      : Image.asset('assets/img/drinks.jpg'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    e.name,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ));
}
