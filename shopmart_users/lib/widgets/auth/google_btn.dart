import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class GoogleBotton extends StatelessWidget {
  const GoogleBotton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async{

      },
      icon: const Icon(Ionicons.logo_google,color: Colors.red),
      label: const Text("Sign in with Google",
      style: TextStyle(
        color: Colors.black
      ),),
      style: ElevatedButton.styleFrom(
        elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(12.0)
      ),
    );
  }
}
