import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/routes/routes_name.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/data/model/customer_model.dart';
import 'package:joes_jwellery_crm/presentation/screens/customer/widget/customer_tile.dart';


class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  List<Customer> customers = [
    Customer(name: "James Joseph", id: "910946", store: "Joes 4"),
    Customer(name: "James Jos", id: "910947", store: "Joes 5"),
    Customer(name: "John Doe", id: "910948", store: "Joes 6"),
    Customer(name: "Jane Smith", id: "910949", store: "Joes 7"),
  ];

  List<Customer> filteredCustomers = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCustomers = customers;
  }

  void filterSearch(String query) {
    setState(() {
      filteredCustomers = customers.where((customer) {
        return customer.name.toLowerCase().contains(query.toLowerCase()) ||
            customer.id.contains(query) ||
            customer.store.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
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
          width: width*0.33,
          child: Text(
            "Customer",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppDimens.spacing18),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: AppColor.primary,), 
          onPressed: () {
            context.pop();
          }
        ),
        actions: [
          IconButton(
            icon: Image.asset(AssetsConstant.filterIcon, width: AppDimens.icon18, height: AppDimens.icon18, color: AppColor.primary), 
            onPressed: () {}
          ),
          IconButton(
            icon: Icon(Icons.add, size: AppDimens.icon25, color: AppColor.primary,), 
            onPressed: () {}
          )
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
                padding: EdgeInsets.all(width*0.04),
                child: TextField(
                  controller: searchController,
                  onChanged: filterSearch,
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
                    hintText: "Search for ID, Name, Store...",
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
              
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: filteredCustomers.length,
                  itemBuilder: (context, index) {
                    Customer customer = filteredCustomers[index];
                    return CustomerTile(
                      customer: customer,
                      onView: () {
                        log("customer id => ${customer.id}", name: "customer tile");
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
              ),
      
            ],
          ),
        ),
      ),
    );
  }
}
