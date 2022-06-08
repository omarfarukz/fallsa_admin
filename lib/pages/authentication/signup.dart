import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fallsa_admin/constants/style.dart';
import 'package:fallsa_admin/controllers/authController.dart';
import 'package:fallsa_admin/layout.dart';
import 'package:fallsa_admin/pages/authentication/authentication.dart';
import 'package:fallsa_admin/utils/root.dart';
import 'package:fallsa_admin/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends GetWidget<AuthController> {
  // SignUpScreen({Key key}) : super(key: key);
  User user = FirebaseAuth.instance.currentUser;
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  final bool isDoctor = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(
              children: [
                Text("Sign Up",
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
                  text: "Please fill out the form",
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
                  hintText: "Example:name@gmail.com",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "Example: Mr John",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                  labelText: "Phone Number",
                  hintText: "Example: 012345678",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Example: 123d4f4g (Minimun 8 Digit)",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            InkWell(
              onTap: () async {
                if (nameController.text.isNotEmpty &&
                    phoneController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty &&
                    emailController.text.isNotEmpty &&
                    passwordController.text.length >= 8) {
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text);
                    User user = FirebaseAuth.instance.currentUser;

                    if (user != null) {
                      await FirebaseFirestore.instance
                          .collection('admin')
                          .doc(user.uid)
                          .set({
                        'email': emailController.text,
                        'name': nameController.text,
                        'phone': phoneController.text,
                        'docId': user.uid,
                        'isAcess': false,
                        'isDoctor': true,
                        'isAdmin': false,
                      });

                      // print("Success");
                      var snackBar = const SnackBar(
                          content: Text("Account Created Successfully"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Get.offAll(() => const Root());
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      // print('The password provided is too weak.');
                      var snackBar = const SnackBar(
                          content: Text("The password provided is too weak."));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (e.code == 'email-already-in-use') {
                      // print('The account already exists for that email.');
                      var snackBar = const SnackBar(
                          content: Text(
                              "The account already exists for that email."));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  } catch (e) {
                    // print(e);
                  }
                  // Get.offAllNamed(rootRoute);//new commend
                  // Get.offAll(() => SiteLayout());
                  emailController.clear();
                  nameController.clear();
                  passwordController.clear();
                  phoneController.clear();
                } else {
                  var snackBar = const SnackBar(
                      content: Text("Please fill out all of Document"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: active, borderRadius: BorderRadius.circular(20)),
                alignment: Alignment.center,
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: const CustomText(
                  text: "Create Account",
                  color: Colors.white,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
