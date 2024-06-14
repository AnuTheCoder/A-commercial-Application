import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopmart_users/screens/auth/register.dart';
import 'package:shopmart_users/screens/inner_screen/orders/orders_screen.dart';
import 'package:shopmart_users/screens/inner_screen/viewed_recently.dart';
import 'package:shopmart_users/screens/inner_screen/wishlist.dart';
import 'package:shopmart_users/services/assets_manager.dart';
import 'package:shopmart_users/widgets/app_name_text.dart';
import 'package:shopmart_users/widgets/subtitle_text.dart';
import '../providers/theme_provider.dart';
import '../services/my_app_functions.dart';
import '../widgets/title_text.dart';
import 'auth/login.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeprovider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset(AssetsManager.shoppingCart //Image.asset("${AssetsManager.shoppingCart}"),
          ),
        ),
        title: AppNameTextWidget(),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Visibility(
              visible: false, //text will not visible
              child: Padding(
                padding: EdgeInsets.all(100.0),
                child: TitlesTextWidget(label: "Please Login...!!!"),
              ),
            ),

            Visibility(
              visible: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                child: Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).cardColor,
                        border: Border.all(
                          //color: Theme.of(context).colorScheme.background,
                          color: Colors.blue,
                          width: 3
                        ),
                        image: const DecorationImage(
                          image: NetworkImage("https://images.unsplash.com/photo-1583693034345-b6c1d5b2ffa6?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fHB1cnBsZSUyMGZsb3dlcnN8ZW58MHx8MHx8fDA%3D"),
                          fit: BoxFit.fill
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitlesTextWidget(label: "Anusree"),
                        SizedBox(height: 6),
                        TitlesTextWidget(label: "anusreeanu021@gmail.com")
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                      thickness: 1
                  ),
                  const TitlesTextWidget(label: "General"),
                  const SizedBox(height: 10),
                  CustomListTile(imagePath: AssetsManager.orderSvg, text: "All Orders", fuction: (){
                    Navigator.pushNamed(context, OrdersScreenFree.routeName);
                  }),
                  CustomListTile(imagePath: AssetsManager.wishlistSvg, text: "Wishlist", fuction: (){
                    Navigator.pushNamed(context, WishlistScreen.routeName);
                  }),
                  CustomListTile(imagePath: AssetsManager.recent, text: "Viewed recently", fuction: (){
                    Navigator.pushNamed(context, ViewedRecentlyScreen.routeName);
                  }),
                  CustomListTile(imagePath: AssetsManager.address, text: "Address", fuction: (){
                    Navigator.pushNamed(context, RegisterScreen.routeName);
                  }),
                  const SizedBox(height: 10,),
                  const Divider(
                   thickness: 1
                 ),
                  const SizedBox(height: 10,),
                  const TitlesTextWidget(label: "Settings"),
                  const SizedBox(height: 10),
                  SwitchListTile(
                    secondary: Image.asset(AssetsManager.theme,height: 30),
                      title: Text(themeprovider.getIsDarkTheme ? "Dark Mode" : "Light Mode"),
                      value: themeprovider.getIsDarkTheme,
                      onChanged: (value){
                    themeprovider.setDarkTheme(value);
                  })
                ],
              ),
            ),
            Center(child: ElevatedButton.icon(
                onPressed: () async{
                  await MyAppFunctions.showErrorOrWarningDialog(context: context,
                      subtitle: "Are you sure you want to signout",
                      fct: (){
                      },
                    isError: false
                  );
                },
                icon: const Icon(Icons.login),
                label: const Text("Login"),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: Colors.blue
              ),
            ),
            )
          ],
        ),
      )
    );
  }
}


class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key, required this.imagePath, required this.text, required this.fuction});

  final String imagePath,text;
  final Function fuction;
  @override
  Widget build(BuildContext context) {
    return ListTile(onTap: (){fuction();},
      title: SubtitleTextWidget(label: text,textDecoration: TextDecoration.none,color: Colors.blue,fontSize: 15,),
      leading: Image.asset(imagePath,height: 30),
      trailing: const Icon(IconlyLight.arrowRight2),
    );
  }
}



/*
SwitchListTile Widget:
SwitchListTile is a Flutter widget that combines a ListTile with a Switch.
It's commonly used to present an option that can be toggled on or off.

title:
The title parameter specifies the text that appears as the title of the list tile.
In this case, it displays "Dark Mode" if themeprovider.getIsDarkTheme is true, otherwise, it displays "Light Mode".
This gives users an indication of the current mode.

value:
The value parameter determines whether the switch is currently in the "on" (true) or "off" (false) position.
It's set to themeprovider.getIsDarkTheme, which reflects the current state of the dark mode based on the value stored in the ThemeProvider.
onChanged:
The onChanged callback is triggered when the user toggles the switch.
It takes a boolean parameter value, which represents the new value of the switch (i.e., true for on, false for off).
In this case, it calls themeprovider.setDarkTheme(value) to update the theme based on the user's selection.
The setDarkTheme method in the ThemeProvider class handles persisting the selected theme and updating the application's UI.
 */
