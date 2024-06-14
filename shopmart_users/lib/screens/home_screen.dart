import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopmart_users/consts/app_constants.dart';
import 'package:shopmart_users/widgets/app_name_text.dart';
import 'package:shopmart_users/widgets/products/ctg_rounded_widget.dart';
import 'package:shopmart_users/widgets/products/latest_arrival.dart';
import 'package:shopmart_users/widgets/title_text.dart';

import '../providers/products_provider.dart';
import '../services/assets_manager.dart';

class HomeScreen extends StatelessWidget {
 const HomeScreen({super.key});//Constructor of the `HomeScreen` class.
  // It doesn't take any parameters and simply calls the superclass constructor.

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productsProvider = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset(AssetsManager.shoppingCart //Image.asset("${AssetsManager.shoppingCart}"),
          ),
        ),
        title: AppNameTextWidget(fontSize: 20),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              SizedBox(
                height: size.height * 0.25,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Swiper(
                    autoplay: true,
                  itemBuilder: (context, index) {
                      return Image.asset(
                        AppConstants.bannerImage[index],
                      fit: BoxFit.fill,
                      );
                    },
                        itemCount: AppConstants.bannerImage.length,
                        pagination: const SwiperPagination(
                          builder: DotSwiperPaginationBuilder(
                            color: Colors.white,
                            activeColor: Colors.blue
                          )
                        ),
                        //control: const SwiperControl(),
                      ),
                ),
              ),

              SizedBox(height: 10,),
              TitlesTextWidget(label: "Latest Arrival"),
              SizedBox(height: 10,),

              SizedBox(
                height: size.height *0.2,
                child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                  return ChangeNotifierProvider.value(
                      value: productsProvider.getProducts[index],
                      child: LatestArrivalProductsWidget());
                }),
              ),

              SizedBox(height: 10,),
              TitlesTextWidget(label: "Categories"),
              SizedBox(height: 10,),

              GridView.count(
                shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
              children: List.generate(AppConstants.categoriesList.length, (index) {
                return CategoryRoundedWidget(image: AppConstants.categoriesList[index].image,
                    name: AppConstants.categoriesList[index].name);
              })
              ),
            ],
          ),
        ),
      ),
    );
  }
}

