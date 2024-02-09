import 'package:flutter/material.dart';
import 'package:local_bee/Model/LocalShop.dart';
import 'package:local_bee/Views/shop_view/shop_card_view.dart';
import 'package:local_bee/Controller/local_shop_controller.dart';
import 'package:local_bee/Views/ViewData/show_error_dialog.dart';
import 'package:local_bee/Views/ViewData/search_bar.dart';

class LocalShopView extends StatefulWidget {
  @override
  _LocalShopViewState createState() => _LocalShopViewState();
}

class _LocalShopViewState extends State<LocalShopView> {
  String filterType = 'All'; // Could be 'All', 'Café', 'Restaurant', 'Boutique'
  String searchQuery = '';
  final LocalShopController _controller = LocalShopController();
  Map<String, List<LocalShop>> _groupedLocalShops = {};
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchShops();
  }

  Future<void> _fetchShops() async {
    try {
      final groupedShops = await _controller.fetchLocalShopsGroupedByType();
      setState(() {
        _groupedLocalShops = groupedShops;
      });
    } catch (e) {
      // If there's an error, display it using your reusable error dialog
      final errorMessage = e.toString().replaceAll('Exception: ', '');
      showErrorDialog(context, 'Login Failed', errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> buildShopList() {
      if (searchQuery.isEmpty) {
        return _groupedLocalShops.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                child: Text(
                  '${entry.key}s',
                  style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 210,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: entry.value.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: LocalCardView(localShop: entry.value[index]),
                    );
                  },
                ),
              ),
            ],
          );
        }).toList();
      } else {
        // If there is a search query, flatten all lists into one and filter
        var allShops =
            _groupedLocalShops.values.expand((shops) => shops).toList();
        var filteredShops = allShops
            .where((shop) =>
                shop.name.toLowerCase().contains(searchQuery.toLowerCase()))
            .toList();

        return [
          for (var shop in filteredShops) LocalCardView(localShop: shop),
        ];
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Shops'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Open filter dialog or menu
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomSearchBar(
                  controller: _searchController,
                  onChanged: (value) => setState(() => searchQuery = value),
                  hintText: "Search local shops")),
          Expanded(
            child: ListView(
              children: buildShopList(),
            ),
          ),
        ],
      ),
    );
  }
}
