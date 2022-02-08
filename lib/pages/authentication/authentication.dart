import 'package:fallsa_admin/constants/style.dart';
import 'package:fallsa_admin/controllers/authController.dart';
import 'package:fallsa_admin/layout.dart';
import 'package:fallsa_admin/routing/routes.dart';
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
          constraints: BoxConstraints(maxWidth: 400),
          padding: EdgeInsets.all(24),
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
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text("Login",
                      style: GoogleFonts.roboto(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(
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
              SizedBox(
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
              SizedBox(
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
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(value: true, onChanged: (value) {}),
                      CustomText(
                        text: "Remeber Me",
                      ),
                    ],
                  ),
                  Link(
                      uri: Uri.parse("https://forgetfallsa.wasap.my"),
                      target: LinkTarget.blank,
                      builder: (context, followLink) => ElevatedButton(
                          onPressed: followLink,
                          child: Text('Forget Password'))),
                ],
              ),
              SizedBox(
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
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: CustomText(
                    text: "Login",
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              // RichText(
              //     text: TextSpan(children: [
              //   TextSpan(text: "Do not have admin credentials? "),
              //   TextSpan(
              //       text: "Request Credentials! ",
              //       style: TextStyle(color: active))
              // ])),
              Link(
                  uri: Uri.parse("https://signupfallsa.wasap.my"),
                  target: LinkTarget.blank,
                  builder: (context, followLink) => ElevatedButton(
                      onPressed: followLink,
                      child: Text('Request for Admin crediential'))),
            ],
          ),
        ),
      ),
    );
  }
}
