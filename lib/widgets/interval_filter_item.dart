import 'package:flutter/material.dart';

class IntervalFilterItem extends StatelessWidget {
  const IntervalFilterItem({Key? key, required this.title,  this.isSelected = false}) : super(key: key);

  final String title;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
            color: isSelected?Colors.white:Colors.transparent,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(4)
        ),
        child:  Text(title,style: TextStyle(color: isSelected?Colors.black:Colors.white),));
  }
}
