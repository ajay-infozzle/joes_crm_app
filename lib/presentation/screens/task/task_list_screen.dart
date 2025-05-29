import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/data/model/task_list_model.dart';
import 'package:joes_jwellery_crm/presentation/bloc/task/task_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/task/widget/task_list_widget.dart';
import 'package:joes_jwellery_crm/presentation/widgets/retry_widget.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Tasks> filteredTasks = [];
  List<Tasks> allTasks = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TaskCubit>().fetchTaskList();
  }

  String getStatus(String value){
    return value == "1" ? "Pending" : "Completed";
  }

  void filterSearch(String query) {
    setState(() {
      filteredTasks =
          allTasks.where((task) {
            return getStatus(task.completed!).toLowerCase().contains(query.toLowerCase()) ||
                task.title!.toLowerCase().contains(query.toLowerCase()) ||
                task.description!.toLowerCase().contains(query.toLowerCase());
          }).toList();
    });
  }

  void _onDataLoaded(List<Tasks> tasks) {
    allTasks = tasks ;
    filteredTasks = searchController.text.isEmpty
          ? allTasks
          : allTasks.where((item) => item.title
                  ?.toLowerCase().contains(searchController.text.toLowerCase()) ?? false)
              .toList();
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
            "Tasks",
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
          // IconButton(
          //   icon: Icon(
          //     Icons.add,
          //     size: AppDimens.icon25,
          //     color: AppColor.primary,
          //   ),
          //   onPressed: () {
          //     // context.pushNamed(RoutesName.addLeadsScreen);
          //   },
          // ),
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          width: width,
          color: AppColor.white,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04,
                  vertical: AppDimens.spacing10,
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: filterSearch,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimens.spacing15,
                      ),
                      child: SizedBox(
                        width: AppDimens.icon13,
                        height: AppDimens.icon13,
                        child: Image.asset(
                          AssetsConstant.searchIcon,
                          color: AppColor.primary.withValues(alpha: .8),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    hintText: "Search Title, Description, Status",
                    hintStyle: TextStyle(
                      color: AppColor.primary.withValues(alpha: .8),
                    ),
                    filled: true,
                    fillColor: AppColor.greenishGrey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppDimens.radius12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: AppDimens.spacing5,
                    ),
                  ),
                  cursorColor: AppColor.primary,
                ),
              ),

              Expanded(
                child: BlocConsumer<TaskCubit, TaskState>(
                  listener: (context, state) {
                    if (state is TaskListLoaded) {
                      allTasks.clear();
                      filteredTasks.clear();
                      _onDataLoaded(state.tasks);
                    }
                  },
                  builder: (context, state) {
                    if (state is TaskListLoading) {
                      return Center(child: CircularProgressIndicator(color: AppColor.primary));
                    }
                    else if (state is TaskListError) {
                      return RetryWidget(
                        onTap: () async{
                          context.read<TaskCubit>().fetchTaskList();
                        },
                      );
                    }
                    else if(allTasks.isNotEmpty){
                      return RefreshIndicator(
                        color: AppColor.primary,
                        onRefresh: () async {
                          context.read<TaskCubit>().fetchTaskList();
                        },
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimens.spacing15,
                            vertical: AppDimens.spacing8,
                          ),
                          itemCount: filteredTasks.length,
                          itemBuilder: (context, index) {
                            Tasks task = filteredTasks[index];
                            return TaskListWidget(tasks: task);
                          },
                        ),
                      );
                    }else {
                      return SizedBox();
                    }
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
