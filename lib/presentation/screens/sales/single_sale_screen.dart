import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/routes/routes_name.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/core/utils/date_formatter.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/data/model/store_list_model.dart';
import 'package:joes_jwellery_crm/presentation/bloc/home/home_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/sale/sale_cubit.dart';
import 'package:joes_jwellery_crm/presentation/widgets/retry_widget.dart';

class SingleSaleScreen extends StatefulWidget {
  final String saleId;
  const SingleSaleScreen({super.key, required this.saleId});

  @override
  State<SingleSaleScreen> createState() => _SingleSaleScreenState();
}

class _SingleSaleScreenState extends State<SingleSaleScreen> {

  String getUserName(String userId) {
    String name = "_";
    context.read<HomeCubit>().usersList.forEach((e) {
      if (userId == e.id) {
        name = e.name ?? "_";
      }
    });
    return name.toLowerCase().capitalizeFirst();
  }

  String getStore(BuildContext context, String storeId){
    final store = context.read<HomeCubit>().storeList.firstWhere(
      (e) => e.id == storeId,
      orElse: () => Stores(id: storeId, name: '_'),
    );

    return store.name ?? '_' ;
  }

  @override
  void initState() {
    super.initState();

    context.read<SaleCubit>().fetchSale(saleId: widget.saleId);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.white,
        title: SizedBox(
          child: Text(
            "View Sale",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppDimens.spacing18,
            ),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColor.primary,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        actions: [
          PopupMenuButton<String>(
            color: AppColor.white,
            icon: const Icon(
              Icons.more_vert,
              color: AppColor.primary,
              size: AppDimens.spacing20,
            ),
            onSelected: (value) {
              if (value == 'receipt_pdf') {
                // onTakePhotoSelected(context: context);
              } 
            },
            itemBuilder:(BuildContext context) => [
              PopupMenuItem<String>(
                value: 'receipt_pdf',
                child: Row(
                  children: [
                    Image.asset(
                      AssetsConstant.cameraIcon,
                      width: AppDimens.spacing15,
                      height: AppDimens.spacing15,
                      color: AppColor.primary,
                    ),
                    5.w,
                    Text('Receipt PDF'),
                  ],
                ),
              ),
            ],
          ),
        ],
        elevation: 0,
      ),

      body: SafeArea(
        child: Container(
          width: width,
          color: AppColor.white,
          child: BlocConsumer<SaleCubit, SaleState>(
            listener: (context, state) {
              // if(state is LeadsPhotoError ){
              //   showAppSnackBar(context, message: state.message, backgroundColor: AppColor.red);
              // }
              // if(state is LeadsEmailSentError){
              //   showAppSnackBar(context, message: state.message, backgroundColor: AppColor.red);
              // }
            },
            builder: (context, state) {
              SaleCubit saleCubit = context.read<SaleCubit>();

              if (state is SaleLoading ) {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(color: AppColor.primary),
                  ),
                );
              } else if (state is SaleError) {
                return Expanded(
                  child: RetryWidget(
                    onTap: () async {
                      context.read<SaleCubit>().fetchSale(saleId: widget.saleId);
                    },
                  ),
                );
              } else if (saleCubit.currentSale != null) {
                String assocs = saleCubit.currentSale?.salesAssociates
                ?.map((e) => e.name?.capitalizeFirst())
                .join(', ') ?? '_';

                final creationDateTime = formatDateTime(saleCubit.currentSale?.creationDate??"");

                return ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(AppDimens.spacing10),
                      padding: const EdgeInsets.all(AppDimens.spacing10),
                      decoration: BoxDecoration(
                        color: AppColor.greenishGrey.withValues(alpha: .2),
                        borderRadius: BorderRadius.circular(AppDimens.radius12),
                      ),
                      child: RefreshIndicator(
                        color: AppColor.primary,
                        onRefresh: () async {
                          context.read<SaleCubit>().fetchSale(saleId: widget.saleId);
                        },
                        child: Column(
                          children: [
                            contentRow(
                              title: "Id",
                              data: saleCubit.currentSale?.id ?? "_",
                            ),
                            10.h,
                    
                            contentRow(
                              title: "Customer Id",
                              data: saleCubit.currentSale?.customerId ?? "_",
                            ),
                            10.h,
                    
                            contentRow(
                              title: "Store",
                              data: getStore(context, saleCubit.currentSale?.storeId ?? "_"),
                            ),
                            10.h,
                    
                            contentRow(
                              title: "Sales associate(s)",
                              data: assocs,
                            ),
                            10.h,
                    
                            contentRow(
                              title: "Sale date",
                              data: saleCubit.currentSale?.saleDate ?? "_"
                            ),
                            10.h,
                    
                            contentRow(
                              title: "Amount",
                              data: "\$ ${saleCubit.currentSale?.amount}"
                            ),
                            10.h,
                    
                            contentRow(
                              title: "Created By",
                              data: "${getUserName(saleCubit.currentSale?.createdBy ?? "_",)} - ${creationDateTime['date']!} ${creationDateTime['time']!}",
                            ),
                            10.h,
                    
                            if(saleCubit.currentSale?.customerId != "0") //i.e for existing customer
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    
                                  },
                                  child: Text(
                                    "View Receipt",
                                    style: const TextStyle(
                                      fontSize: AppDimens.textSize14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.greenishBlue,
                                    ),
                                    softWrap: true,
                                  ),
                                ),

                                10.w,

                                TextButton(
                                  onPressed: () {
                                    context.pushNamed(
                                      RoutesName.customerDetailScreen,
                                      extra: {
                                        'name': "",
                                        'id': saleCubit.currentSale?.customerId,
                                      },
                                    );
                                  },
                                  child: Text(
                                    "View Customer",
                                    style: const TextStyle(
                                      fontSize: AppDimens.textSize14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.greenishBlue,
                                    ),
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                            
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }

              return SizedBox();
            },
          ),
        ) 
      ),
    );
  }

  Widget contentRow({required String title, required String data}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title :",
          style: const TextStyle(
            fontSize: AppDimens.textSize14,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppDimens.spacing8.w,
        Expanded(
          child: Text(
            data,
            style: const TextStyle(fontSize: AppDimens.textSize14),
            softWrap: true,
          ),
        ),
      ],
    );
  }

}