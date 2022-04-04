import 'package:fallsa_admin/controllers/userDataController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

import 'package:universal_html/html.dart' show AnchorElement;
import 'dart:convert';

class DownloadUsers extends StatefulWidget {
  @override
  State<DownloadUsers> createState() => _DownloadUsersState();
}

class _DownloadUsersState extends State<DownloadUsers> {
  final UserDataContrller userDataContrller = Get.put(UserDataContrller());

  Future<void> createExcel() async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];

    for (var count = 0; count < userDataContrller.userList.length; count++) {
      sheet.getRangeByName('A1').setText('Full Name');
      sheet.getRangeByName('B1').setText('IC');
      sheet.getRangeByName('C1').setText('DOB');
      sheet.getRangeByName('D1').setText('Number');
      // sheet.getRangeByName('D1').setText('Post-Quiz');
      sheet
          .getRangeByName('A${count + 2}')
          .setText(userDataContrller.userList[count].name);
      sheet
          .getRangeByName('B${count + 2}')
          .setText(userDataContrller.userList[count].ic);
      sheet
          .getRangeByName('C${count + 2}')
          .setText(userDataContrller.userList[count].dob.toString());
      sheet
          .getRangeByName('D${count + 2}')
          .setText(userDataContrller.userList[count].number.toString());
      // sheet
      //     .getRangeByName('E${count + 2}')
      //     .setText(userDataContrller.quizList[count].postCorrect.toString());
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    AnchorElement(
        href:
            'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
      ..setAttribute('download', 'Users.xlsx')
      ..click();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      child: Text("Download"),
      onPressed: createExcel,
    ));
  }
}
