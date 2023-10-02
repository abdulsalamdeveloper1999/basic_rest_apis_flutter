import 'dart:developer';
import 'package:http/http.dart';
import 'package:flutter/material.dart';

class SignUpApi extends StatefulWidget {
  const SignUpApi({super.key});

  @override
  State<SignUpApi> createState() => _SignUpApiState();
}

class _SignUpApiState extends State<SignUpApi> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  void signUp(String email, String password) async {
    try {
      Response response = await post(
        Uri.parse(
          'https://reqres.in/api/register',
        ),
        body: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        log('User created successully');
      } else {
        log('User creation fail');
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
        title: const Text('SIGN UP'),
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
                  signUp(
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
