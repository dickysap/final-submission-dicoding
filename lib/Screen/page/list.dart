import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:makan_makan/Screen/page/search.dart';
import 'package:makan_makan/Screen/page/widget/product_list.dart';
import 'package:provider/provider.dart';
import 'package:makan_makan/provider/restaurant_result.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ResultProvider>(builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return Center(
            child: Lottie.asset('assets/lottie/loading.json'),
          );
        } else if (state.state == ResultState.hasData) {
          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SafeArea(
                    child: SizedBox(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Warung Tiwi",
                            style: TextStyle(fontSize: 25),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, SearchPage.routeName);
                            },
                            child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Promo For You",
                        textAlign: TextAlign.left,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            "See All",
                            style: TextStyle(
                                color: Color.fromARGB(190, 251, 152, 4)),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 100,
                    child: PageView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 100,
                          margin: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/img/slide-1.png'),
                                  fit: BoxFit.cover)),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.result.restaurants.length,
                      itemBuilder: (context, index) {
                        var restaurant = state.result.restaurants[index];
                        return ProductList(
                          restaurant: restaurant,
                        );
                      }),
                ],
              ),
            ),
          );
        } else if (state.state == ResultState.noData) {
          return Center(child: Lottie.asset('assets/lottie/error.json'));
        } else if (state.state == ResultState.error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/lottie/no_internet.json'),
                const SizedBox(height: 20),
                const Icon(
                  Icons.signal_wifi_off,
                  size: 100,
                  color: Colors.blue,
                )
              ],
            ),
          );
        } else {
          return const Center(child: Text(''));
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
      ),
    );
  }
}
