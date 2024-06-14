import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shopmart_users/consts/validator.dart';
import 'package:shopmart_users/screens/auth/register.dart';
import 'package:shopmart_users/widgets/app_name_text.dart';
import 'package:shopmart_users/widgets/subtitle_text.dart';
import 'package:shopmart_users/widgets/title_text.dart';
import '../../widgets/auth/google_btn.dart';
import '../../widgets/root_screen.dart';
import 'forgot_password.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/LoginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool obscureText = true;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if(mounted) {
      _emailController.dispose();
      _passwordController.dispose();

      _emailFocusNode.dispose();
      _passwordFocusNode.dispose();
      super.dispose();
    }
  }

  Future<void> _loginFct() async{
    final isValid = _formKey.currentState!.validate(); //validate function stored in bool "isValid"
    FocusScope.of(context).unfocus(); //Touch anywhere in the screen to hide keyboard
    if(isValid) {
      Navigator.pushNamed(context, RootScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();   //touch anywhere in the screen to hide keyboard after typing . Wrap the entire scaffold with the GestureDetector
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 60.0),
                  AppNameTextWidget(fontSize: 30),

                  const SizedBox(height: 16.0),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: TitlesTextWidget(label: "Welcome Back!")),

                 const SizedBox(height: 16.0),

                  Form(
                    key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: _emailController,
                            focusNode: _emailFocusNode,//not required, only using for next field i.e., password
                            textInputAction: TextInputAction.next,//next arrow in keyboard for submission of email
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: "Email Address",
                              prefixIcon: Icon(IconlyLight.message)
                            ),
                            onFieldSubmitted: (value){
                              FocusScope.of(context).requestFocus(_passwordFocusNode);//After filling email, click on tick in keyboard so that it will get submitted. after that cursor will goto password field.
                            },
                            validator: (value) {
                              return MyValidators.emailValidator(value);
                            }
                          ),

                          SizedBox(height: 20),

                          TextFormField(
                            obscureText: obscureText,
                            controller: _passwordController,
                            focusNode: _passwordFocusNode,//not required, only using for jumping to next field after submission of previous value.
                            textInputAction: TextInputAction.done,//tick in keyboard for submission of password
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                hintText: "**************",
                                prefixIcon: Icon(IconlyLight.lock),
                              suffixIcon:  IconButton(onPressed: (){
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                                icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
                              )
                            ),
                            onFieldSubmitted: (value) async{
                             await _loginFct();
                            },
                              validator: (value) {
                                return MyValidators.passwordValidator(value);
                              }
                          ),
                          const SizedBox(height: 16.0),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(onPressed: (){
                              Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
                            },
                                child: SubtitleTextWidget(label: "Forgot Password ? ",
                                fontStyle: FontStyle.italic,
                                  textDecoration: TextDecoration.underline,
                                  fontSize: 15,
                                  color: Colors.deepPurple,
                                ),
                            ),
                          ),

                          const SizedBox(height: 16.0),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () async{
                                await _loginFct();
                              },
                              icon: const Icon(Icons.login),
                              label: const Text("Login"),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  //backgroundColor: Colors.blue,
                                padding: const EdgeInsets.all(12.0)
                              ),
                            ),
                          ),

                          const SizedBox(height: 16.0),

                          SubtitleTextWidget(label: "Or connecting using" .toUpperCase(),
                          fontSize: 15,color: Colors.deepPurple),

                          const SizedBox(height: 16.0),

                          SizedBox(
                            height: kBottomNavigationBarHeight + 10,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                    child: SizedBox(height: kBottomNavigationBarHeight,
                                        child: FittedBox(
                                            child: GoogleBotton(),
                                        ),
                                    ),
                                ),

                                SizedBox(width: 8.0),


                                Expanded(
                                  child: SizedBox(
                                    height: kBottomNavigationBarHeight,
                                    child: ElevatedButton(
                                      onPressed: () async{
                                        Navigator.pushNamed(context, RootScreen.routeName);
                                      },
                                      child: const Text("Guest ?"),
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          //backgroundColor: Colors.blue,
                                          padding: EdgeInsets.all(12.0)
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16.0),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SubtitleTextWidget(label: "New here ?",
                              color: Colors.deepPurple,
                              fontSize: 15),

                              TextButton(onPressed: (){
                                Navigator.of(context).pushNamed(RegisterScreen.routeName);
                              },
                                child: SubtitleTextWidget(label: "Sign up ",
                                  color: Colors.deepPurple,
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic,
                                  textDecoration: TextDecoration.underline,
                                ),
                              ),

                            ],
                          )
                        ],
                      )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
