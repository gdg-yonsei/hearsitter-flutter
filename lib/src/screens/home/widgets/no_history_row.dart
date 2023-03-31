import 'package:flutter/material.dart';
import 'package:hear_sitter/src/core/app_constants.dart';

Widget noHistoryRow() {
  return Row(
    children: [
      iconBox(
          const Icon(
            Icons.description_rounded,
            color: AppColor.grayColor,
            size: 30,
          ),
          AppColor.lightGrayColor),
      const SizedBox(
        width: 10,
      ),
      const Text(
        'There is no history yet.',
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColor.grayColor),
      ),
    ],
  );
}

Widget iconBox(Widget icon, Color boxColor) {
  return Container(
    width: 50,
    height: 50,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      color: boxColor,
    ),
    child: icon,
  );
}
