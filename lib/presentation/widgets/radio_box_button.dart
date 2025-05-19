import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';


class RadioBoxButton extends StatelessWidget {
  final String text;
  final String groupValue;
  final String value;
  final ValueChanged<String?> onChanged;

  const RadioBoxButton({
    super.key,
    required this.text,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.width;
    final bool isSelected = value == groupValue;

    return GestureDetector(
      onTap: () {
        onChanged(value);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size * 0.02, vertical: size * 0.01),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.backgroundColor.withValues(alpha:0.1) : Colors.transparent,
          border: Border.all(
            color: isSelected ? AppColor.backgroundColor: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                color: isSelected ? AppColor.backgroundColor : Colors.black.withValues(alpha:.66),
                fontSize: null,
                fontWeight: isSelected ? FontWeight.bold : null
              ),
            ),
          ],
        ),
      ),
    );
  }
}
