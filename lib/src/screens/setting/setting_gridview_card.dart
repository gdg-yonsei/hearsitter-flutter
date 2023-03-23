import 'package:flutter/material.dart';

class SettingGridViewCard extends StatelessWidget {
  final String? imgUrl;
  final String? audioLabel;
  final VoidCallback? onTap;
  final bool? isSelected;

  const SettingGridViewCard(
      {Key? key,
      required this.audioLabel,
      required this.imgUrl,
      required this.onTap,
      required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Center(
          child: Container(

          ),
        ),
      ),
    );
  }
}
