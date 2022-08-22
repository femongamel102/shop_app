import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app2022/helpers/custom_route.dart';
import 'package:shop_app2022/providers/auth.dart';
import 'package:shop_app2022/screens/orders_screen.dart';
import 'package:shop_app2022/screens/user_product_screen.dart';
import 'package:shop_app2022/widgets/app_divider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),

          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          const AppDivider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Orders'),
            onTap: (){
              //Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
              Navigator.of(context).pushReplacement(CustomRoute(
                builder: (ctx)=>const OrdersScreen(),
              )
              );
            },
          ),
          const AppDivider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Manage Products'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          const AppDivider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              //Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
              Provider.of<Auth>(context,listen: false).logout();
            },
          ),
          const AppDivider(),
        ],
      ),
    );
  }
}
