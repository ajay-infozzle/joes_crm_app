import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';

class TitleDropdown extends StatefulWidget {
  final Function(TitleOption selected) onSelected;
  final TitleOption? initialSelected;

  const TitleDropdown({
    super.key,
    required this.onSelected,
    this.initialSelected,
  });

  @override
  State<TitleDropdown> createState() => _TitleDropdownState();
}

class _TitleDropdownState extends State<TitleDropdown> {
  late TitleOption? selectedOption;

  final List<TitleOption> options = [
    TitleOption(value: '', display: 'Select title'),
    TitleOption(value: 'mr', display: 'Mr'),
    TitleOption(value: 'ms', display: 'Ms'),
    TitleOption(value: 'miss', display: 'Miss'),
    TitleOption(value: 'mrs', display: 'Mrs'),
    TitleOption(value: 'dr', display: 'Dr'),
    TitleOption(value: 'prof', display: 'Prof'),
  ];

  @override
  void initState() {
    super.initState();
    selectedOption = widget.initialSelected;
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
      child: DropdownButton<TitleOption>(
        isExpanded: true,
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        hint: const Text("Select title"),
        value: selectedOption,
        items: options.map((option) {
          return DropdownMenuItem<TitleOption>(
            value: option,
            child: Text(option.display),
          );
        }).toList(),
        onChanged: (TitleOption? value) {
          setState(() {
            selectedOption = value;
          });
          if (value != null) {
            widget.onSelected(value);
          }
        },
      ),
    );
  }
}

class TitleOption {
  final String value;
  final String display;

  TitleOption({required this.value, required this.display});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TitleOption &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
