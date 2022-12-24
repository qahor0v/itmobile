// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:itmobile/pages/intro/sign_up.dart';

import '../../main.dart';

class SignIn extends StatefulWidget {
  static const String id = 'signup';

  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final myBox = Hive.box('listBox');
  final PageController controller = PageController();
  TextEditingController email0 = TextEditingController();
  TextEditingController password0 = TextEditingController();

  bool isShow = false;

  @override
  void dispose() {
    email0.dispose();
    password0.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future signIn() async {
    String emailIn = email0.text.toString().trim();
    String passwordIn = password0.text.toString().trim();
    if (emailIn.length < 4 && passwordIn.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Xatolik! Email va parol to'ldirilmadi!"),
      ));
    } else if (passwordIn.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Parol kamida 6 ta belgidan iborat bo'lishi kerak!"),
      ));
    } else if (emailIn.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Email-ni to'g'ri kiriting!"),
      ));
    }
  }

  Future sign() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email0.text.trim(),
        password: password0.text.trim(),
      );
      myBox.put("email", email0.text.trim());
    } on FirebaseAuthException catch (e) {
      log("$e");
    }
    navKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            spreadRadius: 3,
            blurRadius: 7,
            blurStyle: BlurStyle.normal,
          )
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.indigo,
            Colors.blue.shade400,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              const Text(
                "KIRISH",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 35,
                  right: 35,
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: email0,
                      decoration: const InputDecoration(
                        hintText: "EMAIL",
                        // icon: Icon(Icons.email),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.white54,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                    TextFormField(
                      obscureText: isShow,
                      controller: password0,
                      decoration: InputDecoration(
                        hintText: "PAROL",
                        // icon: Icon(Icons.email),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isShow = !isShow;
                            });
                          },
                          icon: Icon(
                            isShow ? Icons.visibility : Icons.visibility_off,
                            color: Colors.white,
                          ),
                        ),
                        hintStyle: const TextStyle(
                          color: Colors.white54,
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    sign();
                    signIn();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                    ),
                  ),
                  child: const Text(
                    "KIRISH",
                    style: TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Akkauntingiz yo'qmi? ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SignUp(),
                        ),
                      );
                    },
                    child: const Text(
                      "Ro'yxatdan o'tish",
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
