import '../models/categories_model.dart';
import '../services/assets_manager.dart';

class AppConstants{
  static const String imageUrl =
      'https://images.unsplash.com/photo-1465572089651-8fde36c892dd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80';
static List <String> bannerImage = [AssetsManager.banner1,AssetsManager.banner2];

static List<CategoriesModel> categoriesList = [
  CategoriesModel(id: AssetsManager.mobiles, name: "Phones", image: AssetsManager.mobiles),
  CategoriesModel(id: AssetsManager.electronics, name: "Electronics", image: AssetsManager.electronics),
  CategoriesModel(id: AssetsManager.cosmetics, name: "Accessories", image: AssetsManager.cosmetics),
  CategoriesModel(id: AssetsManager.fashion, name: "Fashion", image: AssetsManager.fashion),
  CategoriesModel(id: AssetsManager.shoes, name: "Shoes", image: AssetsManager.shoes),
  CategoriesModel(id: AssetsManager.pc, name: "Laptops", image: AssetsManager.pc),
  CategoriesModel(id: AssetsManager.watch, name: "Watch", image: AssetsManager.watch),
  CategoriesModel(id: AssetsManager.bookImg, name: "Books", image: AssetsManager.bookImg),
];
}