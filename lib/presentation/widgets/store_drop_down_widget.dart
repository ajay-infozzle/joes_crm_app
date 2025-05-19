import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/data/model/store_list_model.dart';

class StoreDropdown extends StatefulWidget {
  final List<Stores> storeList;
  final Function(Stores selectedStore) onSelected;
  final Stores? initialSelected; 

  const StoreDropdown({
    super.key,
    required this.storeList,
    required this.onSelected,
    this.initialSelected,
  });

  @override
  State<StoreDropdown> createState() => _StoreDropdownState();
}

class _StoreDropdownState extends State<StoreDropdown> {
  late Stores? selectedStore;

  @override
  void initState() {
    super.initState();
    selectedStore = widget.initialSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimens.spacing50,
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
      decoration: BoxDecoration(
        color: AppColor.greenishGrey.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(AppDimens.radius16),
        boxShadow: [
          BoxShadow(
            color: AppColor.greenishGrey.withValues(alpha: 0.4),
            offset: const Offset(0, 2),
            blurRadius: 1,
          ),
        ],
      ),
      child: DropdownButton<Stores>(
        isExpanded: true,
        underline: SizedBox(),
        icon: Icon(Icons.keyboard_arrow_down_rounded),
        hint: const Text("Select a store"),
        value: selectedStore,
        items: widget.storeList.map((store) {
          return DropdownMenuItem<Stores>(
            value: store,
            child: Text(store.name ?? 'Unnamed'),
          );
        }).toList(),
        onChanged: (Stores? value) {
          setState(() {
            selectedStore = value;
          });
          if (value != null) {
            widget.onSelected(value);
          }
        },
      ),
    );
  }
}
