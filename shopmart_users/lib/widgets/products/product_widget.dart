import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopmart_users/consts/app_constants.dart';
import 'package:shopmart_users/models/product_model.dart';
import 'package:shopmart_users/providers/viewed_recently_provider.dart';
import 'package:shopmart_users/widgets/products/heart_btn.dart';
import 'package:shopmart_users/widgets/subtitle_text.dart';
import 'package:shopmart_users/widgets/title_text.dart';

import '../../providers/cart_provider.dart';
import '../../providers/products_provider.dart';
import '../../screens/inner_screen/product_details.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key, required this.productId});

  final String productId;
  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    //final productModelProvider = Provider.of<ProductModel>(context);
    final productsProvider = Provider.of<ProductsProvider>(context);
    final getCurrentProduct = productsProvider.findByProdId(widget.productId);
    final cartProvider = Provider.of<CartProvider>(context);
    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    Size size = MediaQuery.of(context).size;
    return getCurrentProduct == null ? SizedBox.shrink()
        :Padding(
      padding: const EdgeInsets.all(0.0),
      child: GestureDetector(
        onTap: () async{
          viewedProdProvider.addViewedProd(productId: getCurrentProduct.productId);
          await Navigator.pushNamed(context, ProductDetailsScreen.routeName,
          arguments: getCurrentProduct.productId
          );
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: FancyShimmerImage(imageUrl: getCurrentProduct.productImage,
              height: size.height * 0.22,
                width: double.infinity,
              ),
            ),

            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Flexible(
                      flex: 5,
                child: TitlesTextWidget(label: getCurrentProduct.productTitle,maxLines: 2)),//Flexible or expanded for text overflow in a row
                  Flexible(
                    flex: 2,
                    child: HeartButtonWidget(
                      productId: getCurrentProduct.productId,
                    ),
                    ),
                ],
              ),
            ),

            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      flex: 5,
                      child: SubtitleTextWidget(label: "${getCurrentProduct.productPrice}\$",color: Colors.blue,fontWeight: FontWeight.w600)),//Flexible or expanded for text overflow in a row
                  Flexible(
                    //child: IconButton(onPressed: (){}, icon: Icon(Icons.add_shopping_cart_outlined),),
                    child: Material(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.blue,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: (){
                          if(cartProvider.isProdinCart(productId: getCurrentProduct.productId)){
                            return;
                          }
                          cartProvider.addProductToCart(productId: getCurrentProduct.productId);
                        },
                        splashColor: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Icon(
                            cartProvider.isProdinCart(productId: getCurrentProduct.productId)
                               ? Icons.check
                            : Icons.add_shopping_cart_outlined,
                          size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
