import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app2022/providers/products.dart';
import 'package:shop_app2022/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  const UserProductItem(this.id,this.title,this.imageUrl, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final scaffold =ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: (){
                  Navigator.of(context).pushNamed(EditProductScreen.routeName,arguments:id );
                },
                icon: const Icon(Icons.edit),
                color: Theme.of(context).colorScheme.primary,
            ),
            IconButton(
                onPressed: ()async{
                  try{
                    await Provider.of<Products>(context,listen: false)
                        .deleteProduct(id);
                  }catch(error){
                    scaffold.showSnackBar(SnackBar(
                      content: Text('Deleting failed!',textAlign: TextAlign.center,),
                    ));
                  }
                },
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
