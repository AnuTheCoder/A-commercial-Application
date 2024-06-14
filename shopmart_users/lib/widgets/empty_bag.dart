import 'package:flutter/material.dart';
import 'package:shopmart_users/widgets/subtitle_text.dart';
import 'package:shopmart_users/widgets/title_text.dart';

class EmptyBagWidget extends StatelessWidget {
  const EmptyBagWidget({super.key, required this.imagePath, required this.title, required this.subtitle, required this.buttonText});

  final String imagePath,title,subtitle,buttonText;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;//access screen size
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SizedBox(height: 20,),
          Image.asset(imagePath,
            width: double.infinity,
            height: size.height *0.35,
          ),
          const SizedBox(height: 10,),
          const TitlesTextWidget(label: "Whoops",fontSize: 40,
            color: Colors.blue,),
          const SizedBox(height: 10,),
          SubtitleTextWidget(label: title,fontWeight: FontWeight.w600,),
          const SizedBox(height: 10,),
          SubtitleTextWidget(label: subtitle,
            fontWeight: FontWeight.w400,),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: (){},
            child: Text(buttonText),
            style: ElevatedButton.styleFrom(elevation: 0,
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10)
            ),

          )
        ],
      ),
    );
  }
}
