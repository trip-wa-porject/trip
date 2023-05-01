import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:tripflutter/component/buttons.dart';
import 'package:tripflutter/models/registration.dart';
import 'package:tripflutter/screens/schedule_selector/schedule_options/search_bar.dart';

import 'data_sources.dart';

class AdminRegisterManager extends StatefulWidget {
  const AdminRegisterManager({Key? key}) : super(key: key);

  @override
  State<AdminRegisterManager> createState() => _AdminRegisterManagerState();
}

class _AdminRegisterManagerState extends State<AdminRegisterManager> {
  TextEditingController textEditingController = TextEditingController();
  bool _sortAscending = true;

  int? _sortColumnIndex;

  late RegistrationDataSourceAsync _dessertsDataSource;

  @override
  void didChangeDependencies() {
    _dessertsDataSource = RegistrationDataSourceAsync();
    super.didChangeDependencies();
  }

  void _sort<T>(
    Comparable<T> Function(Registration d) getField,
    int columnIndex,
    bool ascending,
  ) {
    _dessertsDataSource.sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  void dispose() {
    _dessertsDataSource.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                child: MySearchBar(
                  controller: textEditingController,
                ),
              ),
              MyFilledButton(
                label: '搜尋',
                onPressed: () {
                  final String tripId = textEditingController.text;
                  _dessertsDataSource.tripFilter = tripId;
                },
              ),
              Spacer(),
              MyFilledButton(label: '顯示全部報名資料'),
            ],
          ),
          Expanded(
            child: AsyncPaginatedDataTable2(
              columnSpacing: 12,
              horizontalMargin: 12,
              showCheckboxColumn: false,
              border: TableBorder(
                top: const BorderSide(color: Colors.black),
                bottom: BorderSide(color: Colors.grey[300]!),
                left: BorderSide(color: Colors.grey[300]!),
                right: BorderSide(color: Colors.grey[300]!),
                verticalInside: BorderSide(color: Colors.grey[300]!),
              ),
              dividerThickness: 1,
              minWidth: 900,
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _sortAscending,
              sortArrowIcon: Icons.keyboard_arrow_up,
              sortArrowAnimationDuration: const Duration(milliseconds: 500),
              rowsPerPage: 10,
              columns: [
                DataColumn2(
                  label: const Text('userId'),
                  size: ColumnSize.S,
                  onSort: (columnIndex, ascending) => _sort<String>(
                      (d) => d.userId ?? "", columnIndex, ascending),
                ),
                DataColumn2(
                  label: const Text('trip id'),
                  size: ColumnSize.S,
                  numeric: true,
                  onSort: (columnIndex, ascending) => _sort<String>(
                      (d) => d.tripId ?? '', columnIndex, ascending),
                ),
                DataColumn2(
                  label: const Text('price'),
                  size: ColumnSize.S,
                  numeric: true,
                  onSort: (columnIndex, ascending) =>
                      _sort<num>((d) => d.price ?? 0, columnIndex, ascending),
                ),
                const DataColumn2(
                  label: Text('paymentInfo'),
                  size: ColumnSize.S,
                  numeric: true,
                ),
                DataColumn2(
                  label: const Text('paymentExpireDate'),
                  size: ColumnSize.S,
                  numeric: true,
                  onSort: (columnIndex, ascending) => _sort<DateTime>(
                      (d) => d.paymentExpireDate ?? DateTime.now(),
                      columnIndex,
                      ascending),
                ),
                DataColumn2(
                  label: const Text('createDate'),
                  size: ColumnSize.S,
                  numeric: true,
                  onSort: (columnIndex, ascending) => _sort<DateTime>(
                      (d) => d.createDate ?? DateTime.now(),
                      columnIndex,
                      ascending),
                ),
                DataColumn2(
                  label: const Text('status'),
                  size: ColumnSize.S,
                  numeric: true,
                  onSort: (columnIndex, ascending) =>
                      _sort<num>((d) => d.status ?? 0, columnIndex, ascending),
                ),
                DataColumn2(
                  label: const Text('action'),
                  size: ColumnSize.S,
                ),
              ],
              empty: Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.grey[200],
                  child: const Text('No data'),
                ),
              ),
              source: _dessertsDataSource,
            ),
          ),
        ],
      ),
    );
  }
}
