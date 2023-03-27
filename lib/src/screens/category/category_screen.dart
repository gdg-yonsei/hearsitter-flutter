import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hear_sitter/src/core/app_constants.dart';
import 'package:hear_sitter/src/core/utils/router_util.dart';
import 'package:hear_sitter/src/core/utils/sharedprefs_util.dart';
import 'package:hear_sitter/src/screens/category/widgets/category_card.dart';
import 'package:hear_sitter/src/screens/category/widgets/bottom_nav_button.dart';

final _prefs = SharedPreferencesUtil().prefs;
final isSelectedInfantCryingProvider =
    StateProvider<bool>((ref) => _prefs.getBool('infantCrying') ?? false);
final isSelectedCrackSoundProvider =
    StateProvider<bool>((ref) => _prefs.getBool('crackSound') ?? false);
final isSelectedFireAlarmProvider =
    StateProvider<bool>((ref) => _prefs.getBool('fireAlarm') ?? false);
final isSelectedGunShotProvider =
    StateProvider<bool>((ref) => _prefs.getBool('gunShot') ?? false);
final isSelectedCarHornProvider =
    StateProvider<bool>((ref) => _prefs.getBool('carHorn') ?? false);
final isSelectedNameProvider =
    StateProvider<bool>((ref) => _prefs.getBool('name') ?? false);
final isSelectedMamaProvider =
    StateProvider<bool>((ref) => _prefs.getBool('mama') ?? false);
final isSelectedPapaProvider =
    StateProvider<bool>((ref) => _prefs.getBool('papa') ?? false);

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final isSelectedInfantCrying = ref.watch(isSelectedInfantCryingProvider);
    final isSelectedCrackSound = ref.watch(isSelectedCrackSoundProvider);
    final isSelectedFireAlarm = ref.watch(isSelectedFireAlarmProvider);
    final isSelectedGunShot = ref.watch(isSelectedGunShotProvider);
    final isSelectedCarHorn = ref.watch(isSelectedCarHornProvider);
    final isSelectedName = ref.watch(isSelectedNameProvider);
    final isSelectedMama = ref.watch(isSelectedMamaProvider);
    final isSelectedPapa = ref.watch(isSelectedPapaProvider);

    final validateSelected = isSelectedInfantCrying ||
        isSelectedCrackSound ||
        isSelectedFireAlarm ||
        isSelectedGunShot ||
        isSelectedCarHorn ||
        isSelectedName ||
        isSelectedMama ||
        isSelectedPapa;
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
                          audioLabel: SoundCategory.INFANT_CRYING.label,
                          imgUrl: isSelectedInfantCrying
                              ? SoundCategory.INFANT_CRYING.iconLight
                              : SoundCategory.INFANT_CRYING.iconDark,
                          width: 120,
                          onTap: () {
                            ref
                                .read(isSelectedInfantCryingProvider.notifier)
                                .state = isSelectedInfantCrying ? false : true;
                          },
                          isSelected: isSelectedInfantCrying),
                      CategoryCard(
                          audioLabel: 'Crack Sound',
                          width: 130,
                          imgUrl: isSelectedCrackSound
                              ? SoundCategory.CRACK_SOUND.iconLight
                              : SoundCategory.CRACK_SOUND.iconDark,
                          onTap: () {
                            ref
                                .read(isSelectedCrackSoundProvider.notifier)
                                .state = isSelectedCrackSound ? false : true;
                          },
                          isSelected: isSelectedCrackSound),
                      CategoryCard(
                          audioLabel: SoundCategory.FIRE_ALARM.label,
                          imgUrl: isSelectedFireAlarm
                              ? SoundCategory.FIRE_ALARM.iconLight
                              : SoundCategory.FIRE_ALARM.iconDark,
                          width: 110,
                          onTap: () {
                            ref
                                .read(isSelectedFireAlarmProvider.notifier)
                                .state = isSelectedFireAlarm ? false : true;
                          },
                          isSelected: isSelectedFireAlarm),
                      CategoryCard(
                          audioLabel: SoundCategory.GUN_SHOT.label,
                          imgUrl: isSelectedGunShot
                              ? SoundCategory.GUN_SHOT.iconLight
                              : SoundCategory.GUN_SHOT.iconDark,
                          onTap: () {
                            ref.read(isSelectedGunShotProvider.notifier).state =
                                isSelectedGunShot ? false : true;
                          },
                          width: 95,
                          isSelected: isSelectedGunShot),
                      CategoryCard(
                          audioLabel: SoundCategory.CAR_HORN.label,
                          imgUrl: isSelectedCarHorn
                              ? SoundCategory.CAR_HORN.iconLight
                              : SoundCategory.CAR_HORN.iconDark,
                          width: 100,
                          onTap: () {
                            ref.read(isSelectedCarHornProvider.notifier).state =
                                isSelectedCarHorn ? false : true;
                          },
                          isSelected: isSelectedCarHorn),
                      CategoryCard(
                          audioLabel: SoundCategory.NAME.label,
                          imgUrl: isSelectedName
                              ? SoundCategory.NAME.iconLight
                              : SoundCategory.NAME.iconDark,
                          onTap: () {
                            ref.read(isSelectedNameProvider.notifier).state =
                                isSelectedName ? false : true;
                          },
                          isSelected: isSelectedName),
                      CategoryCard(
                          audioLabel: SoundCategory.MAMA.label,
                          imgUrl: isSelectedMama
                              ? SoundCategory.MAMA.iconLight
                              : SoundCategory.MAMA.iconDark,
                          onTap: () {
                            ref.read(isSelectedMamaProvider.notifier).state =
                                isSelectedMama ? false : true;
                          },
                          isSelected: isSelectedMama),
                      CategoryCard(
                          audioLabel: SoundCategory.PAPA.label,
                          imgUrl: isSelectedPapa
                              ? SoundCategory.PAPA.iconLight
                              : SoundCategory.PAPA.iconDark,
                          onTap: () {
                            ref.read(isSelectedPapaProvider.notifier).state =
                                isSelectedPapa ? false : true;
                          },
                          isSelected: isSelectedPapa),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNavButton(
          onTap: () {
            if (validateSelected) {
              _prefs.setBool('infantCrying', isSelectedInfantCrying);
              _prefs.setBool('crackSound', isSelectedCrackSound);
              _prefs.setBool('fireAlarm', isSelectedFireAlarm);
              _prefs.setBool('gunShot', isSelectedGunShot);
              _prefs.setBool('carHorn', isSelectedCarHorn);
              _prefs.setBool('name', isSelectedName);
              _prefs.setBool('mama', isSelectedName);
              _prefs.setBool('papa', isSelectedPapa);

              context.go(APP_SCREEN.home.routePath);
            }
          },
          validate: validateSelected,
          text: 'Done'),
    );
  }
}
