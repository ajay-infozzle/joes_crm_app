import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/utils/dependency_injection.dart';
import 'package:joes_jwellery_crm/data/model/free_item_list_model.dart';
import 'package:joes_jwellery_crm/domain/usecases/customer_usecase.dart';
import 'package:joes_jwellery_crm/domain/usecases/free_item_usecase.dart';
import 'package:joes_jwellery_crm/presentation/widgets/app_snackbar.dart';

part 'free_item_state.dart';

class FreeItemCubit extends Cubit<FreeItemState> {
  final FreeItemUsecase freeItemUsecase;
  FreeItemCubit({required this.freeItemUsecase}) : super(FreeItemInitial());
  
  List<Freeitems> allItems = [];


  Future<void> fetchAllItems() async {
    try {
      emit(FreeItemsLoading());
      final response = await freeItemUsecase.fetchAllFreeItems();
      final data = FreeItemListModel.fromJson(response);
      allItems = data.freeitems ?? [] ;
      emit(FreeItemsLoaded(data.freeitems??[]));
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Free item Cubit");
      emit(FreeItemsError(e.toString()));
    }
  }

  Future<void> deleteItem({required String id}) async {
    try {
      emit(FreeItemsLoading());
      final response = await freeItemUsecase.deleteSingleFreeItem(id: id);
      if(response != null){
        showToast(msg: response['message'], backColor: AppColor.green);
        fetchAllItems();
      }else{
        emit(FreeItemsError("Something went wrong !"));
      }
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Free item Cubit");
      emit(FreeItemsError(e.toString()));
    }
  }

  Future<void> addItem({required Map<String, dynamic> formdata}) async {
    if(formdata['name'].isEmpty){
      showToast(msg: "Please enter name", backColor: AppColor.red);
      return ;
    }
    if(formdata['surname'].isEmpty){
      showToast(msg: "Please enter surname", backColor: AppColor.red);
      return ;
    }
    if(formdata['email'].isEmpty){
      showToast(msg: "Please enter email", backColor: AppColor.red);
      return ;
    }
    if(formdata['email'].isNotEmpty){
      emit(FreeItemFormLoading());
      final emailResponse = await CustomerUseCase(getIt()).validateEmail(email: formdata['email']);
      if(emailResponse['status'] != 200){
        emit(FreeItemFormError(''));
        showToast(msg: "Invalid Email (${emailResponse['info']})", backColor: AppColor.red);
        return ;
      }
    }
    

    try {
      emit(FreeItemFormLoading());
      final response = await freeItemUsecase.addFreeItem(formdata: formdata);
      if(response != null){
        showToast(msg: response['message'], backColor: AppColor.green);
        emit(FreeItemFormSaved());
      }else{
        emit(FreeItemFormError("Something went wrong !"));
      }
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Sale Cubit");
      emit(FreeItemFormError(e.toString()));
    }
  }

}
