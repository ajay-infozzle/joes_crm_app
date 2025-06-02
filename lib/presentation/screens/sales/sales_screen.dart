import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/data/model/sales_list_model.dart';
import 'package:joes_jwellery_crm/presentation/bloc/sale/sale_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/sales/widget/sales_tile.dart';
import 'package:joes_jwellery_crm/presentation/widgets/retry_widget.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final TextEditingController searchController = TextEditingController();
  List<Sales> filteredSales = [];

  @override
  void initState() {
    super.initState();

    context.read<SaleCubit>().fetchAllSales().then((_) {
      setState(() {
        filteredSales = List.from(context.read<SaleCubit>().allSalesList);
      });
    });
  }

  void filterSearch(String query) {
    final allSales = context.read<SaleCubit>().allSalesList;

    final lowerQuery = query.toLowerCase();

    setState(() {
      filteredSales = allSales.where((sale) {
        final id = (sale.id ?? '').toLowerCase();
        final customer = (sale.customerId ?? '').toLowerCase();
        final date = (sale.saleDate ?? '').toLowerCase();

        return id.contains(lowerQuery) ||
            customer.contains(lowerQuery) ||
            date.contains(lowerQuery);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.greenishGrey,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.white,
        title: Text(
          "Sales",
          style: TextStyle(
            fontSize: AppDimens.textSize20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Container(
          width: width,
          color: AppColor.white,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(width * 0.04),
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
                    hintText: "Search id, date",
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

              Expanded(
                child: BlocConsumer<SaleCubit, SaleState>(
                  listener: (context, state) {
                    
                  },
                  builder: (context, state) {
                    SaleCubit saleCubit = context.read<SaleCubit>();

                    if (state is SaleListLoading) {
                      return Center(child: CircularProgressIndicator(color: AppColor.primary));
                    }
                    else if (state is SaleListError) {
                      return RetryWidget(
                        onTap: () async{
                          saleCubit.fetchAllSales();
                        },
                      );
                    }
                    else if (saleCubit.allSalesList.isNotEmpty) {
                      return RefreshIndicator(
                        color: AppColor.primary,
                        onRefresh: () async {
                          saleCubit.fetchAllSales();
                        },
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimens.spacing15,
                            vertical: AppDimens.spacing8,
                          ),
                          itemCount: filteredSales.length,
                          itemBuilder: (context, index) {
                            return SalesTile(sales: filteredSales[index]);
                          },
                        ),
                      );
                    }
                    else {
                      return SizedBox();
                    }
                  },
                ) ,
              ),
            ],
          ),
        ) 
      ),
    );
  }
}