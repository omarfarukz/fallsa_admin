import 'package:data_table_2/data_table_2.dart';
import 'package:fallsa_admin/constants/style.dart';
import 'package:fallsa_admin/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class UsersDataTable extends StatelessWidget {
  const UsersDataTable({Key key}) : super(key: key);

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
              label: Text('Pre-Quiz'),
            ),
            DataColumn(
              label: Text('Post Quiz'),
            ),
            DataColumn(
              label: Text('Fall Risk'),
            ),
            DataColumn(
              label: Text('Strength'),
            ),
          ],
          rows: List<DataRow>.generate(
              15,
              (index) => DataRow(cells: [
                    DataCell(CustomText(text: "Omar Faruk")),
                    DataCell(CustomText(text: "7")),
                    DataCell(Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomText(
                          text: "8",
                        )
                      ],
                    )),
                    DataCell(Row(
                      children: [
                        CustomText(text: "Low"),
                        SizedBox(
                          width: 1,
                        ),
                        CustomText(text: "Score 10"),
                      ],
                    )),
                    DataCell(CustomText(text: "5 Times")),
                  ]))),
    );
  }
}
