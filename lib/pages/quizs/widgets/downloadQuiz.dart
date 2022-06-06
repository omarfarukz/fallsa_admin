import 'package:fallsa_admin/controllers/userDataController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:universal_html/html.dart' show AnchorElement hide Text;
import 'dart:convert';

import '../../../widgets/cText.dart';

class DownloadQuiz extends StatefulWidget {
  @override
  State<DownloadQuiz> createState() => _DownloadQuizState();
}

class _DownloadQuizState extends State<DownloadQuiz> {
  final UserDataContrller userDataContrller = Get.put(UserDataContrller());

  List data = ['omar', 'faruk', 'muhtasim'];

  Future<void> createExcel() async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];

    for (var count = 0; count < userDataContrller.quizList.length; count++) {
      sheet.getRangeByName('A1').setText('Full Name');
      sheet.getRangeByName('B1').setText('IC');
      sheet.getRangeByName('C1').setText('Date');
      sheet.getRangeByName('D1').setText('Pre-Quiz');
      sheet.getRangeByName('E1').setText('Post-Quiz');
      sheet
          .getRangeByName('A${count + 2}')
          .setText(userDataContrller.quizList[count].name);
      sheet
          .getRangeByName('B${count + 2}')
          .setText(userDataContrller.quizList[count].ic);
      sheet
          .getRangeByName('C${count + 2}')
          .setText(userDataContrller.quizList[count].date.toDate().toString());
      sheet
          .getRangeByName('D${count + 2}')
          .setText(userDataContrller.quizList[count].preCorrect.toString());
      sheet
          .getRangeByName('E${count + 2}')
          .setText(userDataContrller.quizList[count].postCorrect.toString());
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    AnchorElement(
        href:
            'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
      ..setAttribute('download', 'Quizs.xlsx')
      ..click();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      child: CText(text: "Download"),
      onPressed: createExcel,
    ));
  }
}
