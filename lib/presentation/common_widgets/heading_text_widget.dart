

import 'package:flutter/material.dart';
import 'package:land_app/presentation/resources/resources.dart';

class HeadingTextWidget extends StatelessWidget {
  const HeadingTextWidget({required this.text, Key? key }) : super(key: key);
  final String text; 
  @override
  Widget build(BuildContext context) {
     return Container(
       padding: EdgeInsets.all(7),
                decoration:const BoxDecoration(
                  border: Border(
                    left: BorderSide( //                   <--- left side
        color: AppColors.appGreen1,
        width: 3.0,
      ),)
                ),
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat",
                    fontSize: 18,
                    
                  ),
                
                          ),
              );
             
  }
}