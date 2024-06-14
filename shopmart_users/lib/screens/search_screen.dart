import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopmart_users/providers/products_provider.dart';
import 'package:shopmart_users/widgets/products/product_widget.dart';
import '../models/product_model.dart';
import '../services/assets_manager.dart';
import '../widgets/title_text.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "/SearchScreen";
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  //TextEditingController searchTextController = TextEditingController(); or
  late TextEditingController searchTextController;

  @override
  void initState() {
    // TODO: implement initState
    searchTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchTextController.dispose();
    super.dispose();
  }

  List<ProductModel> productListSearch = [];

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    String? name = ModalRoute.of(context)!.settings.arguments as String?;
    List<ProductModel> productList = name == null ? productsProvider.products
        : productsProvider.findByCategory(
        categoryName: name);
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();   //touch anywhere in the screen to hide keyboard after typing . Wrap the entire scaffold with the GestureDetector
      },
      child: Scaffold(
        appBar:AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset(AssetsManager.shoppingCart
            ),
          ),
          title: TitlesTextWidget(label: name ?? "Search Products"),
        ),
        body: productList.isEmpty ? Center(child: TitlesTextWidget(label: "No products found"))
            :Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 10,),
              TextField(
                controller: searchTextController,
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: GestureDetector(
                    onTap: (){
                      setState(() {
                        FocusScope.of(context).unfocus();
                        searchTextController.clear();
                      });
                    },
                      child: Icon(Icons.clear,
                      color: Colors.blue,
                      ),
                  ),
                ),
                onChanged: (value){
                  setState(() {
                    productListSearch = productsProvider.searchQuery(searchText: searchTextController.text,
                      passedList: productList
                    );
                  });
                },
                onSubmitted: (value){
                 setState(() {
                   productListSearch = productsProvider.searchQuery(searchText: searchTextController.text,
                   passedList: productList
                   );
                 });
                },
              ),


              SizedBox(height: 20,),

              if(searchTextController.text.isNotEmpty && productListSearch.isEmpty)...[
                Center(child: TitlesTextWidget(label: "No Products Found"))
              ],
              //searchTextController.text.isNotEmpty && productListSearch.isEmpty ? Center(child: TitlesTextWidget(label: "No Products Found")) :
              Expanded(
                child: DynamicHeightGridView(
                 // itemCount: productsProvider.getProducts.length,
                  itemCount: searchTextController.text.isNotEmpty ? productListSearch.length
                      :productList.length,
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    builder: (context,index){
                      //return ProductWidget(productId: productsProvider.getProducts[index].productId);
                      return ProductWidget(
                          productId: searchTextController.text.isNotEmpty ? productListSearch[index].productId
                              :productList[index].productId);
                    },
                   ),
              )
            ],
          ),
        )
      ),
    );
  }
}
