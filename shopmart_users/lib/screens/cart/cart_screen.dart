import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopmart_users/providers/cart_provider.dart';
import 'package:shopmart_users/screens/cart/bottom_checkout.dart';
import 'package:shopmart_users/screens/cart/cart_widget.dart';
import 'package:shopmart_users/services/my_app_functions.dart';
import 'package:shopmart_users/widgets/empty_bag.dart';
import 'package:shopmart_users/widgets/title_text.dart';
import '../../services/assets_manager.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
final bool isEmpty = false; //isEmpty is not true so else will work

  @override
  Widget build(BuildContext context) {
    //final productsProvider = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    return cartProvider.getCartItems.isEmpty ? Scaffold(  //if isEmpty is true
      body: EmptyBagWidget(imagePath: AssetsManager.shoppingBasket,
      title:"Yor cart is empty!!" ,
        subtitle: "Look like your cart is empty add something and make me happy",
        buttonText: "Shop now",
      )
    )
        : Scaffold( //if isEmpty is false
      bottomSheet: CartBottomSheet(),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset(AssetsManager.shoppingCart //Image.asset("${AssetsManager.shoppingCart}"),
          ),
        ),
        title: TitlesTextWidget(label: "Cart (${cartProvider.getCartItems.length})"),
        actions: [
          IconButton(onPressed: (){
            MyAppFunctions.showErrorOrWarningDialog(
                isError: false,
                context: context,
                subtitle: "Clear cart ?",
                fct: (){
                  cartProvider.clearLocalCart();
                });
          },
            icon: Icon(Icons.delete_forever_rounded,
          color: Colors.red,
          ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.getCartItems.length,
                itemBuilder: (context,index){
                  return ChangeNotifierProvider.value(
                      value: cartProvider.getCartItems.values.toList()[index],
                      child: CartWidget());
                }
            
            ),
          ),

          SizedBox(height: kBottomNavigationBarHeight+100)
        ],
      ),
    );
  }
}
