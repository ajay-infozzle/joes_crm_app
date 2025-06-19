import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/data/model/email_templates_model.dart';

class EmailTemplDropdown extends StatefulWidget {
  final List<Emailtpls> templateList;
  final Function(Emailtpls selectedTemplate) onSelected;
  final String title ;
  final Emailtpls? initialSelected; 

  const EmailTemplDropdown({
    super.key,
    required this.templateList,
    required this.onSelected,
    this.title ="Select email template" ,
    this.initialSelected,
  });

  @override
  State<EmailTemplDropdown> createState() => _EmailTemplDropdownState();
}

class _EmailTemplDropdownState extends State<EmailTemplDropdown> {
  late Emailtpls? selectedTemplate;

  @override
  void initState() {
    super.initState();
    selectedTemplate = widget.initialSelected;
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
      child: DropdownButton<Emailtpls>(
        isExpanded: true,
        underline: SizedBox(),
        icon: Icon(Icons.keyboard_arrow_down_rounded),
        hint: Text(widget.title),
        value: selectedTemplate,
        items: widget.templateList.map((template) {
          return DropdownMenuItem<Emailtpls>(
            value: template,
            child: Text(template.title ?? ''),
          );
        }).toList(),
        onChanged: (Emailtpls? value) {
          setState(() {
            selectedTemplate = value;
          });
          if (value != null) {
            widget.onSelected(value);
          }
        },
      ),
    );
  }
}
