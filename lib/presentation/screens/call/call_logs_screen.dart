import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/presentation/screens/call/widget/call_log_tile.dart';

class CallLogsScreen extends StatefulWidget {
  const CallLogsScreen({super.key});

  @override
  State<CallLogsScreen> createState() => _CallLogsScreenState();
}

class _CallLogsScreenState extends State<CallLogsScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<CallLogTile> _filteredCalls = [];
  final List<CallLogTile> _allCalls = [
    CallLogTile(name: "James Joseph", date: "05th March, 2025", time: "02:45", callType: CallType.incoming),
    CallLogTile(name: "Michael Smith", date: "05th March, 2025", time: "03:15", callType: CallType.outgoing),
    CallLogTile(name: "Sophia Davis", date: "06th March, 2025", time: "04:10", callType: CallType.missed),
    CallLogTile(name: "James Joseph", date: "07th March, 2025", time: "05:30", callType: CallType.incoming),
    CallLogTile(name: "Emma Wilson", date: "08th March, 2025", time: "06:45", callType: CallType.missed),
    CallLogTile(name: "Daniel Lee", date: "09th March, 2025", time: "07:20", callType: CallType.outgoing),
  ];

  @override
  void initState() {
    super.initState();
    _filteredCalls = _allCalls;
    _searchController.addListener(_filterCalls);
  }

  void _filterCalls() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCalls = _allCalls.where((call) {
        return call.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.greenishGrey,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.white,
        title: SizedBox(
          width: width * 0.33,
          child: Image.asset(
            AssetsConstant.joesLogo,
            fit: BoxFit.contain,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: AppColor.primary),
          onPressed: () {},
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          color: AppColor.white,
          child: Column(
            children: [
              //~ Search Bar
              Padding(
                padding: EdgeInsets.all(width*0.04),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppDimens.spacing15),
                      child: SizedBox(
                        width: AppDimens.icon13, 
                        height: AppDimens.icon13,
                        child: Image.asset(
                          AssetsConstant.searchIcon, 
                          color: AppColor.primary.withValues(alpha: .8),
                          fit: BoxFit.contain,
                        )
                      ),
                    ),
                    hintText: "Search",
                    hintStyle: TextStyle(color: AppColor.primary.withValues(alpha: .8)),
                    filled: true,
                    fillColor: AppColor.greenishGrey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppDimens.radius12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: AppDimens.spacing5),
                  ),
                  cursorColor: AppColor.primary,
                ),
              ),

              //~ Call Log List
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(width*0.04),
                  child: ListView(
                    children: _filteredCalls,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
