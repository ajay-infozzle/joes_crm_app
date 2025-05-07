import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/core/utils/date_formatter.dart';
import 'package:joes_jwellery_crm/data/model/call_log_model.dart';
import 'package:joes_jwellery_crm/presentation/bloc/call/call_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/call/widget/call_log_tile.dart';
import 'package:joes_jwellery_crm/presentation/widgets/retry_widget.dart';

class CallLogsScreen extends StatefulWidget {
  const CallLogsScreen({super.key});

  @override
  State<CallLogsScreen> createState() => _CallLogsScreenState();
}

class _CallLogsScreenState extends State<CallLogsScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<CallLog> _filteredCalls = [];
  List<CallLog> _allCalls = [];

  // final List<CallLogTile> _allCalls = [
  //   CallLogTile(name: "James Joseph", date: "05th March, 2025", time: "02:45", callType: CallType.incoming),
  //   CallLogTile(name: "Michael Smith", date: "05th March, 2025", time: "03:15", callType: CallType.outgoing),
  //   CallLogTile(name: "Sophia Davis", date: "06th March, 2025", time: "04:10", callType: CallType.missed),
  //   CallLogTile(name: "James Joseph", date: "07th March, 2025", time: "05:30", callType: CallType.incoming),
  //   CallLogTile(name: "Emma Wilson", date: "08th March, 2025", time: "06:45", callType: CallType.missed),
  //   CallLogTile(name: "Daniel Lee", date: "09th March, 2025", time: "07:20", callType: CallType.outgoing),
  // ];

  @override
  void initState() {
    super.initState();
    context.read<CallCubit>().fetchCalls();
    // _filteredCalls = _allCalls;
    _searchController.addListener(_filterCalls);
  }

  void _filterCalls() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCalls = _allCalls
          .where((call) => call.customerName?.toLowerCase().contains(query) ?? false)
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  CallType _getCallType(String? type) {
    switch (type?.toLowerCase()) {
      case 'incoming':
        return CallType.incoming;
      case 'outgoing':
        return CallType.outgoing;
      case 'missed':
        return CallType.missed;
      default:
        return CallType.incoming;
    }
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
              // Expanded(
              //   child: Padding(
              //     padding: EdgeInsets.all(width*0.04),
              //     child: ListView(
              //       children: _filteredCalls,
              //     ),
              //   ),
              // ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(width * 0.04),
                  child: BlocBuilder<CallCubit, CallState>(
                    builder: (context, state) {
                      if (state is CallLogLoading) {
                        return const Center(child: CircularProgressIndicator(color: AppColor.primary,));
                      } 
                      else if (state is CallLogError) {
                        return RetryWidget(
                          onTap: () async{
                            await context.read<CallCubit>().fetchCalls();
                          }, 
                        );
                      } 
                      else if (state is CallLogLoaded) {
                        _allCalls = state.callLogModel.callLog ?? [];
                        _filteredCalls = _searchController.text.isEmpty
                            ? _allCalls
                            : _allCalls
                                .where((call) => call.customerName
                                    ?.toLowerCase()
                                    .contains(_searchController.text.toLowerCase()) ?? false)
                                .toList();

                        return RefreshIndicator(
                          color: AppColor.primary,
                          onRefresh: () async {
                            await context.read<CallCubit>().fetchCalls();
                          },
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: _filteredCalls.length,
                            itemBuilder: (context, index) {
                              final call = _filteredCalls[index];
                              final dateTime = formatDateTime(call.date?? "");
                              return CallLogTile(
                                name: call.customerName ?? 'Unknown',
                                date: dateTime["date"] ?? '',
                                time: dateTime["time"] ?? '',
                                callType: _getCallType(call.callType == "incoming" && call.callStatus == "missed"? call.callStatus :call.callType),
                              );
                            },
                          ),
                        );
                      }  else {
                        return const SizedBox();
                      }
                    },
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
