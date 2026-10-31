import 'package:flutter/material.dart';
import 'package:onthi_01/screens/home_screen.dart';
import '../database/database_helper.dart';
import '../models/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final txtUsername =
      TextEditingController();

  final txtPassword =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Đăng nhập",
        ),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller: txtUsername,

              decoration:
                  const InputDecoration(
                labelText: "Username",
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            TextField(
              controller: txtPassword,

              obscureText: true,

              decoration:
                  const InputDecoration(
                labelText: "Password",
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: login,

                child: const Text(
                  "Đăng nhập",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> login() async {

    User? user =
        await DatabaseHelper.instance
            .login(
      txtUsername.text.trim(),
      txtPassword.text.trim(),
    );

    if (user != null) {

      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            "Xin chào ${user.fullname}",
          ),
        ),
      );
      

    } else {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Sai tài khoản hoặc mật khẩu",
          ),
        ),
      );
    }
  }
}