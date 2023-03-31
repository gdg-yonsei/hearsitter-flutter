import 'package:flutter/material.dart';

Widget appBarIconButton({required VoidCallback onTap, required Widget icon}) {
  return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 43,
        height: 43,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade200, blurRadius: 1, spreadRadius: 1)
            ]),
        child: icon,
      ));
}
