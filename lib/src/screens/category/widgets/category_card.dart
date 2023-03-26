import 'package:flutter/material.dart';
import 'package:see_our_sounds/src/core/app_constants.dart';

class CategoryCard extends StatelessWidget {
  final String imgUrl;
  final Color color;
  final double width;
  final String audioLabel;
  final VoidCallback onTap;
  final Color labelColor;
  final bool isSelected;

  const CategoryCard(
      {Key? key,
      required this.audioLabel,
      required this.imgUrl,
      required this.onTap,
      required this.isSelected,
      this.color = Colors.white,
      this.labelColor = Colors.black,
      this.width = 85})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: 80,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: color,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade100, blurRadius: 3, spreadRadius: 1)
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 25,
              width: 25,
              child: Image.asset(
                imgUrl,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              audioLabel,
              style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w500, color: labelColor),
            )
          ],
        ),
      ),
    );
  }
}
