import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';

class FollowUpDropdown extends StatefulWidget {
  final Function(FollowUpOption selected) onSelected;
  final FollowUpOption? initialSelected;

  const FollowUpDropdown({
    super.key,
    required this.onSelected,
    this.initialSelected,
  });

  @override
  State<FollowUpDropdown> createState() => _FollowUpDropdownState();
}

class _FollowUpDropdownState extends State<FollowUpDropdown> {
  late FollowUpOption? selectedOption;

  final List<FollowUpOption> options = [
    FollowUpOption(value: '', display: 'Select result'),
    FollowUpOption(value: 'sold', display: 'Sold'),
    FollowUpOption(value: 'reschedule', display: 'Reschedule'),
    FollowUpOption(value: 'dead_pending', display: 'Dead Pending'),
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
      child: DropdownButton<FollowUpOption>(
        isExpanded: true,
        underline: SizedBox(),
        icon: Icon(Icons.keyboard_arrow_down_rounded),
        hint: const Text("Select result"),
        value: selectedOption,
        items: options.map((option) {
          return DropdownMenuItem<FollowUpOption>(
            value: option,
            child: Text(option.display),
          );
        }).toList(),
        onChanged: (FollowUpOption? value) {
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

class FollowUpOption {
  final String value;
  final String display;

  FollowUpOption({required this.value, required this.display});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FollowUpOption &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

