import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopmart_users/widgets/subtitle_text.dart';
import 'package:shopmart_users/widgets/title_text.dart';

import '../../providers/cart_provider.dart';
import '../../providers/products_provider.dart';

class CartBottomSheet extends StatelessWidget {
  const CartBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1,
          color: Colors.grey)
        ),
        //borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: kBottomNavigationBarHeight *2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                        child: TitlesTextWidget(
                            label: "Total (${cartProvider.getCartItems.length} products/${cartProvider.getQty()} items)" ),
                    ),
                    SubtitleTextWidget(label: "${cartProvider.getTotal(
                        productsProvider: productsProvider).toStringAsFixed(2)}\$",
                        color: Colors.blue)
                  ],
                ),
              ),
              ElevatedButton(onPressed: (){}, child: Text("Checkout"))
            ],
          ),
        ),
      ),
    );
  }
}
