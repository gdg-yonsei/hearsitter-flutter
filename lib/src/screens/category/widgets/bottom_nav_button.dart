import 'package:flutter/material.dart';
import 'package:see_our_sounds/src/core/app_constants.dart';

Widget bottomNavButton(
    {required VoidCallback onTap,
    required bool validate,
    required String text}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      height: 55,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      decoration: BoxDecoration(
          color: validate ? AppColor.primaryColor : AppColor.lightGrayColor,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade100, blurRadius: 2, spreadRadius: 1)
          ]),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
