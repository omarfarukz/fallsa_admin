import 'package:fallsa_admin/controllers/userDataController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:universal_html/html.dart' show AnchorElement hide Text;
import 'dart:convert';

import '../../../widgets/cText.dart';

class DownloadST extends StatefulWidget {
  @override
  State<DownloadST> createState() => _DownloadSTState();
}

class _DownloadSTState extends State<DownloadST> {
  final UserDataContrller userDataContrller = Get.put(UserDataContrller());

  Future<void> createExcel() async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];

    for (var count = 0;
        count < userDataContrller.strengthList.length;
        count++) {
      sheet.getRangeByName('A1').setText('Full Name');
      sheet.getRangeByName('B1').setText('IC');
      sheet.getRangeByName('C1').setText('Date');
      sheet.getRangeByName('D1').setText('Score');
      sheet
          .getRangeByName('A${count + 2}')
          .setText(userDataContrller.strengthList[count].name);
      sheet
          .getRangeByName('B${count + 2}')
          .setText(userDataContrller.strengthList[count].ic);
      sheet.getRangeByName('C${count + 2}').setText(
          userDataContrller.strengthList[count].date.toDate().toString());
      sheet
          .getRangeByName('D${count + 2}')
          .setText(userDataContrller.strengthList[count].score.toString());
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    AnchorElement(
        href:
            'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
      ..setAttribute('download', 'Strengths.xlsx')
      ..click();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      child: const CText(text:"Download"),
      onPressed: createExcel,
    ));
  }
}
