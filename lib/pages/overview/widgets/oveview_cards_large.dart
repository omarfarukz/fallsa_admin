import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fallsa_admin/constants/style.dart';
import 'package:fallsa_admin/controllers/userDataController.dart';
import 'package:fallsa_admin/pages/overview/widgets/info_cards.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class OverViewCardsLargeScreen extends StatelessWidget {
  OverViewCardsLargeScreen({Key key}) : super(key: key);
  final UserDataContrller userDataContrller = Get.put(UserDataContrller());
  final _pId = TextEditingController();

  updatePatient() async {
    try {
      var collection = FirebaseFirestore.instance.collection('userDetails');

      collection.doc(_pId.text).set(
          {"dUid": userDataContrller.doctorId.toString()},
          SetOptions(merge: true));
    } catch (e) {
      // print("There is error to update user list. Error: $e");
    }
// //update fall risk
//     CollectionReference collectionReference =
//         FirebaseFirestore.instance.collection("fallRisk");
//     var newDocumentBody = {"dUid": userDataContrller.doctorId.toString()};
//     DocumentReference docRef;
//     var responce =
//         await collectionReference.where('uid', isEqualTo: _pId.text).get();
//     print(responce.docs.length);
//     var batch = FirebaseFirestore.instance.batch();
//     responce.docs.forEach((doc) {
//       docRef = collectionReference.doc(doc.id);
//       batch.update(docRef, newDocumentBody);
//     });

//     batch
//         .commit()
//         .then((value) => {print("Updated fall risk documents inside")});
// //Update the quiz list
//     CollectionReference quizCollectionReference =
//         FirebaseFirestore.instance.collection("quiz");
//     var quizDocumentBody = {"dUid": userDataContrller.doctorId.toString()};
//     DocumentReference quizdocRef;
//     var quizresponce =
//         await quizCollectionReference.where('uid', isEqualTo: _pId.text).get();
//     var quizbatch = FirebaseFirestore.instance.batch();
//     quizresponce.docs.forEach((doc) {
//       quizdocRef = quizCollectionReference.doc(doc.id);
//       quizbatch.update(quizdocRef, quizDocumentBody);
//     });

//     quizbatch
//         .commit()
//         .then((value) => {print("Updated Quiz documents inside")});

//     //update strength
//     CollectionReference stcollectionReference =
//         FirebaseFirestore.instance.collection("strength");
//     var stDocumentBody = {"dUid": userDataContrller.doctorId.toString()};
//     DocumentReference stdocRef;
//     var stresponce =
//         await stcollectionReference.where('uid', isEqualTo: _pId.text).get();
//     print(responce.docs.length);
//     var stbatch = FirebaseFirestore.instance.batch();
//     stresponce.docs.forEach((doc) {
//       stdocRef = stcollectionReference.doc(doc.id);
//       stbatch.update(stdocRef, stDocumentBody);
//     });

//     stbatch
//         .commit()
//         .then((value) => {print("Updated Strength documents inside")});
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return GetBuilder<UserDataContrller>(builder: (userDataContrller) {
      // final list = userDataContrller.fallRiskList;

      return userDataContrller.isAcess
          ? Stack(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        InfoCard(
                          title: 'Total Users',
                          value: userDataContrller.userList.length.toString(),
                          onTap: () {},
                          topColour: Colors.orange,
                        ),
                        SizedBox(
                          width: _width / 64,
                        ),
                        InfoCard(
                          title: 'Total Fall Risk Test',
                          value:
                              userDataContrller.fallRiskList.length.toString(),
                          onTap: () {},
                          topColour: Colors.blueAccent,
                        ),
                        SizedBox(
                          width: _width / 64,
                        ),
                        InfoCard(
                          title: 'Total Strength Test',
                          value:
                              userDataContrller.strengthList.length.toString(),
                          onTap: () {},
                          topColour: Colors.blueGrey,
                        ),
                        SizedBox(
                          width: _width / 64,
                        ),
                        InfoCard(
                          title: 'Total Quiz Attemped',
                          value: userDataContrller.quizList.length.toString(),
                          onTap: () {},
                          topColour: Colors.redAccent,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: _height * 0.10,
                    ),
                    Text(
                      "Welcome ${userDataContrller.adminName} to the Fallsa Admin Panel",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                      height: _height * 0.01,
                    ),
                    Text(
                      "Your ID is: ${userDataContrller.user.uid} ",
                      style: const TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: _height * 0.01,
                    ),
                    const Text(
                      "If you have any account Issues,Please refer the Administrator with your ID ",
                      style: TextStyle(fontSize: 16),
                    ),
                    const Divider(),
                    SizedBox(
                      height: _height * 0.05,
                    ),
                    const Text(
                      "Please key in the patient\'s ID number and click add button",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: _height * 0.02,
                    ),
                    const Text(
                      "Pataients ID can be found in the Profile section of the Fallsa Application",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: _height * 0.02,
                    ),
                    const Text(
                      "Warning!! Only Existed Patients account could be updated",
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ),
                    SizedBox(
                      height: _height * 0.02,
                    ),
                    Center(
                        child: Container(
                      constraints: const BoxConstraints(maxWidth: 400),
                      padding: const EdgeInsets.all(16),
                      child: Column(children: [
                        TextField(
                          controller: _pId,
                          decoration: InputDecoration(
                              labelText: "Patient's ID",
                              hintText: "abcdefgh123456",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_pId.text.isNotEmpty) {
                              updatePatient();
                              var snackBar = const SnackBar(
                                  content: Text("Update Sucuessfull"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              _pId.clear();
                            } else {
                              var snackBar = const SnackBar(
                                  content: Text("Please key in IC Number"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          child: Container(
                            // margin: EdgeInsets.only(top: 20),
                            height: _height * 0.05,
                            alignment: Alignment.center,
                            // padding: EdgeInsets.symmetric(vertical: 16),
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                color: active,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                                child: Text(
                              "Add Patient",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            )),
                          ),
                        ),
                      ]),
                    )),
                  ],
                ),
                // Align(
                //   heightFactor: 10,
                //   widthFactor: 10,
                //   alignment: Alignment.topLeft,
                //   child: Text("Hi"),
                // )
              ],
            )
          : const Center(child: Text("You Dont have permission"));
    });
  }
}
