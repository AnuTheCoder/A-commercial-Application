import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopmart_users/providers/wishlist_provider.dart';
import 'package:shopmart_users/widgets/empty_bag.dart';
import 'package:shopmart_users/widgets/title_text.dart';

import '../../services/assets_manager.dart';
import '../../services/my_app_functions.dart';
import '../../widgets/products/product_widget.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = "/WishlistScreen";
  const WishlistScreen({super.key});
  final bool isEmpty = false; //if this bool is "true" then first part will work, if it is "false" then 2nd part will work

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    return wishlistProvider.getwishlistItems.isEmpty ? Scaffold(
        body: EmptyBagWidget(imagePath: AssetsManager.bagWish,
          title:"Nothing in your wishlist yet" ,
          subtitle: "Look like your cart is empty add something and make me happy",
          buttonText: "Shop now",
        )
    ) : Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset(AssetsManager.shoppingCart //Image.asset("${AssetsManager.shoppingCart}"),
          ),
        ),
        title: TitlesTextWidget(label: "Wishlist (${wishlistProvider.getwishlistItems.length})"),
        actions: [
          IconButton(onPressed: (){
            MyAppFunctions.showErrorOrWarningDialog(
                isError: false,
                context: context,
                subtitle: "Clear cart ?",
                fct: (){
                  wishlistProvider.clearLocalWishlist();
                });
          },
            icon: Icon(Icons.delete_forever_rounded,
            color: Colors.red,
          ),
          )
        ],
      ),
      body: DynamicHeightGridView(
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          builder: (context,index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ProductWidget(productId: wishlistProvider.getwishlistItems.values.toList()[index].productId),
            );
          },
          itemCount: wishlistProvider.getwishlistItems.length,
          crossAxisCount: 2),
    );
  }
}
