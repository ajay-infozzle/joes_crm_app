import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';

class LeadsStatusDropdown extends StatefulWidget {
  final Function(LeadsStatusOption selected) onSelected;
  final LeadsStatusOption? initialSelected;

  const LeadsStatusDropdown({
    super.key,
    required this.onSelected,
    this.initialSelected,
  });

  @override
  State<LeadsStatusDropdown> createState() => _LeadsStatusDropdownState();
}

class _LeadsStatusDropdownState extends State<LeadsStatusDropdown> {
  late LeadsStatusOption? selectedOption;

  final List<LeadsStatusOption> options = [
    LeadsStatusOption(value: '', display: 'Select Status'),
    LeadsStatusOption(value: 'pending', display: 'Pending'),
    LeadsStatusOption(value: 'sale_pending', display: 'Sale Pending'),
    LeadsStatusOption(value: 'sold', display: 'Sold'),
    LeadsStatusOption(value: 'converted', display: 'Converted'),
    LeadsStatusOption(value: 'dead', display: 'Dead')
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
      child: DropdownButton<LeadsStatusOption>(
        isExpanded: true,
        underline: SizedBox(),
        icon: Icon(Icons.keyboard_arrow_down_rounded),
        hint: const Text("Select status"),
        value: selectedOption,
        items: options.map((option) {
          return DropdownMenuItem<LeadsStatusOption>(
            value: option,
            child: Text(option.display),
          );
        }).toList(),
        onChanged: (LeadsStatusOption? value) {
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

class LeadsStatusOption {
  final String value;
  final String display;

  LeadsStatusOption({required this.value, required this.display});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeadsStatusOption &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

