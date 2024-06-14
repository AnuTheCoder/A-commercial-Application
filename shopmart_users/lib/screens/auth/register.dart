import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopmart_users/consts/validator.dart';
import 'package:shopmart_users/services/my_app_functions.dart';
import 'package:shopmart_users/widgets/app_name_text.dart';
import 'package:shopmart_users/widgets/auth/image_picker_widget.dart';
import 'package:shopmart_users/widgets/subtitle_text.dart';
import 'package:shopmart_users/widgets/title_text.dart';
import '../../widgets/root_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = "/RegisterScreen";
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  bool obscureText = true;
  late TextEditingController _nameController, _emailController, _passwordController, _repeaPasswordController;
  late final FocusNode _nameFocusNode, _emailFocusNode, _passwordFocusNode, _repeatPasswordFocusNode;

  final _formKey = GlobalKey<FormState>();
  XFile? _pickedImage;

  @override
  void initState() {
    // TODO: implement initState
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _repeaPasswordController = TextEditingController();

    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _repeatPasswordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if(mounted) {
      _nameController.dispose();
      _emailController.dispose();
      _passwordController.dispose();
      _repeaPasswordController.dispose();

      _nameFocusNode.dispose();
      _emailFocusNode.dispose();
      _passwordFocusNode.dispose();
      _repeatPasswordFocusNode.dispose();
      super.dispose();
    }
  }

  Future<void> _registerFct() async{
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(isValid) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => RootScreen()));
    }
  }

  Future<void> localImagePicker() async{
    final ImagePicker imagePicker = ImagePicker(); //Initialize ImagePicker library
    await MyAppFunctions.imagePickerDialog(
        context: context,
        cameraFCT: () async{
          _pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
          setState(() {

          });
        },
        galleryFCT: () async{
          _pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
          setState(() {

          });
        },
        removeFCT: (){
          setState(() {
            _pickedImage = null;
          });
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();   //touch anywhere in the screen to hide keyboard after typing . Wrap the entire scaffold with the GestureDetector
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [

                 // BackButton(),

                  const SizedBox(height: 60.0),

                  AppNameTextWidget(fontSize: 30),

                  const SizedBox(height: 25.0),
                 const Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitlesTextWidget(label: "Welcome Back!",fontSize: 25),
                          SubtitleTextWidget(label: "Your welcome message",
                          color: Colors.white,
                          fontSize: 15,
                          )
                        ],
                      )),

                  const SizedBox(height: 22.0),

                  SizedBox(
                      height: size.width * 0.3,
                      width: size.width * 0.3,
                      child: PickImageWidget(
                        pickedImage: _pickedImage,
                        function: () async{
                          await localImagePicker();
                        },
                      ),
                  ),

                  const SizedBox(height: 22.0),

                  Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          TextFormField(
                              controller: _nameController,
                              focusNode: _nameFocusNode,//not required, only using for next field i.e., password
                              textInputAction: TextInputAction.next,//next arrow in keyboard for submission of email
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  hintText: "Full Name",
                                  prefixIcon: Icon(Icons.person)
                              ),
                              onFieldSubmitted: (value){
                                FocusScope.of(context).requestFocus(_emailFocusNode);//After filling email, click on tick in keyboard so that it will get submitted. after that cursor will goto password field.
                              },
                              validator: (value) {
                                return MyValidators.displayNamevalidator(value);
                              }
                          ),

                          const SizedBox(height: 16),


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
                              textInputAction: TextInputAction.next,//tick in keyboard for submission of password
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                  hintText: "**************",
                                  prefixIcon: Icon(IconlyLight.lock),
                                suffixIcon: IconButton(onPressed: (){
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                },
                                  icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
                                ),
                              ),
                              onFieldSubmitted: (value) async{
                                FocusScope.of(context).requestFocus(_repeatPasswordFocusNode);
                              },
                              validator: (value) {
                                return MyValidators.passwordValidator(value);
                              }
                          ),

                          const SizedBox(height: 16.0),

                          TextFormField(
                              obscureText: obscureText,
                              controller: _repeaPasswordController,
                              focusNode: _repeatPasswordFocusNode,//not required, only using for jumping to next field after submission of previous value.
                              textInputAction: TextInputAction.done,//tick in keyboard for submission of password
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                  hintText: "Repeat Password",
                                  prefixIcon: Icon(IconlyLight.lock),
                                suffixIcon: IconButton(onPressed: (){
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                },
                                  icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
                                )
                              ),
                              onFieldSubmitted: (value) async{
                                await _registerFct();
                              },
                              validator: (value) {
                                return MyValidators.repeatPasswordValidator(value: value,password: _passwordController.text);
                              }
                          ),

                          const SizedBox(height: 50.0),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () async{
                                await _registerFct();
                              },
                              icon: const Icon(IconlyLight.addUser),
                              label: const Text("Sign Up"),
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
                              ],
                            ),
                          ),

                          const SizedBox(height: 16.0),
                        ],
                      )
                  ),
              ),
            ),
          ),
    );
  }
}
