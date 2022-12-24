// ignore_for_file: depend_on_referenced_packages
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:itmobile/pages/intro/sign_up.dart';

class MyNamePage extends StatefulWidget {
  static const String id = 'signup';

  const MyNamePage({Key? key}) : super(key: key);

  @override
  State<MyNamePage> createState() => _MyNamePageState();
}

class _MyNamePageState extends State<MyNamePage> {
  TextEditingController name = TextEditingController();
  TextEditingController soha = TextEditingController();

  final myBox = Hive.box('listBox');

  void next() {
    String _name = name.text;
    String _soha = soha.text;
    if (_name.length > 3 && _soha.isNotEmpty) {
      myBox.put("name", _name);
      myBox.put("soha", _soha).then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const SignUp(),
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Xatolik! Ismingiz va sohangizni to'g'ri kiriting!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Lottie.asset(
              "assets/jsons/sticman.json",
              height: MediaQuery.of(context).size.height * 0.35,
            ),
            const Text(
              "IT Mobile",
              style: TextStyle(
                color: Colors.white,
                fontSize: 45,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.08,
              margin: const EdgeInsets.only(
                left: 36,
                right: 36,
                top: 12,
                bottom: 12,
              ),
              padding: const EdgeInsets.only(
                left: 12,
                right: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: TextField(
                  controller: name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Ismingizni kiriting",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.08,
              margin: const EdgeInsets.only(
                left: 36,
                right: 36,
                top: 12,
              ),
              padding: const EdgeInsets.only(
                left: 12,
                right: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: TextField(
                  controller: soha,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Sohangizni kiriting",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
              child: ElevatedButton(
                onPressed: () {
                  next();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                  ),
                ),
                child: const Text(
                  "DAVOM ETISH",
                  style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashToSignUp extends StatefulWidget {
  const DashToSignUp({Key? key}) : super(key: key);

  @override
  State<DashToSignUp> createState() => _DashToSignUpState();
}

class _DashToSignUpState extends State<DashToSignUp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Navigator.pushReplacementNamed(context, SignUp.id);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
