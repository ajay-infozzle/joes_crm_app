import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/routes/routes_name.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/data/model/task_list_model.dart';
import 'package:joes_jwellery_crm/presentation/bloc/home/home_cubit.dart';


class TaskListWidget extends StatelessWidget {
  final Tasks tasks ;
  const TaskListWidget({super.key, required this.tasks});

  String getAssignedTo(String id, BuildContext context){
    try {
      final user = context.read<HomeCubit>().usersList.firstWhere((element) => element.id == id,);
      return user.name ?? "" ;
    } catch (e) {
      return "_" ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimens.spacing12),
      decoration: BoxDecoration(
        color: AppColor.greenishGrey.withValues(alpha: .8),
        borderRadius: BorderRadius.circular(AppDimens.radius12),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppDimens.spacing8, horizontal: AppDimens.spacing8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Status : ${tasks.completed == '0' ? "Completed" : "Pending"}", style: const TextStyle(fontSize: AppDimens.textSize14,fontWeight: FontWeight.bold)),
                    AppDimens.spacing8.w,
          
                    // const Text("|", style: TextStyle(color: Colors.grey)),
          
                    // AppDimens.spacing8.w,
                    // Text("Store : ${leads.store}", style: const TextStyle(fontSize: AppDimens.textSize14,fontWeight: FontWeight.bold)),
                  ],
                ),
                5.h,
          
                Text(
                  "Title : ${tasks.title!.toLowerCase().capitalizeFirst()}",
                  style: TextStyle(
                    fontSize: AppDimens.textSize14,
                    color: AppColor.primary
                  ),
                ),
          
                Text(
                  "Assigned to : ${getAssignedTo(tasks.userId ?? "", context)}",
                  style: TextStyle(
                    fontSize: AppDimens.textSize14,
                    color: AppColor.primary
                  ),
                ),
          
                Text(
                  "Due Date : ${tasks.dueDate}",
                  style: TextStyle(
                    fontSize: AppDimens.textSize14,
                    color: AppColor.primary
                  ),
                ),
          
                Text(
                  "Description : ${tasks.description}",
                  style: TextStyle(
                    fontSize: AppDimens.textSize14,
                    color: AppColor.primary
                  ),
                ),
          
                // 10.h,
          
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Expanded(
                //       child: CustomButton(
                //         padding: EdgeInsets.symmetric(horizontal: AppDimens.spacing10),
                //         text: "View",
                //         onPressed: () {
                          
                //         },
                //         borderRadius: AppDimens.radius10,
                //         isActive: true,
                //         buttonHeight: AppDimens.buttonHeight35,
                //         buttonWidth: 80,
                //         fontSize: AppDimens.textSize15,
                //       ),
                //     ),
                //     10.w,
                //     Expanded(
                //       child: CustomButton(
                //         padding: EdgeInsets.symmetric(horizontal: AppDimens.spacing10),
                //         text: "Edit",
                //         onPressed: () {
                //           // context.pushNamed(
                //           //   RoutesName.editLeadScreen,
                //           //   extra: leads
                //           // );
                //         },
                //         borderRadius: AppDimens.radius10,
                //         isActive: true,
                //         buttonHeight: AppDimens.buttonHeight35,
                //         buttonWidth: 80,
                //         fontSize: AppDimens.textSize15,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),

          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: () {
                context.pushNamed(RoutesName.taskScreen, extra: tasks.id);
              },
              child: Container(
                width: AppDimens.buttonHeight30,
                height: AppDimens.buttonHeight30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.primary.withValues(alpha: .1),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(AppDimens.spacing12),
                    bottomLeft: Radius.circular(AppDimens.spacing12)
                  )
                ),
                child: const Icon(
                  Icons.remove_red_eye_outlined,
                  size: AppDimens.spacing18,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}