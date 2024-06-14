import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopmart_users/widgets/empty_bag.dart';
import 'package:shopmart_users/widgets/title_text.dart';

import '../../providers/viewed_recently_provider.dart';
import '../../services/assets_manager.dart';
import '../../services/my_app_functions.dart';
import '../../widgets/products/product_widget.dart';

class ViewedRecentlyScreen extends StatelessWidget {
  static const routeName = "/ViewedRecentlyScreen";
  const ViewedRecentlyScreen({super.key});
  final bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    return viewedProdProvider.getviewedProdItems.isEmpty ?
    Scaffold(
        body: EmptyBagWidget(imagePath: AssetsManager.orderimg,
          title:"No Viewed products yet" ,
          subtitle: "Look like your cart is empty add something and make me happy",
          buttonText: "Shop now",
        )
    ) : Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset(
              AssetsManager.shoppingCart //Image.asset("${AssetsManager.shoppingCart}"),
          ),
        ),
        title: TitlesTextWidget(label: "Viewed recently (${viewedProdProvider.getviewedProdItems.length})"),
        actions: [
          IconButton(onPressed: (){
            MyAppFunctions.showErrorOrWarningDialog(
                isError: false,
                context: context,
                subtitle: "Clear cart ?",
                fct: (){
                  viewedProdProvider.clearViewedProducts();
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
              child: ProductWidget(productId: viewedProdProvider.getviewedProdItems.values.toList()[index].productId),
            );
          },
          itemCount: viewedProdProvider.getviewedProdItems.length,
          crossAxisCount: 2),
    );
  }
}
