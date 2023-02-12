import 'package:flutter/material.dart';
import 'package:fourth_pillar/app_constants.dart';
import 'package:fourth_pillar/visuals/parts/text_input_field.dart';
import 'package:fourth_pillar/visuals/screens/authentication/login/login_screen.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Fourth Pillar',
                style: TextStyle(
                    color: secondaryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Signup',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 64.0,
                    backgroundColor: Colors.black26,
                    backgroundImage: NetworkImage(
                        'https://cdn-icons-png.flaticon.com/512/4105/4105451.png'),
                  ),
                  Positioned(
                      bottom: -15,
                      left: 90,
                      child: IconButton(
                          icon: const Icon(Icons.add_a_photo),
                          onPressed: () {
                            firebaseAuthController.pickImage();
                          }))
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                    textEditingController: _usernameController,
                    label: "Your name",
                    icon: Icons.person),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  textEditingController: _emailController,
                  label: "Email",
                  icon: Icons.email,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  textEditingController: _passwordController,
                  label: "Password",
                  icon: Icons.lock,
                  hideText: true,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  firebaseAuthController.registerUser(_usernameController.text,
                      _emailController.text, _passwordController.text,
                      image: firebaseAuthController.getProfilePic ?? null);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: const Text(
                    'Signup',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.offAll(() => LoginScreen());
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 20, color: secondaryColor),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
