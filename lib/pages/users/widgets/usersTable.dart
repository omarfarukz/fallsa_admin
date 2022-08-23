import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:fallsa_admin/constants/style.dart';
import 'package:fallsa_admin/controllers/userDataController.dart';
import 'package:fallsa_admin/pages/users/widgets/downloadUsers.dart';
import 'package:fallsa_admin/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:universal_html/html.dart' hide Text;

import '../util/db.dart';

class UsersTable extends StatelessWidget {
  UsersTable({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List userFallData;
    List userStrengthData;
    DateTime dateTime = DateTime.now();
    final DateFormat formatter1 = DateFormat('EEE, y-m-d');

    final Size size = MediaQuery.of(context).size;
    return GetBuilder<UserDataContrller>(builder: (userDataContrller) {
      final list = userDataContrller.isDoctor
          ? userDataContrller.dUserList
          : userDataContrller.userList;
      return userDataContrller.isAcess
          ? Column(
              children: [
                userDataContrller.isDoctor
                    ? const Text("This is the Doctor's View")
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: size.width * 0.25,
                            ),
                            DownloadUsers(),
                          ],
                        ),
                      ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  width: size.width * 0.80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow: kElevationToShadow[6],
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        hintText: "Search here using ic number or name"),
                    onChanged: (value) {
                      if (userDataContrller.isDoctor) {
                        userDataContrller.searchDUser(value);
                      } else {
                        userDataContrller.searchUsers(value);
                      }
                    },
                    onSubmitted: (value) {
                      if (userDataContrller.isDoctor) {
                        userDataContrller.searchDUser(value);
                      } else {
                        userDataContrller.searchUsers(value);
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(color: active.withOpacity(.4), width: .5),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 6),
                            color: lightGrey.withOpacity(.1),
                            blurRadius: 12)
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 30),
                    child: DataTable2(
                      columnSpacing: 12,
                      horizontalMargin: 12,
                      minWidth: 600,
                      columns: const [
                        DataColumn2(
                          label: Text("Full Name"),
                          size: ColumnSize.L,
                        ),
                        DataColumn(
                          label: Text('Ic'),
                        ),
                        DataColumn(
                          label: Text('DOB'),
                        ),
                        DataColumn(
                          label: Text('Gender'),
                        ),
                        DataColumn(
                          label: Text('Education'),
                        ),
                        DataColumn(
                          label: Text('Number'),
                        ),
                        DataColumn(
                          label: Text('Adress'),
                        ),
                      ],
                      rows: List<DataRow>.generate(
                        list.length,
                        (index) => DataRow(
                          cells: [
                            DataCell(
                              CustomText(text: list[index].name),
                              onTap: () {
                                try {
                                  String userUid = list[index].uid;
                                  String dob;
                                  int currentAge;
                                  dob = list[index].dob;

                                  print("The DOB is :" + dob.toString());
                                  String birthyear1 = '${dob[0]}';
                                  String birthyear2 = '${dob[1]}';
                                  String birthyear =
                                      '19' + birthyear1 + birthyear2;
                                  int i = int.parse(birthyear);

                                  final DateTime now = DateTime.now();
                                  final DateFormat formatter =
                                      DateFormat('yyyy');
                                  final String formatted =
                                      formatter.format(now);
                                  int currentYear = int.parse(formatted);
                                  currentAge = currentYear - i;

                                  userDataContrller
                                      .userFallRisk(userUid)
                                      .then((QuerySnapshot docs) {
                                    userFallData = docs.docs;
                                  });
                                  userDataContrller
                                      .userStrength(userUid)
                                      .then((QuerySnapshot docs) {
                                    userStrengthData = docs.docs;
                                  });
                                  // DB()
                                  //     .getFallRisk(userUid)
                                  //     .then((QuerySnapshot docs) {
                                  //   userData = docs.docs;
                                  // });
                                  // for (int i=0; i<userData.length;i++){
                                  // }

                                  Future.delayed(Duration(seconds: 2), () {
                                    print(currentAge);
                                    print("User Date of Birth is : $i");

                                    int lastValue = userFallData.length - 1;
                                    // print("Data lenth is ${userFallData.length}");
                                    // print(
                                    //     userFallData[lastValue]['score'].toString());

                                    // _createPDf();
                                    PdfDocument document = PdfDocument();
                                    final page = document.pages.add();

                                    PdfGrid grid = PdfGrid();

                                    PdfGridColumn column = PdfGridColumn(grid);

                                    grid.columns.add(column: column);
                                    grid.columns.add(count: 1);
                                    //Add headers to grid
                                    grid.headers.add(1);
                                    PdfGridRow header = grid.headers[0];

                                    header.cells[0].value = ' Category';
                                    header.cells[1].value = ' Details';

                                    //Add rows to grid
                                    PdfGridRow row1 = grid.rows.add();
                                    row1.cells[0].value = ' Date';
                                    row1.cells[1].value =
                                        formatter1.format(dateTime);

                                    PdfGridRow row2 = grid.rows.add();
                                    row2.cells[0].value = ' Full Name';
                                    row2.cells[1].value = list[index].name;

                                    PdfGridRow row3 = grid.rows.add();
                                    row3.cells[0].value = ' Petaint Ic';
                                    row3.cells[1].value = list[index].ic;

                                    PdfGridRow row4 = grid.rows.add();
                                    row4.cells[0].value = ' Age';
                                    row4.cells[1].value = currentAge.toString();
                                    PdfGridRow row5 = grid.rows.add();
                                    row5.cells[0].value = ' Gender';
                                    row5.cells[1].value = list[index].gender;

                                    PdfGridRow row6 = grid.rows.add();
                                    row6.cells[0].value = ' Education';
                                    row6.cells[1].value = list[index].education;
                                    PdfGridRow row7 = grid.rows.add();
                                    row7.cells[0].value = ' Contact Number';
                                    row7.cells[1].value = list[index].number;
                                    PdfGridRow row8 = grid.rows.add();
                                    row8.cells[0].value = ' Adress';
                                    row8.cells[1].value = list[index].adress1 +
                                        " " +
                                        list[index].adress2;
                                    PdfGridRow row9 = grid.rows.add();
                                    row9.cells[0].value = 'Fall Risk';
                                    row9.cells[1].value =
                                        "Fall Score: ${userFallData[lastValue]['score'].toString()}  TUG Score: ${userFallData[lastValue]['tug'].toString()}  Rsik Type: ${userFallData[lastValue]['risk'].toString()}";
                                    PdfGridRow row10 = grid.rows.add();
                                    row10.cells[0].value = 'Strength Score';
                                    row10.cells[1].value =
                                        " ${userStrengthData[lastValue]['score'].toString()}";
                                    // PdfGridRow row10 = grid.rows.add();
                                    // row10.cells[0].value = 'Fall Score';
                                    // row10.cells[1].value =
                                    //     userData[lastValue]['score'].toString();

                                    //Set the width
                                    grid.columns[0].width = 100;

                                    //Draw the grid in PDF document page
                                    grid.style = PdfGridStyle(
                                        cellPadding: PdfPaddings(
                                            left: 2,
                                            right: 3,
                                            top: 4,
                                            bottom: 5),
                                        font: PdfStandardFont(
                                            PdfFontFamily.timesRoman, 12));
                                    grid.draw(
                                      page: page,
                                      bounds: Rect.zero,
                                    );
                                    //Save the document.
                                    List<int> bytes = document.save();
                                    document.dispose();
                                    AnchorElement(
                                        href:
                                            'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
                                      ..setAttribute(
                                          'Download', '${list[index].name}.pdf')
                                      ..click();
                                  });
                                } catch (e) {
                                  print(e.toString());
                                }
                              },
                            ),
                            DataCell(CustomText(
                              text: list[index].ic,
                            )),
                            DataCell(CustomText(
                              text: list[index].dob.toString(),
                            )),
                            DataCell(CustomText(
                              text: list[index].gender,
                            )),
                            DataCell(CustomText(
                              text: list[index].education,
                            )),
                            DataCell(CustomText(text: list[index].number)),
                            DataCell(CustomText(
                                text: list[index].adress1 +
                                    " " +
                                    list[index].adress2)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : const Center(child: Text("You do not have permission"));
    });
  }
}
