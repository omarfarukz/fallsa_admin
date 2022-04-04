import 'dart:convert';

import 'package:data_table_2/data_table_2.dart';
import 'package:fallsa_admin/constants/style.dart';
import 'package:fallsa_admin/controllers/userDataController.dart';
import 'package:fallsa_admin/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:universal_html/html.dart';

class UsersTable extends StatelessWidget {
  const UsersTable({Key key}) : super(key: key);
  Future<void> _createPDf() {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();
    page.graphics.drawString(
        "Patients Details.", PdfStandardFont(PdfFontFamily.helvetica, 25));
    page.graphics.drawLine(PdfPens.black, Offset(0, 100), Offset(500, 100));
    PdfGrid grid = PdfGrid();

    PdfGridColumn column = PdfGridColumn(grid);
    grid.columns.add(column: column);
    grid.columns.add(count: 2);
//Add headers to grid
    grid.headers.add(1);
    PdfGridRow header = grid.headers[0];
    header.cells[0].value = 'Employee ID';
    header.cells[1].value = 'Employee Name';
    header.cells[2].value = 'Salary';
//Add rows to grid
    PdfGridRow row1 = grid.rows.add();
    row1.cells[0].value = 'E01';
    row1.cells[1].value = 'Clay';
    row1.cells[2].value = '\$10,000';
    PdfGridRow row2 = grid.rows.add();
    row2.cells[0].value = 'E02';
    row2.cells[1].value = 'Simon';
    row2.cells[2].value = '\$12,000';
//Set the width
    grid.columns[1].width = 50;
//Draw the grid in PDF document page
    grid.draw(page: page, bounds: Rect.zero);
//Save the document.

    List<int> bytes = document.save();
    document.dispose();
    AnchorElement(
        href:
            'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
      ..setAttribute('download', 'Users.pdf')
      ..click();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GetBuilder<UserDataContrller>(builder: (userDataContrller) {
      return Column(
        children: [
          Container(
            width: size.width * 0.80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: kElevationToShadow[6],
            ),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "Search here using ic number or name"),
              onChanged: (value) {
                userDataContrller.searchUsers(value);
              },
              onSubmitted: (value) {
                userDataContrller.searchUsers(value);
              },
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: active.withOpacity(.4), width: .5),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 6),
                      color: lightGrey.withOpacity(.1),
                      blurRadius: 12)
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 30),
              child: DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 600,
                columns: [
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
                  userDataContrller.userList.length,
                  (index) => DataRow(
                    cells: [
                      DataCell(
                        CustomText(
                            text: userDataContrller.userList[index].name),
                        onTap: () {
                          _createPDf();
                        },
                      ),
                      DataCell(CustomText(
                        text: userDataContrller.userList[index].gender,
                      )),
                      DataCell(CustomText(
                        text: userDataContrller.userList[index].education,
                      )),
                      DataCell(CustomText(
                        text: userDataContrller.userList[index].ic,
                      )),
                      DataCell(Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            text: userDataContrller.userList[index].dob
                                .toString(),
                          )
                        ],
                      )),
                      DataCell(CustomText(
                          text: userDataContrller.userList[index].number)),
                      DataCell(CustomText(
                          text: "${userDataContrller.userList[index].adress1}" +
                              " " +
                              "${userDataContrller.userList[index].adress2}")),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
