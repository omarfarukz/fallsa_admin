import 'package:fallsa_admin/pages/authentication/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/style.dart';
import '../../widgets/custom_text.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({Key key}) : super(key: key);
  final _firebseauth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  resetPassword(String email) async {
    try {
      await _firebseauth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text("Forget Password",
                      style: GoogleFonts.roboto(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  CustomText(
                    text: "Please provide your vaild email",
                    color: lightGrey,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "name@email.com",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () async {
                  // Get.offAllNamed(rootRoute);//new commend
                  // Get.offAll(() => SiteLayout());
                  try {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(
                            email: emailController.text.trim())
                        .then((value) => {
                              print("Password reset email sent"),
                              Get.offAll(AuthenticationPage()),
                            })
                        .catchError((error) => {print(error)});
                    print("Success");
                    // Get.offAll(AuthenticationPage());
                  } catch (e) {
                    print(e);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: active, borderRadius: BorderRadius.circular(20)),
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: const CustomText(
                    text: "Reset Password",
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
