import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/presentation/widgets/chat_tile.dart';

class WhatsappChatListScreen extends StatefulWidget {
  const WhatsappChatListScreen({super.key});

  @override
  State<WhatsappChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<WhatsappChatListScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> chats = [
    {
      "name": "James Joseph",
      "lastMessage": "Lorem Ipsum is a dummy text",
      "time": "02:45",
      "unreadCount": 1,
      "profileImage": "",
    },
    {
      "name": "James Joseph",
      "lastMessage": "Lorem Ipsum is a dummy text Lorem ipsum is a dummy..",
      "time": "02:45",
      "unreadCount": 0,
      "profileImage": "",
    },
    {
      "name": "James Joseph",
      "lastMessage": "message deleted",
      "time": "02:45",
      "unreadCount": 2,
      "profileImage": "",
    },
  ];

  List<Map<String, dynamic>> filteredChats = [];

  @override
  void initState() {
    super.initState();
    filteredChats = chats;
  }

  void _filterChats(String query) {
    setState(() {
      filteredChats = chats
          .where((chat) => chat["name"].toLowerCase().contains(query.toLowerCase()))
          .toList();
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
            children: [
              Padding(
                padding: EdgeInsets.all(width*0.04),
                child: TextField(
                  controller: _searchController,
                  onChanged: _filterChats,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppDimens.spacing15),
                      child: SizedBox(
                        width: AppDimens.icon13, 
                        height: AppDimens.icon13,
                        child: Image.asset(
                          AssetsConstant.searchIcon, 
                          color: AppColor.primary.withValues(alpha: .8),
                          fit: BoxFit.contain,
                        )
                      ),
                    ),
                    hintText: "Search",
                    hintStyle: TextStyle(color: AppColor.primary.withValues(alpha: .8)),
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

              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(width*0.04),
                  child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemCount: filteredChats.length,
                    itemBuilder: (context, index) {
                      final chat = filteredChats[index];
                      return ChatTile(
                        name: chat["name"],
                        lastMessage: chat["lastMessage"],
                        time: chat["time"],
                        unreadCount: chat["unreadCount"],
                        profileImage: chat["profileImage"],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
