import 'package:flutter/material.dart';
import 'package:makan_makan/Api/api_service.dart';
import 'package:makan_makan/Api/models/menus.dart';
import 'package:makan_makan/Screen/page/review.dart';
import 'package:makan_makan/Screen/page/widget/menus.dart';
import 'package:makan_makan/provider/database_provider.dart';
import 'package:makan_makan/provider/detail_restaurant.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final String id;
  static const routeName = '/detail_page';
  const DetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailProvider>(
      create: (_) => DetailProvider(apiService: ApiService(), id: widget.id),
      child: Scaffold(body: Consumer<DetailProvider>(
        builder: (context, value, _) {
          if (value.state == DetailResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (value.state == DetailResultState.hasData) {
            final restaurant = value.result.restaurant;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 250,
                  backgroundColor: Colors.orange,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                    background: Hero(
                      tag: restaurant.getImage(),
                      child: Image.network(
                        restaurant.getImage(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.verified_user,
                                size: 25,
                                color: Colors.orange,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                restaurant.name,
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, ReviewPage.routeName,
                                arguments: widget.id);
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 18,
                                color: Colors.yellow,
                              ),
                              const Icon(
                                Icons.star,
                                size: 18,
                                color: Colors.yellow,
                              ),
                              const Icon(
                                Icons.star,
                                size: 18,
                                color: Colors.yellow,
                              ),
                              const Icon(
                                Icons.star,
                                size: 18,
                                color: Colors.yellow,
                              ),
                              const Icon(
                                Icons.star,
                                size: 18,
                                color: Colors.yellow,
                              ),
                              const SizedBox(width: 4),
                              Text(restaurant.rating.toString()),
                              const SizedBox(width: 4),
                              const Text("( Lihat Penilaian )"),
                              const Icon(Icons.arrow_forward_ios, size: 15),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.place_outlined,
                              size: 18,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              restaurant.city,
                            ),
                          ],
                        ),
                        // Consumer<DatabaseProvider>(
                        //   builder: (context, value, child) {
                        //     return FutureBuilder<bool>(
                        //       future: value.isAddToCart(restaurant.id),
                        //       builder: (context, snapshot) {
                        //         var isAddToChart = snapshot.data ?? false;
                        //         return  Row(
                        //         mainAxisAlignment: MainAxisAlignment.end,
                        //         children: [
                        //          isAddToChart ? IconButton(onPressed:() => value.removeCart(restaurant.id),
                        //          icon: Icon(Icons.favorite_border, color: Colors.red,))
                        //          : IconButton(onPressed: () => value.addShoppingCart(restaurant.id) , icon: Icon(Icons.favorite, color: Colors.red))
                        //         ],
                        //       );
                        //       }
                        //     );
                        //   },
                        // ),
                        const SizedBox(height: 30),
                        Text(
                          restaurant.description,
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(10),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      alignment: Alignment.center,
                      height: 30,
                      decoration:
                          const BoxDecoration(color: Colors.orange, boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 5))
                      ]),
                      child: const Text("Aneka Minuman"),
                    ),
                  ),
                ),
                menuList(restaurant.menus.drinks, MenuType.drink),
                SliverPadding(
                  padding: const EdgeInsets.all(10),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      alignment: Alignment.center,
                      height: 30,
                      decoration:
                          const BoxDecoration(color: Colors.orange, boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 5))
                      ]),
                      child: const Text("Aneka Makanan"),
                    ),
                  ),
                ),
                menuList(restaurant.menus.foods, MenuType.food)
              ],
            );
          } else if (value.state == DetailResultState.noData) {
            return const Center(child: Text("Maaf!! Sedang Terjadi Kesalahan"));
          } else if (value.state == DetailResultState.error) {
            return const Center(child: Text("No Connection"));
          } else {
            return const Text("");
          }
        },
      )),
    );
  }
}
