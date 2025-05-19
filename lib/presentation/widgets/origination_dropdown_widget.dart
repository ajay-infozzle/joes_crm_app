import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';

class OriginationDropdown extends StatefulWidget {
  final Function(OriginationOption selected) onSelected;
  final OriginationOption? initialSelected;

  const OriginationDropdown({
    super.key,
    required this.onSelected,
    this.initialSelected,
  });

  @override
  State<OriginationDropdown> createState() => _OriginationDropdownState();
}

class _OriginationDropdownState extends State<OriginationDropdown> {
  late OriginationOption? selectedOption;

  final List<OriginationOption> options = [
    OriginationOption(value: '', display: 'Select origination'),
    OriginationOption(value: 'ship', display: 'Ship'),
    OriginationOption(value: 'hotel', display: 'Hotel'),
    OriginationOption(value: 'mailchimp', display: 'Mailchimp'),
    OriginationOption(value: 'NotAvailable', display: 'Not Available'),
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
      child: DropdownButton<OriginationOption>(
        isExpanded: true,
        underline: SizedBox(),
        icon: Icon(Icons.keyboard_arrow_down_rounded),
        hint: const Text("Select origination"),
        value: selectedOption,
        items: options.map((option) {
          return DropdownMenuItem<OriginationOption>(
            value: option,
            child: Text(option.display),
          );
        }).toList(),
        onChanged: (OriginationOption? value) {
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

class OriginationOption {
  final String value;
  final String display;

  OriginationOption({required this.value, required this.display});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OriginationOption &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

