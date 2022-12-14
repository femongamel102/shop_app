import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app2022/providers/products.dart';
import 'package:shop_app2022/screens/cart_screen.dart';
import 'package:shop_app2022/widgets/app_drawer.dart';
import '../providers/cart.dart';
import '../widgets/badge.dart';

import '../widgets/products_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading=false;

  @override
  void initState() {
    // Future.delayed(Duration.zero).then((_) {
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(_isInit){
      setState((){_isLoading =true;});

      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState((){_isLoading =false;});
      });
    }
    _isInit=false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop!'),
        actions: [
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favorites) {
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites = false;
                  }
                });
              },
              icon: const Icon(
                Icons.more_vert,
              ),
              itemBuilder: (_) => [
                    const PopupMenuItem(
                      value: FilterOptions.Favorites,
                      child: Text('Only Favorite'),
                    ),
                    const PopupMenuItem(
                      value: FilterOptions.All,
                      child: Text('Show All'),
                    ),
                  ]
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              value: cart.itemCount.toString(),
              child: ch as Widget,
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: _isLoading ? const Center(
        child: CircularProgressIndicator(),
      ): ProductsGrid(_showOnlyFavorites),
    );
  }
}
