import 'package:data_table_2/data_table_2.dart';
import 'package:fallsa_admin/constants/style.dart';
import 'package:fallsa_admin/controllers/usersDetailsController.dart';
import 'package:fallsa_admin/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersTable extends StatelessWidget {
  // const UsersTable({Key key}) : super(key: key);
  final UsersDetailsController userController =
      Get.put(UsersDetailsController());

  @override
  Widget build(BuildContext context) {
    return Container(
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
              label: Text('IC Number'),
            ),
            DataColumn(
              label: Text('DOB'),
            ),
            DataColumn(
              label: Text('Phone Number'),
            ),
          ],
          rows: List<DataRow>.generate(
              userController.userDetails.length,
              (index) => DataRow(cells: [
                    DataCell(CustomText(
                        text: userController.userDetails[index].name)),
                    DataCell(
                        CustomText(text: userController.userDetails[index].ic)),
                    DataCell(Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomText(
                          text: userController.userDetails[index].dob,
                        )
                      ],
                    )),
                    DataCell(Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomText(
                          text: userController.userDetails[index].number,
                        )
                      ],
                    )),
                  ]))),
    );
  }
}
