import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fourth_pillar/app_constants.dart';
import 'package:fourth_pillar/engine/firebase_handlers/firebase_auth_controller.dart';
import 'package:fourth_pillar/firebase_options.dart';
import 'package:fourth_pillar/visuals/screens/authentication/login/login_screen.dart';
import 'package:fourth_pillar/visuals/screens/authentication/signup/signup_screen.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then(($) =>
          Get.lazyPut<FirebaseAuthController>(() => FirebaseAuthController()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fourth Pillar',
      theme:
          ThemeData.dark().copyWith(scaffoldBackgroundColor: backgroundColor),
      home: LoginScreen(),
    );
  }
}
