import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/routes/routes_name.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/core/utils/date_formatter.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/presentation/bloc/home/home_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/task/task_cubit.dart';
import 'package:joes_jwellery_crm/presentation/widgets/retry_widget.dart';

class TaskScreen extends StatefulWidget {
  final String id;
  const TaskScreen({super.key, required this.id});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

  @override
  void initState() {
    super.initState();

    context.read<TaskCubit>().fetchTaskDetail(id: widget.id);
  }

  String getUserName(String userId){
    String name = "_";
    context.read<HomeCubit>().usersList.forEach((e) {
      if(userId == e.id){
        name = e.name ?? "_";
      }
    },);
    return name.toLowerCase().capitalizeFirst();
  }
  
  String isCompleted(String value){
    if(value == "0"){
      return "No" ;
    }else{
      return "Yes" ;
    }
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
          child: Text(
            "Task",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppDimens.spacing18,
            ),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColor.primary,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              AssetsConstant.editIcon,
              color: AppColor.primary,
              height: AppDimens.spacing22,
              width: AppDimens.spacing22,
            ),
            onPressed: () {
              final task = context.read<TaskCubit>().currentTask ;
              context.pushNamed(RoutesName.editTaskScreen, extra: task);
            },
          ),
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          width: width,
          color: AppColor.white,
          child: BlocConsumer<TaskCubit, TaskState>(
            listener: (context, state) {

            },
            builder: (context, state) {
              TaskCubit taskCubit = context.read<TaskCubit>() ;

              if (state is TaskLoading) {
                return Expanded(child: Center(child: CircularProgressIndicator(color: AppColor.primary)));
              }
              else if (state is TaskError) {
                return Expanded(
                  child: RetryWidget(
                    onTap: () async{
                      context.read<TaskCubit>().fetchTaskDetail(id: widget.id);
                    },
                  ),
                );
              }

              else if (taskCubit.currentTask != null) {
                return Container(
                  margin: const EdgeInsets.all(AppDimens.spacing10),
                  padding: const EdgeInsets.all(AppDimens.spacing10),
                  decoration: BoxDecoration(
                    color: AppColor.greenishGrey.withValues(alpha: .4),
                    borderRadius: BorderRadius.circular(AppDimens.radius12)
                  ),
                  child: RefreshIndicator(
                    color: AppColor.primary,
                    onRefresh: () async {
                      context.read<TaskCubit>().fetchTaskDetail(id: widget.id);
                    },
                    child: ListView(
                      children: [
                        contentRow(title: "Title", data: taskCubit.currentTask?.title??"_"),
                        10.h,

                        contentRow(title: "User", data: getUserName(taskCubit.currentTask?.userId??"_")),
                        10.h,

                        contentRow(title: "Due Date", data: taskCubit.currentTask?.dueDate??"_"),
                        10.h,

                        contentRow(title: "Discription", data: taskCubit.currentTask?.description??"_"),
                        10.h,

                        contentRow(title: "Completed", data: isCompleted(taskCubit.currentTask?.completed??"_")),
                        10.h,

                        contentRow(title: "Completion Date", data: formatDateTime(taskCubit.currentTask?.completionDate??"")["date"]??"_"),
                        10.h,

                        contentRow(title: "Created By", data: getUserName(taskCubit.currentTask?.createdBy??"_")),
                        10.h,
                      ],
                    ),
                  ),
                );
              }

              return SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Widget contentRow({required String title, required String data}){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$title :", style: const TextStyle(fontSize: AppDimens.textSize14, fontWeight: FontWeight.bold)),
        AppDimens.spacing8.w,
        Expanded(
          child: Text(
            data, 
            style: const TextStyle(fontSize: AppDimens.textSize14),
            softWrap: true,
          )
        ),
      ],
    );
  } 

}
