// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:itmobile/pages/intro/sign_in.dart';
import '../../main.dart';

class SignUp extends StatefulWidget {
  static const String id = 'signup';

  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final myBox = Hive.box('listBox');
  TextEditingController password = TextEditingController();
  TextEditingController password1 = TextEditingController();
  TextEditingController email = TextEditingController();
  bool isShow = true;

  signUp() {
    String emailIn1 = email.text.toString().trim();
    String password0 = password.text.toString().trim();
    String passwordIn = password1.text.toString().trim();

    if (passwordIn == password0) {
      if (emailIn1.length < 4 && passwordIn.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Xatolik! Email va parol to'ldirilmadi!"),
          ),
        );
      } else if (passwordIn.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Parol kamida 6 ta belgidan iborat bo'lishi kerak!"),
        ));
      } else if (emailIn1.length < 4) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Email-ni to'g'ri kiriting!"),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Xatolik! Parollar mos emas!",
          ),
        ),
      );
    }
  }

  Future _signUp() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      myBox.put("email", email.text.trim()).then((value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const Main(),
          ),
        );
      });
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
    navKey.currentState!.popUntil(
      (route) => route.isFirst,
    );
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    password1.dispose();
    // TODO: implement dispose
    super.dispose();
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
              blurStyle: BlurStyle.normal)
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
                "RO'YHATDAN O'TISH",
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
                padding: const EdgeInsets.only(left: 35, right: 35),
                child: Column(
                  children: [
                    TextFormField(
                      controller: email,
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
                      controller: password,
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
                    TextFormField(
                      obscureText: isShow,
                      controller: password1,
                      decoration: const InputDecoration(
                        hintText: "PAROLNI QAYTA KIRITING",
                        // icon: Icon(Icons.email),
                        prefixIcon: Icon(
                          Icons.lock,
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
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: ElevatedButton(
                  onPressed: () {
                    signUp();
                    _signUp();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                    ),
                  ),
                  child: const Text(
                    "RO'YHATDAN O'TISH",
                    style: TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Akkauntingiz bormi? ",
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
                          builder: (_) => const SignIn(),
                        ),
                      );
                    },
                    child: const Text(
                      "Kirish",
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
