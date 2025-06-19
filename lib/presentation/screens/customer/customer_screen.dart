import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/routes/routes_name.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/data/model/customer_list_model.dart';
import 'package:joes_jwellery_crm/presentation/bloc/customer/customer_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/campaign/widget/send_email_campaign_dialog.dart';
import 'package:joes_jwellery_crm/presentation/screens/campaign/widget/send_sms_campaign_dialog.dart';
import 'package:joes_jwellery_crm/presentation/screens/customer/widget/customer_filter.dart';
import 'package:joes_jwellery_crm/presentation/screens/customer/widget/customer_tile.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_button.dart';
import 'package:joes_jwellery_crm/presentation/widgets/retry_widget.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  List<Customers> filteredCustomers = [];
  List<Customers> allCustomers = [];
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<CustomerCubit>().fetchCustomers();

    context.read<CustomerCubit>().customerFilterFormData = {};

    scrollController = ScrollController();
  }

  int currentPage = 1;
  int pageSize = 20;
  List<Customers> get paginatedCustomers {
    final start = (currentPage - 1) * pageSize;
    final end = (start + pageSize).clamp(0, filteredCustomers.length);
    return filteredCustomers.sublist(start, end);
  }

  int get totalPages => (filteredCustomers.length / pageSize).ceil();

  void filterSearch(String query) {
    setState(() {
      filteredCustomers =
          allCustomers.where((customer) {
            return customer.id!.contains(query) ||
                customer.store!.toLowerCase().contains(query.toLowerCase()) ||
                (customer.name != null
                    ? customer.name!.toLowerCase().contains(query.toLowerCase())
                    : false) ||
                (customer.surname != null
                    ? customer.surname!.toLowerCase().contains(
                      query.toLowerCase(),
                    )
                    : false);
          }).toList();
    });
  }

  void _onDataLoaded(List<Customers> customers) {
    allCustomers = customers;
    filteredCustomers =
        searchController.text.isEmpty
            ? allCustomers
            : allCustomers
                .where(
                  (item) =>
                      item.name?.toLowerCase().contains(
                        searchController.text.toLowerCase(),
                      ) ??
                      false,
                )
                .toList();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.greenishGrey,

      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.primary,
        foregroundColor: AppColor.white,
        title: SizedBox(
          // width: width * 0.33,
          child: Text(
            "Customer",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppDimens.spacing18,
            ),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: AppColor.white),
          onPressed: () {
            context.pop();
          },
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              AssetsConstant.filterIcon,
              width: AppDimens.icon18,
              height: AppDimens.icon18,
              color: AppColor.white,
            ),
            onPressed: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return CustomerFilter(
                    onSearch: (formdata) {
                      context.read<CustomerCubit>().filterCustomers(
                        formdata: formdata,
                      );
                    },
                  );
                },
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              size: AppDimens.icon25,
              color: AppColor.white,
            ),
            onPressed: () {
              context.pushNamed(RoutesName.searchCustomerScreen);
            },
          ),
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          width: width,
          color: AppColor.white,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppDimens.spacing10,
                  horizontal: AppDimens.spacing15,
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: filterSearch,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimens.spacing15,
                      ),
                      child: SizedBox(
                        width: AppDimens.icon13,
                        height: AppDimens.icon13,
                        child: Image.asset(
                          AssetsConstant.searchIcon,
                          color: AppColor.primary.withValues(alpha: .8),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    hintText: "Search for ID, Name, Store...",
                    hintStyle: TextStyle(
                      color: AppColor.primary.withValues(alpha: .8),
                    ),
                    filled: true,
                    fillColor: AppColor.greenishGrey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppDimens.radius12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: AppDimens.spacing5,
                    ),
                  ),
                  cursorColor: AppColor.primary,
                ),
              ),

              BlocBuilder<CustomerCubit, CustomerState>(
                builder: (context, state) {
                  if (context
                      .read<CustomerCubit>()
                      .customerFilterFormData
                      .isEmpty) {
                    return SizedBox();
                  }

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppDimens.spacing10,
                      horizontal: AppDimens.spacing15,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                text: "Email Campaign",
                                backgroundColor: AppColor.green,
                                fontSize: AppDimens.textSize14,
                                onPressed: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return SendEmailCampaignDialog(
                                        from: '',
                                        onSend: (formdata) {
                                          context
                                              .read<CustomerCubit>()
                                              .sendEmailCampaign(
                                                formdata: formdata,
                                              );
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            10.w,
                            Expanded(
                              child: CustomButton(
                                text: "SMS Campaign",
                                backgroundColor: AppColor.green,
                                fontSize: AppDimens.textSize14,
                                onPressed: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return SendSmsCampaignDialog(
                                        onSend: (formdata) {
                                          context
                                              .read<CustomerCubit>()
                                              .sendEmailCampaign(
                                                formdata: formdata,
                                              );
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        10.h,

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${allCustomers.length} results"),
                            10.w,
                            GestureDetector(
                              onTap: () {
                                context.read<CustomerCubit>().fetchCustomers();
                              },
                              child: Text(
                                "Clear filter",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.greenishBlue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),

              Expanded(
                child: BlocConsumer<CustomerCubit, CustomerState>(
                  listener: (context, state) {
                    if (state is CustomerListLoaded) {
                      allCustomers.clear();
                      filteredCustomers.clear();
                      currentPage = 1;
                      _onDataLoaded(state.customers);
                    }
                  },
                  builder: (context, state) {
                    if (state is CustomerListLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColor.primary,
                        ),
                      );
                    } else if (state is CustomerListError) {
                      return RetryWidget(
                        onTap: () async {
                          context.read<CustomerCubit>().fetchCustomers();
                        },
                      );
                    } else if (allCustomers.isNotEmpty) {
                      return RefreshIndicator(
                        color: AppColor.primary,
                        onRefresh: () async {
                          context.read<CustomerCubit>().fetchCustomers();
                        },
                        child: ListView.builder(
                          controller: scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimens.spacing15,
                            vertical: AppDimens.spacing8,
                          ),
                          // itemCount: filteredCustomers.length,
                          itemCount: paginatedCustomers.length,
                          itemBuilder: (context, index) {
                            // Customers customer = filteredCustomers[index];
                            Customers customer = paginatedCustomers[index];
                            return CustomerTile(
                              customer: customer,
                              onView: () {
                                log(
                                  "customer id => ${customer.id}",
                                  name: "customer tile",
                                );
                                context.pushNamed(
                                  RoutesName.customerDetailScreen,
                                  extra: {
                                    'name': customer.name,
                                    'id': customer.id,
                                  },
                                );
                              },
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(
                          "Not Found",
                          style: TextStyle(
                            color: AppColor.primary.withValues(alpha: .7),
                            fontSize: AppDimens.textSize14,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),

              BlocBuilder<CustomerCubit, CustomerState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.first_page),
                        tooltip: 'First Page',
                        onPressed: currentPage > 1
                            ? () {
                                setState(() => currentPage = 1);
                                _scrollToTop();
                              }
                            : null,
                      ),
                      IconButton(
                        icon: Icon(Icons.chevron_left),
                        tooltip: 'Previous Page',
                        onPressed: currentPage > 1
                            ? () {
                                setState(() => currentPage--);
                                _scrollToTop();
                              }
                            : null,
                      ),
                      Text("Page $currentPage of $totalPages"),
                      IconButton(
                        icon: Icon(Icons.chevron_right),
                        tooltip: 'Next Page',
                        onPressed: currentPage < totalPages
                            ? () {
                                setState(() => currentPage++);
                                _scrollToTop();
                              }
                            : null,
                      ),
                      IconButton(
                        icon: Icon(Icons.last_page),
                        tooltip: 'Last Page',
                        onPressed: currentPage < totalPages
                            ? () {
                                setState(() => currentPage = totalPages);
                                _scrollToTop();
                              }
                            : null,
                      ),
                    ],
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }

  void _scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

}
