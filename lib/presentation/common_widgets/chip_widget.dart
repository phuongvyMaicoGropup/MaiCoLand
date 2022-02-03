import 'package:flutter/material.dart'; 

class ChipWidget extends StatelessWidget {
  const ChipWidget({required this.color,required this.content, Key? key }) : super(key: key);
  final String content; 
  final Color color ; 
  @override
  Widget build(BuildContext context) {
    return Chip(
  backgroundColor: color,
  label:  Text(content),
  labelStyle: TextStyle (color : Colors.white),
  onDeleted : (){
    
  }
);
  }
}
