import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/core/utils/helpers.dart';

class StoreUserTable extends StatelessWidget {
  final List<StoreUserSummary> summaries;
  const StoreUserTable({super.key, required this.summaries});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DataTable(
        border: TableBorder.all(color: AppColor.primary),
        columns: const [
          DataColumn(label: Text('Store', style: TextStyle(color: AppColor.primary, fontWeight: FontWeight.bold),)),
          DataColumn(label: Text('User', style: TextStyle(color: AppColor.primary, fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Count', style: TextStyle(color: AppColor.primary, fontWeight: FontWeight.bold))),
        ],
        rows: summaries.map((summary) {
          final userName = getUser(context, summary.userId);
          final storeDisplayString = summary.storeCounts.entries
              .map((e) => '${getStore(context, e.key)} - ${e.value}')
              .join(', ');

          return DataRow(
            cells: [
              DataCell(Text(storeDisplayString)),
              DataCell(Text(userName.capitalizeFirst())),
              DataCell(Text(summary.totalCount.toString())),
            ]
          );
        }).toList(),
        dataRowMinHeight: 48,
        headingRowHeight: 48,
        horizontalMargin: 16,
        columnSpacing: 24,
      ),
    );
  }
}


class StoreUserSummary {
  final String userId; 
  final Map<String, int> storeCounts; // storeId -> count

  StoreUserSummary({required this.userId, required this.storeCounts});

  int get totalCount => storeCounts.values.fold(0, (a, b) => a + b);
}