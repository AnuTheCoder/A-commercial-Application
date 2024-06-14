import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopmart_users/providers/cart_provider.dart';
import 'package:shopmart_users/providers/products_provider.dart';
import 'package:shopmart_users/providers/theme_provider.dart';
import 'package:shopmart_users/providers/viewed_recently_provider.dart';
import 'package:shopmart_users/providers/wishlist_provider.dart';
import 'package:shopmart_users/screens/auth/login.dart';
import 'package:shopmart_users/screens/auth/register.dart';
import 'package:shopmart_users/screens/inner_screen/orders/orders_screen.dart';
import 'package:shopmart_users/screens/inner_screen/product_details.dart';
import 'package:shopmart_users/screens/inner_screen/viewed_recently.dart';
import 'package:shopmart_users/screens/inner_screen/wishlist.dart';
import 'package:shopmart_users/screens/search_screen.dart';
import 'package:shopmart_users/widgets/root_screen.dart';

import 'consts/theme_data.dart';
import 'screens/auth/forgot_password.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_){
          return ThemeProvider();
        }),
        ChangeNotifierProvider(create: (_){
          return ProductsProvider();
        }),
        ChangeNotifierProvider(create: (_){
          return CartProvider();
        }),
        ChangeNotifierProvider(create: (_){
          return WishlistProvider();
        }),
        ChangeNotifierProvider(create: (_){
          return ViewedProdProvider();
        })
      ],
      child: Consumer<ThemeProvider>(
        builder: (context,themeProvider,child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'ShopsMart EN',
            // theme: ThemeData(
            //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            //   useMaterial3: true,
            //   scaffoldBackgroundColor: Colors.deepPurple[100],
            //   appBarTheme: AppBarTheme(
            //     color: Colors.deepPurple[200]
            //   ),
            // ),
            theme: Styles.themeData(isDarkTheme:themeProvider.getIsDarkTheme, context:context),
           // home: const RootScreen(),
            home: LoginScreen(),
            routes: {
              ProductDetailsScreen.routeName: (context) => ProductDetailsScreen(),
              ViewedRecentlyScreen.routeName: (context) => ViewedRecentlyScreen(),
              WishlistScreen.routeName: (context) => WishlistScreen(),
              RegisterScreen.routeName: (context) => RegisterScreen(),
              LoginScreen.routeName: (context) => LoginScreen(),
              RootScreen.routeName: (context) => RootScreen(),
          OrdersScreenFree.routeName: (context) => OrdersScreenFree(),
              ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
              SearchScreen.routeName: (context) => SearchScreen()
            },
          );
        }
      ),
    );
  }
}
/*
Styles.themeData(): This calls the static method themeData from the Styles class to generate a ThemeData object.
Since themeData is a static method, it is called directly on the Styles class without needing to instantiate an object of that class.

isDarkTheme: The isDarkTheme parameter is passed to the themeData method.
This parameter is likely a boolean value indicating whether the theme should be dark (true) or light (false).
It seems to be fetched from themeProvider.getIsDarkTheme.

BuildContext is often required in Flutter widgets and methods to access various contextual information.
In this case, it might not be directly used within the themeData method, but it's included as a parameter.
*/
