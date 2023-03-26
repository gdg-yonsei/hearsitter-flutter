import 'package:flutter/material.dart';
import 'package:see_our_sounds/src/core/app_constants.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  "Hi, I'm a HearSitter,\n"
                  "your deaf assistant.",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.only(top: 5, bottom: 35),
                margin: const EdgeInsets.only(right: 40),
                child: const Text(
                    "To help you better, I would like to get to know your name.",
                    style: TextStyle(fontSize: 13, color: AppColor.grayColor)),
              ),
              const Text("What's your name?",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 10,
              ),
              TextField(
                style: const TextStyle(
                    fontSize: 20,
                    decoration: TextDecoration.none,
                    decorationThickness: 0),
                cursorColor: Colors.black,
                controller: textEditingController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Your name',
                  hintStyle: TextStyle(color: AppColor.grayColor, fontSize: 20),
                  border: InputBorder.none,
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 55,
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade100, blurRadius: 2, spreadRadius: 1)
            ]),
        child: const Center(
          child: Text(
            'Next',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
