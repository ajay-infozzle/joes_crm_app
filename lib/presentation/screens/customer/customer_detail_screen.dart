import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/presentation/screens/customer/widget/customer_header.dart';
import 'package:joes_jwellery_crm/presentation/screens/customer/widget/expandable_section.dart';

class CustomerDetailScreen extends StatefulWidget {
  final String name;
  final String id;
  const CustomerDetailScreen({super.key, required this.name, required this.id});

  @override
  State<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.greenishGrey,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: AppColor.primary, size: AppDimens.spacing20,), 
          onPressed: () {
            context.pop();
          }
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert, color: AppColor.primary, size: AppDimens.spacing20,)),
        ],
        elevation: 0,
      ),

      body: SafeArea(
        child: Container(
          width: width,
          color: AppColor.white,
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: width*0.05, vertical: width*0.05),
                child: CustomerHeader(name: widget.name),
              ),

              15.h,

              Container(
                margin: EdgeInsets.symmetric(horizontal: width*0.05),
                child: ExpandableSection(
                  title: "Basic Details",
                  content: {
                    "ID": "910968",
                    "Name": "David-Berland",
                    "Email": "lorem ipsum",
                    "Country": "lorem ipsum",
                    "Store": "lorem ipsum",
                    "Contact Number": "lorem ipsum",
                    "Birthday": "lorem ipsum",
                    "Anniversary": "lorem ipsum",
                  },
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: width*0.05),
                child: ExpandableSection(
                  title: "Sales",
                  content: {
                    "Sale Date": "910968",
                    "Store": "David-Berland",
                    "Amount": "lorem ipsum",
                    "Sales Associate(s)": "lorem ipsum",
                    "Total Sales": "lorem ipsum",
                    "Last Sale Date": "lorem ipsum",
                  },
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: width*0.05),
                child: const ExpandableSection(
                  title: "SMS Log",
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: width*0.05),
                child: const ExpandableSection(
                  title: "Activity Stream",
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: width*0.05),
                child: const ExpandableSection(
                  title: "Wish List",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}