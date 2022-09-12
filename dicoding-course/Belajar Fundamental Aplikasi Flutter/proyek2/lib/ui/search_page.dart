import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyek2/common/styles.dart';
import 'package:proyek2/provider/search_provider.dart';
import 'package:proyek2/widget/card_search.dart';

class SearchPage extends StatelessWidget {
  static const routeName = '/search_page';
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: TextField(
          autofocus: true,
          cursorColor: foregroundColor,
          decoration: const InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            hintText: 'Search Restaurant, Menus, or Category',
            hintStyle: TextStyle(
              color: foregroundColor,
            ),
          ),
          style: const TextStyle(color: foregroundColor),
          onChanged: (value) {
            final searchProvider =
                Provider.of<SearchProvider>(context, listen: false);
            searchProvider.setQuery(value.trim());
          },
        ),
        foregroundColor: foregroundColor,
      ),
      body: Consumer<SearchProvider>(
        builder: (context, value, child) {
          if (value.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (value.state == ResultState.hasData) {
            return const SearchList();
          } else if (value.query.isEmpty) {
            return const Center(
              child: Text(
                "Silahkan cari restoran berdasarkan nama, menu atau kategori!",
                textAlign: TextAlign.center,
              ),
            );
          } else if (value.state == ResultState.noData) {
            return Center(
              child: Text("Restoran ${value.query} tidak ditemukan!"),
            );
          } else if (value.state == ResultState.error) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.wifi_off_rounded,
                      size: 50,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Tidak tersambung ke Internet!',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Material(
                child: Text('Restaurant is missing'),
              ),
            );
          }
        },
      ),
    );
  }
}

class SearchList extends StatelessWidget {
  const SearchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return ListView.builder(
      shrinkWrap: true,
      itemCount: searchProvider.result.restaurants.length,
      itemBuilder: (context, index) {
        var searchItem = searchProvider.result.restaurants[index];
        return CardSearch(
          searchModel: searchItem,
        );
      },
    );
  }
}
