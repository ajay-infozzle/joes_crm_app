
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/routes/routes_name.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/presentation/screens/email/widget/email_list_item_widget.dart';
import 'package:joes_jwellery_crm/presentation/screens/email/widget/filter_buttons_widget.dart';

class EmailListScreen extends StatefulWidget {
  const EmailListScreen({super.key});

  @override
  State<EmailListScreen> createState() => _EmailListScreenState();
}

class _EmailListScreenState extends State<EmailListScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> allEmails = [
    {
      "sender": "Jovita P",
      "subject": "Lorem Ipsum",
      "message": "Lorem ipsum is dummy text.\nLorem ipsum is dummy text. Lorem ipsum is dummy text, Lorem ipsum is dummy text.\n\nThanks & Regards\nLorem",
      "date": "21 Sep",
      "isImportant": true,
      "isUnread": true,
    },
    {
      "sender": "Alex D",
      "subject": "Meeting Reminder",
      "message": "Reminder for tomorrow's meeting. Lorem ipsum is dummy text.\nLorem ipsum is dummy text. Lorem ipsum is dummy text, Lorem ipsum is dummy text.\n\nThanks & Regards\nLorem",
      "date": "20 Sep",
      "info": "to Jackson, Tom, me",
      "isImportant": false,
      "isUnread": true,
    },
    {
      "sender": "Mark S",
      "subject": "Offer Inside!",
      "message": "Big discounts this week. Lorem ipsum is dummy text.\nLorem ipsum is dummy text. Lorem ipsum is dummy text, Lorem ipsum is dummy text.\n\nThanks & Regards\nLorem",
      "date": "19 Sep",
      "isImportant": true,
      "isUnread": false,
    },
    {
      'sender': 'John De',
      'subject': 'Your Order has been shipped!',
      'message': 'We are excited to let you know that your package...\n\nThanks & Regards\nLorem',
      'date': 'Apr 1',
      'isImportant': true,
      'isUnread': true,
    }
  ];

  String selectedFilter = 'All Email';
  List<Map<String, dynamic>> filteredEmails = [];

  @override
  void initState() {
    super.initState();
    filteredEmails = List.from(allEmails);
  }

  void _filterEmails(String query) {
    List<Map<String, dynamic>> result = [];

    if (query.isEmpty) {
      result = _applyFilter(selectedFilter);
    } else {
      result = allEmails.where((email) {
        return email['sender'].toLowerCase().contains(query.toLowerCase()) ||
            email['subject'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    setState(() {
      filteredEmails = result;
    });
  }

  List<Map<String, dynamic>> _applyFilter(String filter) {
    switch (filter) {
      case 'Important':
        return allEmails.where((email) => email['isImportant'] == true).toList();
      case 'Unread':
        return allEmails.where((email) => email['isUnread'] == true).toList();
      case 'All Email':
      default:
        return List.from(allEmails);
    }
  }

  void _onFilterSelected(String filter) {
    setState(() {
      selectedFilter = filter;
      filteredEmails = _applyFilter(filter);
      _searchController.clear(); 
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.greenishGrey,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.white,
        title: SizedBox(
          width: width * 0.33,
          child: Image.asset(
            AssetsConstant.joesLogo,
            fit: BoxFit.contain,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: AppColor.primary),
          onPressed: () {},
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          color: AppColor.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //~ Search Bar
              Padding(
                padding: EdgeInsets.all(width * 0.04),
                child: TextField(
                  controller: _searchController,
                  onChanged: _filterEmails,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacing15),
                      child: SizedBox(
                        width: AppDimens.icon13,
                        height: AppDimens.icon13,
                        child: Image.asset(
                          AssetsConstant.searchIcon,
                          color: AppColor.primary.withValues(alpha:0.8),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    hintText: "Search",
                    hintStyle: TextStyle(color: AppColor.primary..withValues(alpha:0.8)),
                    filled: true,
                    fillColor: AppColor.greenishGrey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppDimens.radius12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: AppDimens.spacing5),
                  ),
                  cursorColor: AppColor.primary,
                ),
              ),

              //~ Filter Buttons
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: FilterButtonsWidget(
                  selectedFilter: selectedFilter,
                  onFilterSelected: _onFilterSelected,
                ),
              ),

             10.h,

              //~ Email List
              Expanded(
                child: ListView.builder(
                  itemCount: filteredEmails.length,
                  itemBuilder: (context, index) {
                    final email = filteredEmails[index];
                    return EmailListItemWidget(
                      email: email,
                      ontap: () {
                        context.pushNamed(
                          RoutesName.emailThreadScreen,
                          extra: [email, email]
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
