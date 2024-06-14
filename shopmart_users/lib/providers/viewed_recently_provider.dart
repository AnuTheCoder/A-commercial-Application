import 'package:flutter/material.dart';
import 'package:shopmart_users/models/viewd_products.dart';
import 'package:uuid/uuid.dart';

class ViewedProdProvider with ChangeNotifier{

  final Map<String, ViewedProdModel> _viewdProdItems = {};
  Map<String, ViewedProdModel> get getviewedProdItems {
    return _viewdProdItems;
  }


  void addViewedProd({required String productId}){
      _viewdProdItems.putIfAbsent(
          productId, () => ViewedProdModel(viewedProdId: Uuid().v4(), productId: productId)
      );
    }
    notifyListeners(); //Keep listening to the changes


  void clearViewedProducts(){
    _viewdProdItems.clear();
    notifyListeners();
  }
  }


