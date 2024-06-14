import 'package:flutter/material.dart';
import 'package:shopmart_users/models/wishlist_model.dart';
import 'package:uuid/uuid.dart';

class WishlistProvider with ChangeNotifier{

  final Map<String, WishlistModel> _wishlistItems = {};
  Map<String, WishlistModel> get getwishlistItems {
    return _wishlistItems;
  }


  void addOrRemoveFromWishlist({required String productId}){
    if(_wishlistItems.containsKey(productId)){
      _wishlistItems.remove(productId);
    }
    else{
      _wishlistItems.putIfAbsent(
          productId, () => WishlistModel(wishlistId: Uuid().v4(),
          productId: productId)
      );
    }
    notifyListeners(); //Keep listening to the changes
  }


  bool isProdinWishlist ({required String productId}){
    return _wishlistItems.containsKey(productId);
  }



  void clearLocalWishlist(){
    _wishlistItems.clear();
    notifyListeners();
  }




}

