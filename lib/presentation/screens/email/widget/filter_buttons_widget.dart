import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';

class FilterButtonsWidget extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterSelected;

  const FilterButtonsWidget({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildButton(
            label: 'All Email',
            iconPath: AssetsConstant.emailIcon,
          ),
          const SizedBox(width: 10),
          _buildButton(
            label: 'Important',
            iconPath: AssetsConstant.starIcon,
          ),
          const SizedBox(width: 10),
          _buildButton(
            label: 'Unread',
            iconPath: AssetsConstant.emailUnreadIcon,
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }

  Widget _buildButton({required String label, required String iconPath}) {
    bool isSelected = label == selectedFilter;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? AppColor.primary : AppColor.greenishGrey,
        foregroundColor: isSelected ? AppColor.white : AppColor.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radius12), 
        ),
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacing15, vertical: AppDimens.spacing10),
        elevation: 0,
      ),
      onPressed: () => onFilterSelected(label),
      child: Row(
        children: [
          Image.asset(
            iconPath,
            width: AppDimens.icon18,
            height: AppDimens.icon18,
            color: isSelected ? AppColor.white : AppColor.primary,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: AppDimens.textSize14,
              fontWeight: FontWeight.w500,
              color: isSelected ? AppColor.white : AppColor.primary,
            ),
          ),
        ],
      ),
    );
  }
}
