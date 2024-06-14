import 'package:flutter/material.dart';
import 'package:shopmart_users/providers/products_provider.dart';
import 'package:uuid/uuid.dart';

import '../models/cart_model.dart';

class CartProvider with ChangeNotifier{
  
  final Map<String, CartModel> _cartItems = {};
  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }
  
  
  void addProductToCart({required String productId}){
    _cartItems.putIfAbsent(
      productId, () => CartModel(     //productId is the Key
      cartId: const Uuid().v4(),
        productId: productId,
        quantity: 1),
    );
    notifyListeners(); //Keep listening to the changes
}

bool isProdinCart ({required String productId}){
    return _cartItems.containsKey(productId);
}

double getTotal({required ProductsProvider productsProvider}){
    double total = 0.0;
  _cartItems.forEach((key, value) {
    final getCurrentProduct = productsProvider.findByProdId(value.productId);
    if(getCurrentProduct == null){
      total += 0;
    }
    else{
      total += double.parse(getCurrentProduct.productPrice) * value.quantity;
    }
  });
  return total;
}


int getQty(){
    int total = 0;
    _cartItems.forEach((key, value) {
      total += value.quantity;
    });
    return total;
}



  void updateQty({required String productId, required int qty}){
    _cartItems.update(
      productId, (cartItem) => CartModel(     //productId is the Key
        cartId: cartItem.cartId,
        productId: productId,
        quantity: qty),
    );
    notifyListeners(); //Keep listening to the changes
  }


  void clearLocalCart(){
    _cartItems.clear();
    notifyListeners();
  }

  void removeOneItem({required String productId}){
    _cartItems.remove(productId);
    notifyListeners();
  }




}




/*
    "key": "values";
    "key1": "values";
    key should be unique
   */