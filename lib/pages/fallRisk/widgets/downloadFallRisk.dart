import 'package:fallsa_admin/controllers/userDataController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:universal_html/html.dart' show AnchorElement hide Text;
import 'dart:convert';

import '../../../widgets/cText.dart';

class DownloadFallRisk extends StatefulWidget {
  @override
  State<DownloadFallRisk> createState() => _DownloadFallRiskState();
}

class _DownloadFallRiskState extends State<DownloadFallRisk> {
  final UserDataContrller userDataContrller = Get.put(UserDataContrller());

  Future<void> createExcel() async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];

    for (var count = 0;
        count < userDataContrller.fallRiskList.length;
        count++) {
      sheet.getRangeByName('A1').setText('Full Name');
      sheet.getRangeByName('B1').setText('IC');
      sheet.getRangeByName('C1').setText('Date');
      sheet.getRangeByName('D1').setText('Pre-Quiz');
      sheet.getRangeByName('E1').setText('Post-Quiz');
      sheet
          .getRangeByName('A${count + 2}')
          .setText(userDataContrller.fallRiskList[count].name);
      sheet
          .getRangeByName('B${count + 2}')
          .setText(userDataContrller.fallRiskList[count].ic);
      sheet.getRangeByName('C${count + 2}').setText(
          userDataContrller.fallRiskList[count].date.toDate().toString());
      sheet
          .getRangeByName('D${count + 2}')
          .setText(userDataContrller.fallRiskList[count].score.toString());
      sheet
          .getRangeByName('E${count + 2}')
          .setText(userDataContrller.fallRiskList[count].risk.toString());
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    AnchorElement(
        href:
            'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
      ..setAttribute('download', 'FallRisks.xlsx')
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
