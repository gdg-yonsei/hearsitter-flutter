import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hear_sitter/src/core/utils/router_util.dart';
import 'package:hear_sitter/src/core/utils/sharedprefs_util.dart';
import 'package:hear_sitter/src/core/app_constants.dart';
import 'package:hear_sitter/src/screens/category/widgets/bottom_nav_button.dart';

final validateNameProvider = StateProvider<bool>((ref) => false);

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  TextEditingController textEditingController = TextEditingController();
  final _prefs = SharedPreferencesUtil().prefs;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool validateName = ref.watch(validateNameProvider);
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
                onChanged: (val) {
                  ref.read(validateNameProvider.notifier).state =
                      textEditingController.text.trim().isEmpty ? false : true;
                },
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
      bottomNavigationBar: bottomNavButton(
          onTap: () {
            if (validateName){
              _prefs.setString('userName', textEditingController.text);
              _prefs.setBool('isOnboard', true);
              context.go(APP_SCREEN.category.routePath);
            }
          },
          validate: validateName,
          text: 'Next'),
    );
  }
}
