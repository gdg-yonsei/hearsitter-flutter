import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:see_our_sounds/src/core/app_constants.dart';
import 'package:see_our_sounds/src/screens/category/category_card.dart';

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
                          audioLabel:
                              soundCategoryToLabel(SoundCategory.BABY_CRYING),
                          imgUrl:
                              soundCategoryIconLight(SoundCategory.BABY_CRYING),
                          width: 120,
                          onTap: () {},
                          isSelected: false),
                      CategoryCard(
                          audioLabel: 'Crack Sound',
                          width: 130,
                          imgUrl:
                              soundCategoryIconDark(SoundCategory.CRACK_SOUND),
                          onTap: () {},
                          isSelected: false),
                      CategoryCard(
                          audioLabel:
                              soundCategoryToLabel(SoundCategory.FIRE_ALARM),
                          imgUrl:
                              soundCategoryIconDark(SoundCategory.FIRE_ALARM),
                          width: 110,
                          onTap: () {},
                          isSelected: false),
                      CategoryCard(
                          audioLabel:
                              soundCategoryToLabel(SoundCategory.GUN_SHOT),
                          imgUrl: soundCategoryIconDark(SoundCategory.GUN_SHOT),
                          onTap: () {},
                          width: 95,
                          isSelected: false),
                      CategoryCard(
                          audioLabel:
                              soundCategoryToLabel(SoundCategory.CAR_HORN),
                          imgUrl: soundCategoryIconDark(SoundCategory.CAR_HORN),
                          width: 100,
                          onTap: () {},
                          isSelected: false),
                      CategoryCard(
                          audioLabel: soundCategoryToLabel(SoundCategory.NAME),
                          imgUrl: soundCategoryIconDark(SoundCategory.NAME),
                          onTap: () {},
                          isSelected: false),
                      CategoryCard(
                          audioLabel: soundCategoryToLabel(SoundCategory.MAMA),
                          imgUrl: soundCategoryIconDark(SoundCategory.MAMA),
                          onTap: () {},
                          isSelected: false),
                      CategoryCard(
                          audioLabel: soundCategoryToLabel(SoundCategory.PAPA),
                          imgUrl: soundCategoryIconDark(SoundCategory.PAPA),
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
            'Done',
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
