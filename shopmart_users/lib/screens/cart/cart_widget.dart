import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopmart_users/consts/app_constants.dart';
import 'package:shopmart_users/screens/cart/quantity_btm_sheet.dart';
import 'package:shopmart_users/widgets/products/heart_btn.dart';
import 'package:shopmart_users/widgets/subtitle_text.dart';

import '../../models/cart_model.dart';
import '../../models/product_model.dart';
import '../../providers/cart_provider.dart';
import '../../providers/products_provider.dart';
import '../../widgets/title_text.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cartModel = Provider.of<CartModel>(context);
    final productsProvider = Provider.of<ProductsProvider>(context);
    final getCurrentProduct = productsProvider.findByProdId(cartModel.productId);
    final cartProvider = Provider.of<CartProvider>(context);
    return getCurrentProduct == null ? SizedBox.shrink()
        : FittedBox(
      child: IntrinsicWidth(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: FancyShimmerImage(
                  imageUrl: getCurrentProduct.productImage,
                  height: size.height *0.1,
                  width: size.width *0.2,
                ),
              ),
              SizedBox(width: 10,),
              IntrinsicWidth(
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                            width: size.width *0.6,
                            child: TitlesTextWidget(label: getCurrentProduct.productTitle,
                                maxLines: 2
                            )
                        ),

                        Column(
                          children: [
                            IconButton(onPressed: (){
                              cartProvider.removeOneItem(productId: getCurrentProduct.productId);
                            },
                              icon: Icon(Icons.clear,
                                  color: Colors.blue),
                            ),

                            HeartButtonWidget(
                              productId: getCurrentProduct.productId,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SubtitleTextWidget(label: "${getCurrentProduct.productPrice}\$",
                          color: Colors.blue,
                        ),
                        const Spacer(),


                        OutlinedButton.icon(onPressed: () async{
                          await showModalBottomSheet(context: context, builder: (context){
                            return QuantityBottomSheetWidget(
                              cartModel: cartModel
                            );
                            },
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)
                              )
                            )
                          );
                        },
                          icon: Icon(IconlyLight.arrowDown2),
                          label: Text("Qty: ${cartModel.quantity}"),
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                  width: 1
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)
                              )
                          ),
                        ),


                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


/*
Determining Intrinsic Width: When you wrap a widget with IntrinsicWidth,
the IntrinsicWidth widget measures the intrinsic width of its child during the layout phase.
This means it calculates the width that the child prefers to have based on its content and constraints.
Applying Constraints: After determining the child's intrinsic width, IntrinsicWidth applies constraints to its child during layout.
These constraints ensure that the child doesn't exceed its intrinsic width but can still expand to occupy all available horizontal space if needed.
Flexibility: If the child's intrinsic width is less than the available width,
it will be expanded to match the available width. If the intrinsic width is greater than the available width,
the child will be constrained to the available width, and overflow might occur, depending on how the child handles overflow.
 In Flutter, FittedBox is a widget used to scale and fit its child within the available space.
 It's particularly useful when you want to ensure that the child widget maintains its aspect ratio while fitting within its parent widget.
 */