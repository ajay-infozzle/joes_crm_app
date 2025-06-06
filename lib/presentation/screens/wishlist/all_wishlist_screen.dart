import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/routes/routes_name.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/data/model/all_wishlist_model.dart';
import 'package:joes_jwellery_crm/presentation/bloc/wishlist/wishlist_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/wishlist/widget/wishlist_tile.dart';
import 'package:joes_jwellery_crm/presentation/widgets/retry_widget.dart';

class AllWishlistScreen extends StatefulWidget {
  const AllWishlistScreen({super.key});

  @override
  State<AllWishlistScreen> createState() => _AllWishlistScreenState();
}

class _AllWishlistScreenState extends State<AllWishlistScreen> {
  final TextEditingController searchController = TextEditingController();
  List<Wishlist> filteredItems = [];

  @override
  void initState() {
    super.initState();
    context.read<WishlistCubit>().fetchAllWishlist().then((_) {
      setState(() {
        filteredItems = List.from(context.read<WishlistCubit>().wishlist);
      });
    });
  }

  void filterSearch(String query) {
    final allItems = context.read<WishlistCubit>().wishlist;

    final lowerQuery = query.toLowerCase();

    setState(() {
      filteredItems = allItems.where((item) {
        final name = (item.customer ?? '').toLowerCase();
        final surname = (item.product ?? '').toLowerCase();
        final followDate = (item.followDate ?? '').toLowerCase();

        return followDate.contains(lowerQuery) ||
            surname.contains(lowerQuery) ||
            name.contains(lowerQuery);
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
          child: Text(
            "Wishlist",
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
                    hintText: "product, customer name",
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
                child: BlocConsumer<WishlistCubit, WishlistState>(
                  listener: (context, state) {
                    
                  },
                  builder: (context, state) {
                    WishlistCubit wishlistCubit = context.read<WishlistCubit>();

                    if (state is WishlistLoading) {
                      return Center(child: CircularProgressIndicator(color: AppColor.primary));
                    }
                    else if (state is WishlistError) {
                      return RetryWidget(
                        onTap: () async{
                          wishlistCubit.fetchAllWishlist();
                        },
                      );
                    }
                    else if (wishlistCubit.wishlist.isNotEmpty) {
                      return RefreshIndicator(
                        color: AppColor.primary,
                        onRefresh: () async {
                          wishlistCubit.fetchAllWishlist();
                        },
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimens.spacing15,
                            vertical: AppDimens.spacing8,
                          ),
                          itemCount: filteredItems.length,
                          itemBuilder: (context, index) {
                            return WishlistTile(
                              wish: filteredItems[index], 
                              onView: () {
                                context.pushNamed(RoutesName.singleWishScreen, extra: filteredItems[index].id);
                              },
                            );
                          },
                        ),
                      );
                    }
                    else {
                      return SizedBox();
                    }
                  },
                ) 
              )
            ],
          ),
        ) 
      ),
      
    );
  }
}