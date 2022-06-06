import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fallsa_admin/constants/style.dart';
import 'package:fallsa_admin/widgets/custom_drop_down.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/controllers.dart';
import '../../controllers/userDataController.dart';
import '../../helpers/responsiveness.dart';
import '../../widgets/custom_text.dart';

class AdminScreen extends StatelessWidget {
  AdminScreen({Key key}) : super(key: key);

  bool isDoctor = true;
  bool isAccess = false;
  final doctorIDController = TextEditingController();

  final doctorAccessController = TextEditingController();

  final List<String> roles = [
    'Doctor',
    "Researcher",
  ];
  final List<String> access = [
    'Active',
    "Denied",
  ];
  final role = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<UserDataContrller>(builder: (userDataContrller) {
      print("Status:${userDataContrller.isAdmin}");
      return userDataContrller.isAdmin
          ? Column(
              children: [
                Obx(
                  () => Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: ResponsiveWidget.isSmallScreen(context)
                                ? 56
                                : 6),
                        child: CustomText(
                          text: menuController.activeitem.value,
                          size: 24,
                          weight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.10,
                    ),
                    const Text(
                      "PleaseKey In the acess Number",
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(
                      height: size.height * 0.10,
                    ),
                    TextField(
                      controller: doctorIDController,
                      decoration: InputDecoration(
                          labelText: "Doctor ID",
                          hintText: "abcABC123",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    CustomDropDown(
                      colors: Colors.black,
                      options: roles,
                      title: "Admin Roles",
                      controller: role,
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    CustomDropDown(
                      colors: Colors.black,
                      options: access,
                      title: "Access",
                      controller: doctorAccessController,
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    InkWell(
                      onTap: () async {
                        if (role.text == "Doctor") {
                          isDoctor = true;
                        } else if (role.text == "Researcher") {
                          isDoctor = false;
                        }
                        if (doctorAccessController.text == "Active") {
                          isAccess = true;
                        } else if (doctorAccessController.text == "Denied") {
                          isAccess = false;
                        }
                        // print(isDoctor);
                        // print(isAccess);
                        if (doctorIDController.text.isNotEmpty) {
                          Future.delayed(Duration(milliseconds: 1), () async {
                            try {
                              var collection = FirebaseFirestore.instance
                                  .collection('admin');
                              await collection
                                  .doc(doctorIDController.text)
                                  .set({
                                "isAccess": isAccess, //initially isAccess false
                                "isDoctor": isDoctor //initially isDcotor true
                              }, SetOptions(merge: true));
                              var snackBar =
                                  SnackBar(content: Text("Update Sucuessfull"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } catch (e) {
                              var snackBar =
                                  SnackBar(content: Text(e.toString()));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: active,
                            borderRadius: BorderRadius.circular(20)),
                        alignment: Alignment.center,
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: CustomText(
                          text: "Update",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ))
              ],
            )
          : const Center(
              child: Text("Sorry You Do Not have acess to Super Admin"));
    });
  }
}
