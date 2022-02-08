import 'package:data_table_2/data_table_2.dart';
import 'package:fallsa_admin/constants/style.dart';
import 'package:fallsa_admin/controllers/userDataController.dart';
import 'package:fallsa_admin/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersTable extends StatelessWidget {
  const UsersTable({Key key}) : super(key: key);

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
                    label: Text('Number'),
                  ),
                ],
                rows: List<DataRow>.generate(
                  userDataContrller.userList.length,
                  (index) => DataRow(
                    cells: [
                      DataCell(
                        CustomText(
                            text: userDataContrller.userList[index].name),
                      ),
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