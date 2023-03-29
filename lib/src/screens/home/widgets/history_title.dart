import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hear_sitter/src/core/app_constants.dart';
import 'package:hear_sitter/src/core/utils/router_util.dart';

class HistoryTitle extends StatelessWidget {
  const HistoryTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Recent History',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          textAlign: TextAlign.start,
        ),
        TextButton(
            onPressed: () {
              context.push(APP_SCREEN.history.routePath);
            },
            child: const Text(
              'See All',
              style: TextStyle(
                  color: AppColor.primaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            ))
      ],
    );
  }
}
