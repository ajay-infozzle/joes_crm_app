import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';

class EmailTypeDropdown extends StatefulWidget {
  final List<EmailType> typeList;
  final Function(EmailType selectedType) onSelected;
  final EmailType? initialSelected; 

  const EmailTypeDropdown({
    super.key,
    required this.typeList,
    required this.onSelected,
    this.initialSelected,
  });

  @override
  State<EmailTypeDropdown> createState() => _EmailTypeDropdownState();
}

class _EmailTypeDropdownState extends State<EmailTypeDropdown> {
  late EmailType? selectedType;

  @override
  void initState() {
    super.initState();
    selectedType = widget.initialSelected;
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
      child: DropdownButton<EmailType>(
        isExpanded: true,
        underline: SizedBox(),
        icon: Icon(Icons.keyboard_arrow_down_rounded),
        hint: const Text("Select Type"),
        value: selectedType,
        items: widget.typeList.map((type) {
          return DropdownMenuItem<EmailType>(
            value: type,
            child: Text(type.type.capitalizeFirst()),
          );
        }).toList(),
        onChanged: (EmailType? value) {
          setState(() {
            selectedType = value;
          });
          if (value != null) {
            widget.onSelected(value);
          }
        },
      ),
    );
  }
}

class EmailType {
  final String type;
  final String value;

  EmailType({required this.type, required this.value});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmailType &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          value == other.value;

  @override
  int get hashCode => type.hashCode ^ value.hashCode;
}