import 'package:flutter/material.dart';
import 'package:makan_makan/Api/api_service.dart';
import 'package:makan_makan/Screen/page/widget/search_list.dart';
import 'package:makan_makan/provider/search.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  static const routeName = 'search_Page';

  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController textC = TextEditingController();
  String query = '';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchProvider(apiService: ApiService()),
      child: Consumer<SearchProvider>(
        builder: (context, search, _) {
          return Scaffold(
            body: SafeArea(
                child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: TextFormField(
                    onChanged: ((value) {
                      setState(() {
                        query = value;
                      });
                      search.searchData(value);
                    }),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        suffix: const Icon(Icons.search),
                        hintText: 'Cari Restaurant atau Menu'),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  child: query.isEmpty
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.search_sharp,
                              size: 50,
                              color: Colors.orange,
                            ),
                          ],
                        ))
                      : _searchResult(context),
                )
              ],
            )),
          );
        },
      ),
    );
  }

  Widget _searchResult(BuildContext context) {
    return Consumer<SearchProvider>(builder: (context, value, _) {
      if (value.state == SearchState.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (value.state == SearchState.hasData) {
        return Expanded(
          child: ListView.builder(
              itemCount: value.result.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = value.result.restaurants[index];
                return SearchResult(restaurant: restaurant);
              }),
        );
      } else if (value.state == SearchState.noData) {
        return const Center(
            child: Text('Tidak Ada Restaurant atau Menu Yang di Pilih'));
      } else if (value.state == SearchState.error) {
        return const Center(
          child: Text("Please Connect to he Internet"),
        );
      } else {
        return const Text('');
      }
    });
  }
}
