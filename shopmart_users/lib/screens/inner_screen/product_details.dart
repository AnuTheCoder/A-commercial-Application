import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopmart_users/widgets/title_text.dart';
import '../../consts/app_constants.dart';
import '../../models/product_model.dart';
import '../../providers/cart_provider.dart';
import '../../providers/products_provider.dart';
import '../../widgets/app_name_text.dart';
import '../../widgets/products/heart_btn.dart';
import '../../widgets/subtitle_text.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = "/ProductDetailsScreen";
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    String? productId = ModalRoute.of(context)!.settings.arguments as String?;
    final getCurrentProduct = productsProvider.findByProdId(productId!);
    final cartProvider = Provider.of<CartProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        //automaticallyImplyLeading: false, //To disable back arrow
        leading: IconButton(onPressed: (){
          //Navigator.canPop(context) ? Navigator.pop(context) : null;
          if(Navigator.canPop(context)){
            Navigator.pop(context);
          }
        },
          icon: Icon(Icons.arrow_back_ios,size: 20),
        ),
        title: AppNameTextWidget(fontSize: 20),
      ),
body: getCurrentProduct == null ?
SizedBox.shrink()
:SingleChildScrollView(
  scrollDirection: Axis.vertical,
  child: Column(
    children: [
      FancyShimmerImage(
        //imageUrl: AppConstants.imageUrl,
        imageUrl: getCurrentProduct.productImage,
        height: size.height * 0.38,
        width: double.infinity,
      ),

      SizedBox(height: 20,),

      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(child: Text(getCurrentProduct.productTitle,
                  softWrap: true,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20
                  ),
                ),
                ),

                const SizedBox(width: 20,),

                SubtitleTextWidget(label: "${getCurrentProduct.productPrice}\$",color: Colors.blue,fontWeight: FontWeight.w700,
                    fontSize: 20
                ),
              ],
            ),

            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HeartButtonWidget(
                      productId: getCurrentProduct.productId,
                      bkgColor: Colors.blue.shade100),

                  SizedBox(width: 20.0),

                  Expanded(
                    child: SizedBox(
                      height: kBottomNavigationBarHeight - 10,
                      child: ElevatedButton.icon(
                        onPressed: (){
                          if(cartProvider.isProdinCart(productId: getCurrentProduct.productId)){
                            return;
                          }
                          cartProvider.addProductToCart(productId: getCurrentProduct.productId);
                        },
                        icon: Icon(
                          cartProvider.isProdinCart(productId: getCurrentProduct.productId)
                              ? Icons.check
                              : Icons.add_shopping_cart_outlined,
                            size: 20,
                            color: Colors.white,
                        ),
                        label: Text(
                            cartProvider.isProdinCart(productId: getCurrentProduct.productId)
                                ? "In cart"
                                :"Add to cart"

                        ),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: Colors.blue
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitlesTextWidget(label: "About this item",fontSize: 25,),
                SubtitleTextWidget(label: "${getCurrentProduct.productCategory}",color: Colors.black,fontSize: 20)
              ],
            ),
            SizedBox(height: 25,),
            SubtitleTextWidget(label: getCurrentProduct.productDescription,
            color: Colors.black,
            fontSize: 15)
          ],
        ),
      )
    ],
  ),
),
    );
  }
}
