<br>

<p align="center">
<img src="https://user-images.githubusercontent.com/88659167/229131308-d658434a-cc34-46d0-a3da-4f2cb86272d0.png" width="170px" alt="HearSitter Logo" />
</p>

<h1 align="center">HearSitter</h1>

<br>

## 📱 Screens


|Preview                    |   Home screen             |   History Screen           |  Decibel Scale Screen    |
|:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:|
<img src="https://user-images.githubusercontent.com/88659167/229133364-a701ac23-aea2-409a-9da2-9779c75bbaf2.gif" width='95%'>|<img src="https://user-images.githubusercontent.com/88659167/229136140-da524ef0-1077-4825-bdfd-f0a708de4377.jpg">|<img src="https://user-images.githubusercontent.com/88659167/229135997-da398cfa-0041-447e-b955-cff420323fb6.jpg" width='95%'>|<img src="https://user-images.githubusercontent.com/88659167/229136318-85a5a405-0f1f-41f0-807e-f24a1e4014a3.jpg" width='95%'>

## 👀 MVVM Architecture with Riverpod
<img width="400" alt="hearsitter_architecture" src="https://user-images.githubusercontent.com/88659167/229158615-872c683c-ba14-4f10-8a39-f367b055ca7b.png">

## 📂 Dircectory Structure

```
📂lib
├─ main.dart
└─ 📂src
   ├─ 📂core
   │  ├─ app_assets.dart
   │  ├─ app_constants.dart
   │  ├─ app_router.dart
   │  ├─ app_theme.dart
   │  ├─ core.dart
   │  └─📂utils
   │     ├─ audio_util.dart
   │     ├─ database_util.dart
   │     ├─ local_noti_util.dart
   │     ├─ router_util.dart
   │     └─ sharedprefs_util.dart
   ├─ 📂models
   │  ├─ audio_tagging_model.dart
   │  ├─ audio_tagging_model.freezed.dart
   │  └─ audio_tagging_model.g.dart
   ├─ 📂providers
   │  ├─ audio_tagging_api_provider.dart
   │  ├─ audio_tagging_db_provider.dart
   │  ├─ decibel_provider.dart
   │  ├─ stt_provider.dart
   │  └─ test.dart
   ├─ 📂repositories
   │  └─ audio_tagging_repository.dart
   ├─ 📂screens
   │  ├─ 📂category
   │  │  ├─ category_screen.dart
   │  │  └─ 📂widgets
   │  │     ├─ bottom_nav_button.dart
   │  │     └─ category_card.dart
   │  ├─ 📂history
   │  │  └─ history_screen.dart
   │  ├─ 📂home
   │  │  ├─ home_screen.dart
   │  │  └─ 📂widgets
   │  │     ├─ appbar_icon_button.dart
   │  │     ├─ decibel_history_chart.dart
   │  │     ├─ decibel_history_gauge.dart
   │  │     ├─ decibel_scale_chart.dart
   │  │     ├─ history_row.dart
   │  │     ├─ history_title.dart
   │  │     ├─ no_history_row.dart
   │  │     └─ toggle_button.dart
   │  └─ 📂onboarding
   │     └─ onboarding_screen.dart
   └─ 📂services
      └─ audio_tagging_service.dart

```
## 🔎 Features

- [x] State management with Riverpod
- [X] Real-time Audio Stream
- [X] Show decibel line chart and measure decibel with your phone
- [x] Show decibel scale information
- [x] Show notifications on app when sound detected 
- [X] Automatically save detection history in the history screen 
- [X] Send some feedback to the hearsitter team through email
- [ ] Delete detection history

## 🚀 Getting Started
 [Click to download a releaed apk](https://drive.google.com/file/d/1ibGN9mNB-Y1cREDqv4Jab1on9llKtyH_/view?usp=share_link). To install this, you need to able downloading an app from unknown sources.

### Requirements
`Dart >= 2.18.0` & `Flutter >= 2.0.0`
