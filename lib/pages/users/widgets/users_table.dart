import 'package:data_table_2/data_table_2.dart';
import 'package:fallsa_admin/constants/style.dart';
import 'package:fallsa_admin/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class UsersTable extends StatelessWidget {
  const UsersTable({Key key}) : super(key: key);

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
              50,
              (index) => DataRow(cells: [
                    DataCell(CustomText(text: "Dewan Ahmed Muhtasim")),
                    DataCell(CustomText(text: "12345678911")),
                    DataCell(Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomText(
                          text: "12-21-2022",
                        )
                      ],
                    )),
                    DataCell(Container(
                        decoration: BoxDecoration(
                          color: light,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: active, width: .5),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: CustomText(
                          text: "12345678912",
                          color: active.withOpacity(.7),
                          weight: FontWeight.bold,
                        ))),
                  ]))),
    );
  }
}
