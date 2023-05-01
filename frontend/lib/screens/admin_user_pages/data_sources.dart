import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tripflutter/component/buttons.dart';
import 'package:tripflutter/models/registration.dart';
import 'package:tripflutter/modules/hike_repository.dart';
import 'package:tripflutter/screens/admin_user_pages/admin_user_page_controller.dart';

/// Data source implementing standard Flutter's DataTableSource abstract class
/// which is part of DataTable and PaginatedDataTable synchronous data fecthin API.
/// This class uses static collection of deserts as a data store, projects it into
/// DataRows, keeps track of selected items, provides sprting capability
class RegistrationDataSourceAsync extends AsyncDataTableSource {
  final BackendRepository _repo = BackendRepository();

  RegistrationDataSourceAsync() {
    sort((d) => d.status ?? 0, true); //TODO chek sort
  }

  List<Registration> registrations = [];

  RegistrationDataSourceAsync.empty() {
    _empty = true;
    print('DessertDataSourceAsync.empty created');
  }

  RegistrationDataSourceAsync.error() {
    _errorCounter = 0;
    print('DessertDataSourceAsync.error created');
  }

  bool _empty = false;
  int? _errorCounter;

  String? _tripFilter;
  String? get tripFilter => _tripFilter;
  set tripFilter(String? tripId) {
    _tripFilter = tripId;
    refreshDatasource();
  }

  String? _userIdFilter;
  String? get userIdFilter => _userIdFilter;
  set userIdFilter(String? userId) {
    _userIdFilter = userId;
    refreshDatasource();
  }

  Future<int> getTotalRecords() {
    return Future<int>.delayed(const Duration(milliseconds: 0),
        () => _empty ? 0 : registrations.length);
  }

  void sort<T>(
      Comparable<T> Function(Registration d) getField, bool ascending) {
    registrations.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    // refreshDatasource();
    notifyListeners();
  }

  bool isLoading = false;
  confirmPay(Registration registration) async {
    try {
      if (isLoading) return;
      isLoading = true;
      await Get.find<AdminUserPageController>()
          .confirmPayment(registration.userId!, registration.tripId!);
    } catch (e) {
    } finally {
      isLoading = false;
      refreshDatasource();
    }
  }

  @override
  Future<AsyncRowsResponse> getRows(int start, int end) async {
    print('getRows start $start, end $end');
    List<Registration> data =
        await _repo.getRegistrations(userId: userIdFilter, tripId: tripFilter);
    registrations = data;
    List<Registration> result = data.sublist(start).take(end).toList();
    AsyncRowsResponse response = AsyncRowsResponse(
        registrations.length,
        result.map((registration) {
          return DataRow(
            key: ValueKey<String>(
                '${registration.userId!}${registration.tripId!}'),
            selected: registration.selected,
            cells: [
              DataCell(Text(registration.userId ?? "")),
              DataCell(Text('${registration.tripId}')),
              DataCell(Text(registration.price?.toStringAsFixed(1) ?? "")),
              DataCell(Text('${registration.paymentInfo}')),
              DataCell(Text(
                  registration.paymentExpireDate?.toIso8601String() ?? "")),
              DataCell(Text('${registration.createDate}')),
              DataCell(Text(registration.status.toString() ?? "")),
              DataCell(
                Center(
                  child: registration.status == 2
                      ? MyFilledButton(
                          label: "確認付款",
                          onPressed: () {
                            confirmPay(registration);
                          },
                        )
                      : Text(
                          registration.status == 0 ? '未付款' : '已確認付款',
                        ),
                ),
              ),
            ],
          );
        }).toList());
    return response;
  }
}
