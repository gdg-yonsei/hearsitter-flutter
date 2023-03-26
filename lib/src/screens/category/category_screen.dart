import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hear_sitter/src/core/app_constants.dart';
import 'package:hear_sitter/src/screens/category/widgets/category_card.dart';
import 'package:hear_sitter/src/screens/category/widgets/bottom_nav_button.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
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
                'Tell me\nwhat you wanna hear',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5, bottom: 35),
                child: Text(
                  'So I can show you what you want to hear.',
                  style: TextStyle(fontSize: 13, color: AppColor.grayColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Align(
                  alignment: Alignment.center,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 19,
                    runSpacing: 13,
                    children: [
                      CategoryCard(
                          color: AppColor.primaryColor,
                          labelColor: Colors.white,
                          audioLabel: SoundCategory.BABY_CRYING.label,
                          imgUrl: SoundCategory.BABY_CRYING.iconLight,
                          width: 120,
                          onTap: () {},
                          isSelected: false),
                      CategoryCard(
                          audioLabel: 'Crack Sound',
                          width: 130,
                          imgUrl: SoundCategory.CRACK_SOUND.iconDark,
                          onTap: () {},
                          isSelected: false),
                      CategoryCard(
                          audioLabel: SoundCategory.FIRE_ALARM.label,
                          imgUrl: SoundCategory.FIRE_ALARM.iconDark,
                          width: 110,
                          onTap: () {},
                          isSelected: false),
                      CategoryCard(
                          audioLabel: SoundCategory.GUN_SHOT.label,
                          imgUrl: SoundCategory.GUN_SHOT.iconDark,
                          onTap: () {},
                          width: 95,
                          isSelected: false),
                      CategoryCard(
                          audioLabel: SoundCategory.CAR_HORN.label,
                          imgUrl: SoundCategory.CAR_HORN.iconDark,
                          width: 100,
                          onTap: () {},
                          isSelected: false),
                      CategoryCard(
                          audioLabel: SoundCategory.NAME.label,
                          imgUrl: SoundCategory.NAME.iconDark,
                          onTap: () {},
                          isSelected: false),
                      CategoryCard(
                          audioLabel: SoundCategory.MAMA.label,
                          imgUrl: SoundCategory.MAMA.iconDark,
                          onTap: () {},
                          isSelected: false),
                      CategoryCard(
                          audioLabel: SoundCategory.PAPA.label,
                          imgUrl: SoundCategory.PAPA.iconDark,
                          onTap: () {},
                          isSelected: false),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          bottomNavButton(onTap: () {}, validate: false, text: 'Done'),
    );
  }
}
