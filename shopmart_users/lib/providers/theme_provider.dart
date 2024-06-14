import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier{
  static const TTHEME_STATUS = "TTHEME_STATUS";   //key
  bool _darkTheme = false;    //value
  bool get getIsDarkTheme => _darkTheme;

  ThemeProvider(){
    getTheme();
  }
  setDarkTheme(bool value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(TTHEME_STATUS, value);    //value for a particular key
    _darkTheme = value;
    notifyListeners();
  }
  Future<bool> getTheme()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _darkTheme = prefs.getBool(TTHEME_STATUS)?? false;
    notifyListeners();
    return _darkTheme;
  }

}

/*
class ThemeProvider with ChangeNotifier { ... }: Defines a class named ThemeProvider that extends ChangeNotifier.
This implies that instances of this class can be used to manage state and notify listeners when the state changes.

static const TTHEME_STATUS = "TTHEME_STATUS";: Defines a constant string named TTHEME_STATUS,
which is used as a key for storing and retrieving theme status in shared preferences.

_darkTheme: A boolean property representing whether the dark theme is enabled. It defaults to false
getIsDarkTheme: A getter method that returns the current value of _darkTheme.

ThemeProvider() { ... }: Constructor for the ThemeProvider class.
Upon instantiation, it invokes the getTheme() method to initialize the theme state.

prefs.getBool(TTHEME_STATUS): This method call retrieves a boolean value from the shared preferences with the key TTHEME_STATUS.
This value represents whether the dark theme is enabled (true) or not (false). If the value is not found in the shared preferences, it returns null.

setDarkTheme(bool value) async { ... }: A method used to set the dark theme status. It takes a boolean parameter value,
which represents the new theme status. It then persists the theme status using SharedPreferences, updates the _darkTheme property,
and notifies listeners of the state change.

Future<bool> getTheme() async { ... }: A method used to retrieve the theme status.
It asynchronously retrieves the theme status from SharedPreferences, updates the _darkTheme property,
notifies listeners of the state change, and returns the retrieved theme status.
 */





/*
setDarkTheme(required bool themeValue) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(TTHEME_STATUS, themeValue);
    _darkTheme = themeValue;
    notifyListeners();
  }


  SwitchListTile(
                title: Text(themeprovider.getIsDarkTheme ? "Dark Mode" : "Light Mode"),
                value: themeprovider.getIsDarkTheme, onChanged: (value){
              themeprovider.setDarkTheme(themeValue: value);
            })
 */