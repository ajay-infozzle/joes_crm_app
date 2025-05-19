import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/utils/session_manager.dart';
import 'package:joes_jwellery_crm/data/model/leads_model.dart';
import 'package:joes_jwellery_crm/data/model/store_list_model.dart';
import 'package:joes_jwellery_crm/domain/usecases/leads_usecase.dart';
import 'package:joes_jwellery_crm/presentation/widgets/app_snackbar.dart';
import 'package:joes_jwellery_crm/presentation/widgets/title_dropdown_widget.dart';

part 'leads_state.dart';

class LeadsCubit extends Cubit<LeadsState> {
  final LeadsUseCase leadsUseCase;
  LeadsCubit({required this.leadsUseCase}) : super(LeadsInitial());

  List<Leads> currentSearchLeads = [];
  String currentSearchText = '' ;
  Stores? store;
  TitleOption title = TitleOption(value: '', display: "Select title");

  void initial(){
    emit(LeadsInitial());
  }

  void changeStore(Stores value){
    store = value;
    emit(LeadsAddFormUpdate());
  }

  void onChangeSearchText(String value){
    emit(LeadsInitial());
    currentSearchText = value ;
    emit(SearchTextChange());
  }

  final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  void validateFormAndSubmit({
    required String storeId,
    required String name,
    required String surname,
    required String email,
    required String phone,
    required String address,
    required String followDate,
    required String amount,
    required String salesAssoc,
  }){
    if(storeId.isEmpty){
      emit(LeadsAddError("Please select store"));
      return ;
    }
    if(title.value.isEmpty){
      emit(LeadsAddError("Please select title"));
      return ;
    }
    if(name.isEmpty){
      emit(LeadsAddError("Please enter name"));
      return ;
    }
    if(followDate.isEmpty){
      emit(LeadsAddError("Please select follow date"));
      return ;
    }
    if(amount.isEmpty){
      emit(LeadsAddError("Please enter amount"));
      return ;
    }
    if(email.isNotEmpty && !emailRegex.hasMatch(email)){
      emit(LeadsAddError("Please enter a valid email"));
      return;
    }
    
    final sessionManager = SessionManager();
    String userId = sessionManager.getUserId() ?? "";
    
    addLead(
      formdata: {
        'user_id' : userId,
        'store_id' : storeId,
        'title' : title.value,
        'follow_date' : followDate,
        'amount' : amount,
        'email' : email,
        'name' : name,
        'surname' : surname,
        'address' : address,
        'phone' : phone,
        'sales_assoc_2' : salesAssoc
      } 
    );
  }

  Future<void> addLead({
    required Map<String, String> formdata
  }) async {
    try {
      emit(LeadsAddFormLoading());
      final response = await leadsUseCase.addLeads(formdata: formdata);
      if(response != null){
        showToast(msg: response['message'], backColor: AppColor.green);

        emit(LeadsAdded());
      }else{
        emit(LeadsAddError("Something went wrong"));
      }
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Lead Cubit");
      emit(LeadsAddError(e.toString()));
    }
  }

  Future<void> searchLeads() async {
    try {
      currentSearchLeads.clear();

      emit(LeadsSearching());
      final response = await leadsUseCase.searchLeads(query: {
        'query' : currentSearchText
      });
      if(response != null){
        final data = LeadsModel.fromJson(response);
        
        if(data.leads!.isNotEmpty){
          showToast(msg: "${data.leads!.length} leads found", backColor: AppColor.green);
          currentSearchLeads = data.leads!;
          emit(LeadsLoaded());
        }else{
          showToast(msg: "${data.leads!.length} leads found", backColor: AppColor.greenishGrey, textColor: AppColor.primary);
          emit(LeadsLoaded());
        }
      }else{
        emit(LeadsSearchError("Something went wrong !"));
      }
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Leads Cubit");
      emit(LeadsSearchError(e.toString()));
    }
  }

}
