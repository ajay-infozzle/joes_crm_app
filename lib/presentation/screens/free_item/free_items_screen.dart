import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/routes/routes_name.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/data/model/free_item_list_model.dart';
import 'package:joes_jwellery_crm/presentation/bloc/free_item/free_item_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/free_item/widget/free_item_tile.dart';
import 'package:joes_jwellery_crm/presentation/widgets/confirmation_dialog.dart';
import 'package:joes_jwellery_crm/presentation/widgets/retry_widget.dart';

class FreeItemsScreen extends StatefulWidget {
  const FreeItemsScreen({super.key});

  @override
  State<FreeItemsScreen> createState() => _FreeItemsScreenState();
}

class _FreeItemsScreenState extends State<FreeItemsScreen> {
  final TextEditingController searchController = TextEditingController();
  List<Freeitems> filteredItems = [];


  @override
  void initState() {
    super.initState();
    context.read<FreeItemCubit>().fetchAllItems().then((_) {
      setState(() {
        filteredItems = List.from(context.read<FreeItemCubit>().allItems);
      });
    });
  }

  void filterSearch(String query) {
    final allItems = context.read<FreeItemCubit>().allItems;

    final lowerQuery = query.toLowerCase();

    setState(() {
      filteredItems = allItems.where((item) {
        final name = (item.name ?? '').toLowerCase();
        final surname = (item.surname ?? '').toLowerCase();
        final email = (item.email ?? '').toLowerCase();

        return email.contains(lowerQuery) ||
            surname.contains(lowerQuery) ||
            name.contains(lowerQuery);
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
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.white,
        title: SizedBox(
          child: Text(
            "Free Items",
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
          IconButton(
            icon: Icon(
              Icons.add,
              size: AppDimens.icon25,
              color: AppColor.primary,
            ),
            onPressed: () {
              context.pushNamed(RoutesName.addFreeItemScreen);
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
                    hintText: "name, surname, email",
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
                child: BlocConsumer<FreeItemCubit, FreeItemState>(
                  listener: (context, state) {
                    if(state is FreeItemsLoaded){
                      setState(() {
                        filteredItems = List.from(context.read<FreeItemCubit>().allItems);
                      });
                    }
                  },
                  builder: (context, state) {
                    FreeItemCubit freeItemCubit = context.read<FreeItemCubit>();

                    if (state is FreeItemsLoading) {
                      return Center(child: CircularProgressIndicator(color: AppColor.primary));
                    }
                    else if (state is FreeItemsError) {
                      return RetryWidget(
                        onTap: () async{
                          context.read<FreeItemCubit>().fetchAllItems();
                        },
                      );
                    }
                    else if (freeItemCubit.allItems.isNotEmpty) {
                      return RefreshIndicator(
                        color: AppColor.primary,
                        onRefresh: () async {
                          freeItemCubit.fetchAllItems();
                        },
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimens.spacing15,
                            vertical: AppDimens.spacing8,
                          ),
                          itemCount: filteredItems.length,
                          itemBuilder: (context, index) {
                            return FreeItemTile(
                              item: filteredItems[index], 
                              onDelete: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => ConfirmationDialog(
                                    title: "Confirm Deletion",
                                    message: "Are you sure you want to delete this item?",
                                    confirmText: "Delete",
                                    confirmColor: Colors.red,
                                    onConfirmed: () {
                                      freeItemCubit.deleteItem(id: filteredItems[index].id??"");
                                    },
                                  ),
                                );
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}