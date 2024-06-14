import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shopmart_users/providers/viewed_recently_provider.dart';
import '../../models/product_model.dart';
import '../../providers/cart_provider.dart';
import '../../providers/wishlist_provider.dart';
import '../../screens/inner_screen/product_details.dart';
import '../subtitle_text.dart';
import 'heart_btn.dart';

class LatestArrivalProductsWidget extends StatelessWidget {
  const LatestArrivalProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final productsModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: ()async{
          viewedProdProvider.addViewedProd(productId: productsModel.productId);
          await Navigator.pushNamed(context, ProductDetailsScreen.routeName,
          arguments: productsModel.productId
          );
        },
        child: SizedBox(
          width: size.width *0.45,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FancyShimmerImage(
                      imageUrl: productsModel.productImage,
                    height: size.height * 0.12,
                    width: size.width *0.32
                  ),
                ),
              ),

              SizedBox(width: 5,),

              Flexible(
                child: Column(
                  children: [
                    SizedBox(height: 5,),
                    Text(productsModel.productTitle, maxLines: 2, overflow: TextOverflow.ellipsis),

                    FittedBox(
                      child: Row(
                        children: [
                          HeartButtonWidget(
                            productId: productsModel.productId,
                          ),
                          IconButton(onPressed: (){
                            if(cartProvider.isProdinCart(productId: productsModel.productId)){
                              return;
                            }
                            cartProvider.addProductToCart(productId: productsModel.productId);
                          }, icon: Icon(
                            cartProvider.isProdinCart(productId: productsModel.productId)
                                ? Icons.check
                                : Icons.add_shopping_cart_outlined,
                            size: 20,
                            color: Colors.white,
                          ),
                          ),

                        ],
                      ),
                    ),

                  FittedBox(
                      child: SubtitleTextWidget(label: "${productsModel.productPrice}\$",
                          color: Colors.blue,
                          fontWeight: FontWeight.w600)),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
