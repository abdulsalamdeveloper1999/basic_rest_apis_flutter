import 'dart:developer';
import 'package:http/http.dart';
import 'package:flutter/material.dart';

class SignInApi extends StatefulWidget {
  const SignInApi({super.key});

  @override
  State<SignInApi> createState() => _SignInApiState();
}

class _SignInApiState extends State<SignInApi> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  void login(String email, String password) async {
    try {
      Response response = await post(
        Uri.parse('https://reqres.in/api/login'),
        body: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        log('User Login successull');
      } else {
        log('User Login unsuccessull');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('SIGN IN'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Enail',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passController,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              height: 50,
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {
                  login(
                    emailController.text,
                    passController.text,
                  );
                },
                child: const Text('Sign In'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
