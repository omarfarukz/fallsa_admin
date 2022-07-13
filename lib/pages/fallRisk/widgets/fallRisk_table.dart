import 'dart:convert';

import 'package:data_table_2/data_table_2.dart';
import 'package:fallsa_admin/constants/style.dart';

import 'package:fallsa_admin/controllers/userDataController.dart';
import 'package:fallsa_admin/pages/fallRisk/widgets/downloadFallRisk.dart';
import 'package:fallsa_admin/widgets/cText.dart';

import 'package:fallsa_admin/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:universal_html/html.dart';

class FallRiskTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GetBuilder<UserDataContrller>(builder: (userDataContrller) {
      final list = userDataContrller.isDoctor
          ? userDataContrller.dFallRiskList
          : userDataContrller.fallRiskList;

      return userDataContrller.isAcess
          ? Column(
              children: [
                userDataContrller.isDoctor
                    ? const CText(text: "This is the Doctor's View")
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: size.width * 0.25,
                            ),
                            DownloadFallRisk(),
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
                        userDataContrller.searchDFallRisk(value);
                      } else {
                        userDataContrller.searchFallRisk(value);
                      }
                    },
                    onSubmitted: (value) {
                      if (userDataContrller.isDoctor) {
                        userDataContrller.searchDFallRisk(value);
                      } else {
                        userDataContrller.searchFallRisk(value);
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
                          label: CText(text: "Full Name"),
                          size: ColumnSize.L,
                        ),
                        DataColumn(
                          label: CText(text: 'IC'),
                        ),
                        DataColumn(
                          label: CText(text: 'Date'),
                        ),
                        DataColumn(
                          label: CText(text: 'Score'),
                        ),
                        DataColumn(
                          label: CText(text: 'TUG'),
                        ),
                        DataColumn(
                          label: CText(text: 'Risk'),
                        ),
                      ],
                      rows: List<DataRow>.generate(
                        list.length,
                        (index) => DataRow(
                          cells: [
                            DataCell(
                              CustomText(text: list[index].name),
                              onTap: () {
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
                                row1.cells[0].value = ' Full Name';
                                row1.cells[1].value = list[index].name;

                                PdfGridRow row2 = grid.rows.add();
                                row2.cells[0].value = ' Petaint Ic';
                                row2.cells[1].value = list[index].ic;

                                PdfGridRow row3 = grid.rows.add();
                                row3.cells[0].value = ' Date Of Birth';
                                row3.cells[1].value = DateFormat('yyyy-MM-dd')
                                    .format(list[index].date.toDate());
                                PdfGridRow row4 = grid.rows.add();
                                row4.cells[0].value = ' Fall Risk Score';
                                row4.cells[1].value = '${list[index].score}';

                                PdfGridRow row5 = grid.rows.add();
                                row5.cells[0].value = ' TUG ';
                                row5.cells[1].value = list[index].tug;

                                PdfGridRow row6 = grid.rows.add();
                                row6.cells[0].value = ' Risk Type';
                                row6.cells[1].value = list[index].risk;

                                //Set the width
                                grid.columns[0].width = 100;

                                //Draw the grid in PDF document page
                                grid.style = PdfGridStyle(
                                    cellPadding: PdfPaddings(
                                        left: 2, right: 3, top: 4, bottom: 5),
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
                              },
                            ),
                            DataCell(CustomText(text: list[index].ic)),
                            DataCell(Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText(
                                  text: DateFormat('yyyy-MM-dd')
                                      .format(list[index].date.toDate()),
                                )
                              ],
                            )),
                            DataCell(
                                CustomText(text: list[index].score.toString())),
                            DataCell(
                                CustomText(text: list[index].tug.toString())),
                            DataCell(
                                CustomText(text: list[index].risk.toString())),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : const Center(child: CText(text: "You do not have permission"));
    });
  }
}
