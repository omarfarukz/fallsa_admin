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

class SignUpScreen extends GetWidget<AuthController> {
  // SignUpScreen({Key key}) : super(key: key);
  final _auth = FirebaseAuth.instance;
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(children: [
          SizedBox(
            height: size.height * 0.2,
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
                labelText: "Email",
                hintText: "name@gmail.com",
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
                hintText: "Mr John",
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
                hintText: "012345678",
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
                hintText: "123",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          InkWell(
            onTap: () async {
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
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => AuthenticationPage()));

                  print("Success");
                  Get.offAll(() => Root());
                }
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  print('The password provided is too weak.');
                } else if (e.code == 'email-already-in-use') {
                  print('The account already exists for that email.');
                }
              } catch (e) {
                print(e);
              }
              // Get.offAllNamed(rootRoute);//new commend
              // Get.offAll(() => SiteLayout());
              emailController.clear();
              nameController.clear();
              passwordController.clear();
              phoneController.clear();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: active, borderRadius: BorderRadius.circular(20)),
              alignment: Alignment.center,
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(vertical: 16),
              child: CustomText(
                text: "Create Account",
                color: Colors.white,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
