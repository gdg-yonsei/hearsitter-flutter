import 'package:flutter/material.dart';
import 'package:hear_sitter/src/core/app_constants.dart';

class ToggleButton extends StatefulWidget {
  final VoidCallback onTap;
  final bool isRecording;

  const ToggleButton({Key? key, required this.onTap, required this.isRecording})
      : super(key: key);

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  final animationDuration = const Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        height: 37,
        width: 67,
        duration: animationDuration,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color:
                widget.isRecording ? AppColor.primaryColor : Colors.grey[350],
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade200, blurRadius: 2, spreadRadius: 1)
            ]),
        child: AnimatedAlign(
          duration: animationDuration,
          alignment:
              widget.isRecording ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
