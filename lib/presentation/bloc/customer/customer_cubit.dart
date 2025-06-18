import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:http_parser/http_parser.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/utils/custome_image_picker.dart';
import 'package:joes_jwellery_crm/core/utils/dependency_injection.dart';
import 'package:joes_jwellery_crm/data/model/customer_list_model.dart';
import 'package:joes_jwellery_crm/data/model/single_customer_model.dart';
import 'package:joes_jwellery_crm/data/model/store_list_model.dart';
import 'package:joes_jwellery_crm/domain/usecases/customer_usecase.dart';
import 'package:joes_jwellery_crm/domain/usecases/email_usecase.dart';
import 'package:joes_jwellery_crm/presentation/widgets/app_snackbar.dart';
import 'package:joes_jwellery_crm/presentation/widgets/origination_dropdown_widget.dart';

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  final CustomerUseCase customerUseCase;

  CustomerCubit({required this.customerUseCase}) : super(CustomerInitial());

  Map<String, dynamic> customerFilterFormData = {};

  Future<void> fetchCustomers() async {
    try {
      emit(CustomerListLoading());
      final response = await customerUseCase.fetchCustomers();
      final data = CustomerListModel.fromJson(response);

      customerFilterFormData.clear();
      emit(CustomerListLoaded(data.customers??[]));
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Customer Cubit");
      emit(CustomerListError(e.toString()));
    }
  }

  Future<void> filterCustomers({required Map<String, dynamic> formdata}) async {
    customerFilterFormData = formdata ;
    try {
      emit(CustomerListLoading());
      final response = await customerUseCase.filterCustomers(formdata: formdata);
      final data = CustomerListModel.fromJson(response);
      emit(CustomerListLoaded(data.customers??[]));
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Customer Cubit");
      emit(CustomerListError(e.toString()));
    }
  }

  Future<void> sendEmailCampaign({
    required Map<String , dynamic> formdata,
  }) async {
    try {
      formdata.addAll(formdata);
      
      emit(CustomerSendingEmail());
      final response = await EmailUsecase(getIt()).sendEmailCampaign(formdata: formdata);
      if(response != null){
        showToast(msg: response['message'], backColor: AppColor.green);

        customerFilterFormData.clear();
        emit(CustomerEmailSent());
      }else{
        emit(CustomerEmailSentError("Something went wrong !"));
      }
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Customer Cubit");
      emit(CustomerEmailSentError(e.toString()));
    }
  }

  Customer? currentCustomer ;
  Future<void> fetchSingleCustomer({required String id}) async {
    try {
      emit(CustomerLoading());
      final response = await customerUseCase.fetchSingleCustomer(id: id);
      final data = SingleCustomerModel.fromJson(response);
      currentCustomer = data.customer ;
      emit(CustomerLoaded(data.customer ?? Customer()));
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Customer Cubit");
      emit(CustomerError(e.toString()));
    }
  }


  String vip = "No" ;
  String subscribe = "No" ;
  String country = "" ; //UnitedStates, Canada, UnitedKingdom, SintMaarten, other
  String statte = "" ;
  String city = "" ;
  OriginationOption  origination = OriginationOption(value: '', display: 'Select origination');  //ship, hotel, mailchimp, NotAvailable
  Stores? store;
  String tempCustEmail = "";
  String tempCustGender = "M";

  void changeStore(Stores value){
    store = value;
    emit(CustomerAddFormUpdate());
  }

  String checkCountry(){
    switch (country.trim()) {
      case "":
        return "" ;
      case "United States":
        return "UnitedStates" ;
      case "Canada":
        return "Canada" ;
      case "United Kingdom":
        return "UnitedKingdom" ;
      case "Sint Maarten (Dutch part)":
        return "SintMaarten" ;
      default:
        return "other";
    }
  }

  String getCountry(String currentCntry){
    switch (currentCntry) {
      case "UnitedStates":
        return "United States" ;
      case "Canada":
        return "Canada" ;
      case "UnitedKingdom":
        return "United Kingdom" ;
      case "SintMaarten":
        return "Sint Maarten (Dutch part)" ;
      default:
        return "";
    }
  }

  void changeVip(String value){
    emit(CustomerInitial());
    vip = value ;
    emit(CustomerAddFormUpdate());
  }

  void changeSubscribe(String value){
    emit(CustomerInitial());
    subscribe = value ;
    emit(CustomerAddFormUpdate());
  }

  void changeCountry(String value){
    country = value ;
    emit(CustomerAddFormUpdate());
  }

  void changeState(String value){
    statte = value ;
    emit(CustomerAddFormUpdate());
  }

  void changeCity(String value){
    city = value ;
    emit(CustomerAddFormUpdate());
  }

  File? currentPickedImg ;
  Future<void> pickImage() async {
    final picked = await CustomeImagePicker.pickImageFromGallery(); 
    if (picked != null) {
      currentPickedImg = picked;
      if(state is CustomerAddFormUpdate){
        emit(CustomerInitial());
        emit(CustomerAddFormUpdate());
      }
      else{
        emit(CustomerAddFormUpdate());
      }
    }
  }

  final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

  void validateFormAndSubmit({
    required String storeId,
    required String name,
    required String surname,
    required String email,
    required String phone,
    required String cntry,
    required String spouseName,
    required String wifeEmail,
    required String wifePhone,
    required String ship,
    required String vip,
    required String address,
    required String city,
    required String sstate,
    required String zip,
    required String birthday,
    required String wifeBirthday,
    required String anniversary,
    required String unsubscribe,
    required String notes,
  }) async{
    if(storeId.isEmpty){
      emit(CustomerAddError("Please select store"));
      return ;
    }
    // if(email.isEmpty){
    //   emit(CustomerAddError("Please enter email"));
    //   return ;
    // }
    // if (!emailRegex.hasMatch(email)) {
    //   emit(CustomerAddError("Please enter a valid email"));
    //   return;
    // }
    if (cntry.isEmpty) {
      emit(CustomerAddError("Please select country"));
      return;
    }

    addCustomer(
      formdata: {
        'store_id' : storeId,
        'email' : email,
        'country' : cntry,
        'name' : name,
        'surname' : surname,
        'spouse_name' : spouseName,
        'wife_email' : wifeEmail,
        'vip' : vip,
        'ship' : ship,
        'address' : address,
        'city' : city,
        'state' : sstate,
        'zip' : zip,
        'phone' : phone,
        'wife_phone' : wifePhone,
        'birthday' : birthday,
        'spouse_birthday' : wifeBirthday,
        'anniversary' : anniversary,
        'unsubscribed' : unsubscribe,
        'notes' : notes,
        'photo' : await MultipartFile.fromFile(
          currentPickedImg?.path ?? "", 
          filename: "${name}_${DateTime.now().millisecondsSinceEpoch}.jpg",
          contentType: MediaType('image', 'jpeg')
        ),
      } 
    );
    
  }
  
  Future<void> isCustomerExist({
    required Map<String, String> formdata
  }) async {
    try {
      if(formdata['query'] == '' ){
        emit(CustomerExistError("Please enter customer email !"));
        return ;
      }
      if(!emailRegex.hasMatch(formdata['query']!)){
        emit(CustomerExistError("Please enter valid email !"));
        return ;
      }

      emit(CustomerExistVerifying());
      final response = await customerUseCase.searchCustomer(formdata: formdata);
      if(response != null){
        if(response['customers'].length > 0){
          showToast(msg: "${formdata['query']} is already exist", backColor: AppColor.red);
          final data = CustomerListModel.fromJson(response);
          emit(CustomerExist(data.customers??[]));
        }else if(response['customers'].length == 0){
          //~ now validate email from api
          final emailResponse = await customerUseCase.validateEmail(email: formdata['query']!);
          if(emailResponse['status'] == 200){
            showToast(msg: "${formdata['query']} is available", backColor: AppColor.green);
            emit(CustomerNotExist());
          }else{
            emit(CustomerExistError("Invalid Email (${emailResponse['info']})"));
          }
        }
      }else{
        emit(CustomerExistError("Something went wrong !"));
      }
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Customer Cubit");
      emit(CustomerExistError(e.toString()));
    }
  }

  Future<void> addCustomer({
    required Map<String, dynamic> formdata
  }) async {
    try {
      emit(CustomerAddFormLoading());
      final response = await customerUseCase.addCustomer(formdata: formdata);
      if(response != null){
        showToast(msg: response['message'], backColor: AppColor.green);

        store = null;
        origination = OriginationOption(value: '', display: "Select Origination");
        country = "";
        city = "";
        statte = "";
        tempCustEmail = "";
        emit(CustomerAddFormSubmitted());
      }
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Customer Cubit");
      emit(CustomerAddError(e.toString()));
    }
  }

  Future<void> addNote({
    required Map<String, dynamic> formdata
  }) async {
    try {
      emit(CustomerUpdateFormLoading());
      final response = await customerUseCase.addNote(formdata: formdata);
      if(response != null){
        showToast(msg: response['message'], backColor: AppColor.green);

        emit(CustomerUpdated());
        await fetchSingleCustomer(id: formdata['customer_id']);
      }
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Customer Cubit");
      emit(CustomerUpdateFormError(e.toString()));
    }
  }


  Future<void> updateCustomer({required Map<String, dynamic> formdata}) async {
    try {
      emit(CustomerUpdateFormLoading());
      if(formdata['email'].trim().isEmpty && formdata['wife_email'].trim().isEmpty){
        emit(CustomerUpdateFormError("His/Her email required !"));
        return ;
      }
      if(formdata['email'].trim().isNotEmpty){
        final emailResponse = await customerUseCase.validateEmail(email: formdata['email']!);
        if(emailResponse['status'] != 200){
          emit(CustomerUpdateFormError("Invalid His Email (${emailResponse['info']})"));
          return ;
        }
      }
      if(formdata['wife_email'].trim().isNotEmpty){
        final wifeEmailResponse = await customerUseCase.validateEmail(email: formdata['wife_email']!);
        if(wifeEmailResponse['status'] != 200){
          emit(CustomerUpdateFormError("Invalid Her Email (${wifeEmailResponse['info']})"));
          return ;
        }
      }
      
      final response = await customerUseCase.editCustomer(formdata: formdata);
      if(response != null){
        showToast(msg: response['message'], backColor: AppColor.green);

        emit(CustomerUpdated());
        await fetchCustomers(); 
        await fetchSingleCustomer(id: formdata['id']);
      }else{
        emit(CustomerUpdateFormError("Something went wrong !"));
      }
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Customer Cubit");
      emit(CustomerUpdateFormError(e.toString()));
    }
  }

  Future<void> updateCustomerPhoto({
    required File file,
    required String id,
  }) async {
    try {
      emit(CustomerLoading());
      final response = await customerUseCase.updateCustomerPhoto(file: file, id: id);
      if(response != null && response['success']== true){
        showToast(msg: response['message'], backColor: AppColor.green);

        await fetchCustomers(); 
        await fetchSingleCustomer(id: id);
      }
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Customer Cubit");
      emit(CustomerError(e.toString()));
    }
  }

  Future<void> sendHimEmail({
    required String custId,
    required String subject,
    required String message
  }) async {
    try {
      emit(CustomerSendingEmail());
      final response = await customerUseCase.sendHimEmail(
        formdata: {
          'customer_id' : custId,
          'subject' : subject,
          'message' : message,
        }
      );
      if(response != null){
        showToast(msg: response['message'], backColor: AppColor.green);
        emit(CustomerEmailSent());
      }else{
        emit(CustomerEmailSentError("Something went wrong !"));
      }
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Customer Cubit");
      emit(CustomerEmailSentError(e.toString()));
    }
  }

  Future<void> sendHerEmail({
    required String custId,
    required String subject,
    required String message,
    required String herEmail,
  }) async {
    try {
      emit(CustomerSendingEmail());
      final response = await customerUseCase.sendHerEmail(
        formdata: {
          'customer_id' : custId,
          'subject' : subject,
          'message' : message,
          'wife_email' : herEmail
        }
      );
      if(response != null){
        showToast(msg: response['message'], backColor: AppColor.green);
        emit(CustomerEmailSent());
      }else{
        emit(CustomerEmailSentError("Something went wrong !"));
      }
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Customer Cubit");
      emit(CustomerEmailSentError(e.toString()));
    }
  }

  Future<void> sendWaterTaxiEmail({
    required Map<String , dynamic> formdata,
  }) async {
    try {
      emit(CustomerSendingEmail());
      final response = await customerUseCase.sendWaterTaxiEmail(formdata: formdata);
      if(response != null){
        showToast(msg: response['message'], backColor: AppColor.green);
        emit(CustomerEmailSent());
      }else{
        emit(CustomerEmailSentError("Something went wrong !"));
      }
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Customer Cubit");
      emit(CustomerEmailSentError(e.toString()));
    }
  }

  Future<void> sendApprCertEmail({
    required Map<String , dynamic> formdata,
  }) async {
    try {
      emit(CustomerSendingEmail());
      final response = await customerUseCase.sendApprCertEmail(formdata: formdata);
      if(response != null){
        showToast(msg: response['message'], backColor: AppColor.green);
        emit(CustomerEmailSent());
      }else{
        emit(CustomerEmailSentError("Something went wrong !"));
      }
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Customer Cubit");
      emit(CustomerEmailSentError(e.toString()));
    }
  }

}
