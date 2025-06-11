import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/routes/routes_name.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/api_constant.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/core/utils/date_formatter.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/core/utils/helpers.dart';
import 'package:joes_jwellery_crm/data/model/store_list_model.dart';
import 'package:joes_jwellery_crm/presentation/bloc/home/home_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/wishlist/wishlist_cubit.dart';
import 'package:joes_jwellery_crm/presentation/widgets/retry_widget.dart';

class SingleWishScreen extends StatefulWidget {
  final String wishId;
  const SingleWishScreen({super.key, required this.wishId});

  @override
  State<SingleWishScreen> createState() => _SingleWishScreenState();
}

class _SingleWishScreenState extends State<SingleWishScreen> {

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

    context.read<WishlistCubit>().fetchSingleWish(wishId: widget.wishId);
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
            "View Wish",
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
              if (value == 'edit') {
                context.pushNamed(RoutesName.editWishScreen, extra: context.read<WishlistCubit>().currentWish);
              } 
            },
            itemBuilder:(BuildContext context) => [
              PopupMenuItem<String>(
                value: 'edit',
                child: Row(
                  children: [
                    Image.asset(
                      AssetsConstant.editIcon,
                      width: AppDimens.spacing15,
                      height: AppDimens.spacing15,
                      color: AppColor.primary,
                    ),
                    5.w,
                    Text('Edit'),
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
          child: BlocConsumer<WishlistCubit, WishlistState>(
            listener: (context, state) {
              // if(state is LeadsPhotoError ){
              //   showAppSnackBar(context, message: state.message, backgroundColor: AppColor.red);
              // }
              // if(state is LeadsEmailSentError){
              //   showAppSnackBar(context, message: state.message, backgroundColor: AppColor.red);
              // }
            },
            builder: (context, state) {
              WishlistCubit wishlistCubit = context.read<WishlistCubit>();

              if (state is WishlistLoading ) {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(color: AppColor.primary),
                  ),
                );
              } else if (state is WishlistError) {
                return Expanded(
                  child: RetryWidget(
                    onTap: () async {
                      wishlistCubit.fetchSingleWish(wishId: widget.wishId);
                    },
                  ),
                );
              } else if (wishlistCubit.currentWish != null) {
                String assocs = wishlistCubit.currentWish?.salesAssociates
                ?.map((e) => e.name?.capitalizeFirst())
                .join(', ') ?? '_';

                final creationDateTime = formatDateTime(wishlistCubit.currentWish?.creationDate??"");

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
                          wishlistCubit.fetchSingleWish(wishId: widget.wishId);
                        },
                        child: Column(
                          children: [

                            Container(
                              height: 200,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                color: AppColor.primary.withValues(alpha: .1),
                              ),
                              child: Image.network(
                                wishlistCubit.currentWish!.photo != null && wishlistCubit.currentWish!.photo!.isNotEmpty
                                    ? "${ApiConstant.demoBaseUrl}${wishlistCubit.currentWish!.photo}"
                                    : "",
                                // height: 100,
                                // width: 100,
                                fit: BoxFit.cover,
                                // loadingBuilder: (context, child, loadingProgress) => Container(color: AppColor.greenishGrey.withValues(alpha: .5),),
                                errorBuilder: (context, error, stackTrace) => Container(color: AppColor.primary.withValues(alpha: .04),),
                              ),
                            ),
                            10.h,

                            contentRow(
                              title: "Product",
                              data: wishlistCubit.currentWish?.product ?? "_",
                            ),
                            10.h,
                    
                            contentRow(
                              title: "Store",
                              data: "_",
                              // data: getStore(context, wishlistCubit.currentWish?.store ?? "_"),
                            ),
                            10.h,
                    
                            contentRow(
                              title: "Sales associate(s)",
                              data: assocs,
                            ),
                            10.h,

                            contentRow(
                              title: "Sales associate 2",
                              data: getUser(context, wishlistCubit.currentWish?.salesAssoc2 ?? "_"),
                            ),
                            10.h,
                    
                            contentRow(
                              title: "Follow-up date",
                              data: wishlistCubit.currentWish?.followDate ?? "_"
                            ),
                            10.h,
                    
                            contentRow(
                              title: "Amount",
                              data: "\$ ${wishlistCubit.currentWish?.price}"
                            ),
                            10.h,
                    
                            contentRow(
                              title: "Created By",
                              data: "${getUserName(wishlistCubit.currentWish?.createdBy ?? "_",)} - ${creationDateTime['date']!} ${creationDateTime['time']!}",
                            ),
                            10.h,
                    
                            if(wishlistCubit.currentWish?.customer != "0") 
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    context.pushNamed(
                                      RoutesName.customerDetailScreen,
                                      extra: {
                                        'name': "",
                                        'id': wishlistCubit.currentWish?.customer,
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