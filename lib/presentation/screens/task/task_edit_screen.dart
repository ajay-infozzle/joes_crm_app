import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/date_formatter.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/data/model/single_task_model.dart';
import 'package:joes_jwellery_crm/presentation/bloc/home/home_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/task/task_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/auth/widget/textfield_title_text_widget.dart';
import 'package:joes_jwellery_crm/presentation/widgets/assoc_dropdown_widget.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_button.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_text_field.dart';

class TaskEditScreen extends StatefulWidget {
  final Task task;
  const TaskEditScreen({super.key, required this.task});

  @override
  State<TaskEditScreen> createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  
  TextEditingController titleController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  FocusNode titleFocusNode = FocusNode();
  FocusNode dueDateFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    titleController.text = widget.task.title ?? "" ;
    dueDateController.text = widget.task.dueDate ?? "" ;
    descriptionController.text = widget.task.description ?? "" ;

    context.read<HomeCubit>().usersList.forEach((e) {
      if(widget.task.userId == e.id){
        context.read<TaskCubit>().currentTaskUser = e ;
      }
    },);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: AppColor.greenishGrey,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: AppColor.white,
        title: SizedBox(
          child: Text(
            "Edit Task ${widget.task.title}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppDimens.spacing18,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),

      body: SafeArea(
        child: Container(
          width: width,
          color: AppColor.white,
          child: BlocConsumer<TaskCubit, TaskState>(
            listener: (context, state) {
             if(state is TaskEditFormUpdated){
              context.pop();
              context.read<TaskCubit>().fetchTaskDetail(id: widget.task.id!);
             }
            },
            builder: (context, state) {
              TaskCubit taskCubit = context.read<TaskCubit>() ;

              if(state is TaskEditFormLoading){
                return Center(child: CircularProgressIndicator(color: AppColor.backgroundColor,));
              }
              
              return ListView(
                padding: const EdgeInsets.only(
                  top: AppDimens.spacing10,
                  left: AppDimens.spacing15,
                  right: AppDimens.spacing15,
                ),
                children: [
                  TextfieldTitleTextWidget(title: "Title"),
                  _buildField("Title", titleController, titleFocusNode),
                  7.h,
    
                  TextfieldTitleTextWidget(title: "User"),
                  5.h,
                  AssocDropdown(
                    usersList: context.read<HomeCubit>().usersList, 
                    onSelected: (selectedUser) => taskCubit.changeUser(selectedUser),
                    initialSelected: taskCubit.currentTaskUser,
                  ),
                  10.h,

                  TextfieldTitleTextWidget(title: "Due Date"),
                  GestureDetector(
                    child: _buildField(
                      "Due Date",
                      dueDateController,
                      dueDateFocusNode,
                      isEnable: false,
                    ),
                    onTap: () async {
                      dueDateController.text = await getDateFromUser(context);
                    },
                  ),
                  7.h,

                  TextfieldTitleTextWidget(title: "Description"),
                  _buildField("Description", descriptionController, descriptionFocusNode, maxline: 7),
                  30.h,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                        text: "Save",
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          taskCubit.validateEditFormAndSubmit(
                            title : titleController.text,
                            dueDate: dueDateController.text,
                            description : descriptionController.text
                          );
                        },
                        borderRadius: AppDimens.radius16,
                        isActive: true,
                        buttonHeight: AppDimens.buttonHeight40,
                        fontSize: AppDimens.textSize18,
                      ),
                    ],
                  ),

                  30.h,
    
                ],
              );
            },
          ),
        )
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller,
    FocusNode focusNode, {
    bool isEnable = true,
    int maxline = 1,
    TextInputType inputType = TextInputType.text
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.spacing6),
      child: CustomTextField(
        controller: controller,
        focusNode: focusNode,
        fieldBackColor: AppColor.greenishGrey.withValues(alpha: 0.4),
        hintText: label,
        enabled: isEnable,
        keyboardType: inputType,
        textInputAction: TextInputAction.next,
        maxline: maxline,
      ),
    );
  }
  
}