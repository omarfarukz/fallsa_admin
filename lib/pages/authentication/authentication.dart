import 'package:fallsa_admin/constants/style.dart';
import 'package:fallsa_admin/controllers/authController.dart';
import 'package:fallsa_admin/pages/authentication/reset_password.dart';
import 'package:fallsa_admin/pages/authentication/signup.dart';
import 'package:fallsa_admin/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/link.dart';

class AuthenticationPage extends GetWidget<AuthController> {
  // const AuthenticationPage({Key key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Image.asset("assets/icons/logo.png"),
                  ),
                  Expanded(child: Container()),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text("Login",
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
                    text: "Welcome back to the admin panel.",
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
                    hintText: "abc@domain.com",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "123",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(value: true, onChanged: (value) {}),
                      const CustomText(
                        text: "Remeber Me",
                      ),
                    ],
                  ),
                  Link(
                    uri: Uri.parse("https://forgetfallsa.wasap.my"),
                    target: LinkTarget.blank,
                    builder: (context, followLink) => ElevatedButton(
                      onPressed: () {
                        Get.offAll(ResetPasswordScreen());
                      },
                      child: const Text('Forget Password'),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  controller.login(
                      emailController.text, passwordController.text);
                  // Get.offAllNamed(rootRoute);//new commend
                  // Get.offAll(() => SiteLayout());
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: active, borderRadius: BorderRadius.circular(20)),
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: const CustomText(
                    text: "Login",
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Link(
                  uri: Uri.parse("https://signupfallsa.wasap.my"),
                  target: LinkTarget.blank,
                  builder: (context, followLink) => ElevatedButton(
                      onPressed: () {
                        Get.offAll(SignUpScreen());
                      },
                      child: const Text('Sign Up as Admin'))),
              SizedBox(
                height: 30,
              ),
              const Text(
                  "©️ALL RIGHTS RESERVED UNIVERSITI KEBANGSAAN MALAYSIA 2022",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
