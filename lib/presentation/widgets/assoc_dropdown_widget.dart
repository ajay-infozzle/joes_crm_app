import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/data/model/assoc_list_model.dart';

class AssocDropdown extends StatefulWidget {
  final List<Users> usersList;
  final Function(Users selectedUser) onSelected;
  final String title ;
  final Users? initialSelected; 

  const AssocDropdown({
    super.key,
    required this.usersList,
    required this.onSelected,
    this.title ="Select sales assoc" ,
    this.initialSelected,
  });

  @override
  State<AssocDropdown> createState() => _AssocDropdownState();
}

class _AssocDropdownState extends State<AssocDropdown> {
  late Users? selectedUser;

  @override
  void initState() {
    super.initState();
    selectedUser = widget.initialSelected;
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
      child: DropdownButton<Users>(
        isExpanded: true,
        underline: SizedBox(),
        icon: Icon(Icons.keyboard_arrow_down_rounded),
        hint: Text(widget.title),
        value: selectedUser,
        items: widget.usersList.map((user) {
          return DropdownMenuItem<Users>(
            value: user,
            child: Text(user.name ?? 'Unnamed'),
          );
        }).toList(),
        onChanged: (Users? value) {
          setState(() {
            selectedUser = value;
          });
          if (value != null) {
            widget.onSelected(value);
          }
        },
      ),
    );
  }
}
