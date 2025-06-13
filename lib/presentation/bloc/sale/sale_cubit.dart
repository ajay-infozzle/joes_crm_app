import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/utils/custome_image_picker.dart';
import 'package:joes_jwellery_crm/core/utils/session_manager.dart';
import 'package:joes_jwellery_crm/data/model/assoc_list_model.dart';
import 'package:joes_jwellery_crm/data/model/sales_list_model.dart';
import 'package:joes_jwellery_crm/data/model/store_list_model.dart';
import 'package:joes_jwellery_crm/domain/usecases/sale_usecase.dart';
import 'package:joes_jwellery_crm/presentation/widgets/app_snackbar.dart';

part 'sale_state.dart';

class SaleCubit extends Cubit<SaleState> {
  final SaleUsecase saleUsecase;
  SaleCubit({required this.saleUsecase}) : super(SaleInitial());

  Stores? store;

  void changeStore(Stores value){
    store = value;
    emit(SaleFormUpdate());
  }

  List<Users> selectedAssociates = [];
  FilePickerResult? currentPickedPdf ;
  Future<void> pickPdf() async {
    final picked = await CustomeImagePicker.pickPdfFile(); 
    if (picked != null) {
      currentPickedPdf = picked;
      if(state is SaleFormUpdate){
        emit(SaleInitial());
        emit(SaleFormUpdate());
      }
      else{
        emit(SaleFormUpdate());
      }
    }
  }

  List<Sales> allSalesList = []; 
  Sale? currentSale ; 
  Future<void> fetchAllSales() async {
    try {
      emit(SaleListLoading());
      final response = await saleUsecase.fetchSales();
      final data = SalesListModel.fromJson(response);
      allSalesList = data.sales ?? [] ;
      emit(SaleListLoaded(data.sales??[]));
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Sale Cubit");
      emit(SaleListError(e.toString()));
    }
  }

  Future<void> filterSales({required Map<String, dynamic> formdata}) async {
    try {
      emit(SaleListLoading());
      final response = await saleUsecase.filterSales(formdata: formdata);
      final data = SalesListModel.fromJson(response);
      allSalesList = data.sales ?? [] ;
      emit(SaleListLoaded(data.sales??[]));
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Sale Cubit");
      emit(SaleListError(e.toString()));
    }
  }

  Future<void> fetchSale({required String saleId}) async {
    try {
      emit(SaleLoading());
      final response = await saleUsecase.fetchSingleSale(id: saleId);
      final data = SingleSaleModel.fromJson(response);
      currentSale = data.sale;
      emit(SaleLoaded(data.sale!));
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Sale Cubit");
      emit(SaleError(e.toString()));
    }
  }

  Future<void> addSale({required Map<String, dynamic> formdata}) async {
    if(formdata['store_id'].isEmpty){
      showToast(msg: "Please select srore", backColor: AppColor.red);
      return ;
    }
    if(formdata['sale_date'].isEmpty){
      showToast(msg: "Please select sale date", backColor: AppColor.red);
      return ;
    }
    if(formdata['amount'].isEmpty){
      showToast(msg: "Please enter amount", backColor: AppColor.red);
      return ;
    }
    // if(formdata['notes'].isEmpty){
    //   showToast(msg: "Please add note", backColor: AppColor.red);
    //   return ;
    // }
    if(currentPickedPdf == null){
      showToast(msg: "Please add receipt pdf", backColor: AppColor.red);
      return ;
    }

    try {
      formdata['users_ids'] = selectedAssociates.map((e) => e.id ?? '').join(',');
      formdata['receipt_pdf'] = await MultipartFile.fromFile(
              currentPickedPdf!.files.single.path!, 
              filename: "${DateTime.now().millisecondsSinceEpoch}.pdf",
              contentType: MediaType('application', 'pdf')
            );
      emit(SaleFormLoading());
      final response = await saleUsecase.addSale(formdata: formdata);
      if(response != null){
        showToast(msg: response['message'], backColor: AppColor.green);
        emit(SaleFormSaved());
      }else{
        emit(SaleFormError("Something went wrong !"));
      }
      // emit(SaleFormUpdate());
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Sale Cubit");
      emit(SaleFormError(e.toString()));
    }
  }

  Future<void> editSale({required Map<String, dynamic> formdata}) async {

    if(formdata['store_id'].isEmpty){
      showToast(msg: "Please select srore", backColor: AppColor.red);
      return ;
    }
    if(formdata['sale_date'].isEmpty){
      showToast(msg: "Please select sale date", backColor: AppColor.red);
      return ;
    }
    if(formdata['amount'].isEmpty){
      showToast(msg: "Please enter amount", backColor: AppColor.red);
      return ;
    }
    if(formdata['notes'].isEmpty){
      showToast(msg: "Please add note", backColor: AppColor.red);
      return ;
    }
    if(currentPickedPdf == null){
      showToast(msg: "Please add receipt pdf", backColor: AppColor.red);
      return ;
    }

    try {
      String userId = SessionManager().getUserId() ?? '' ;
      formdata['user_id'] = userId;
      formdata['receipt_pdf'] = await MultipartFile.fromFile(
              currentPickedPdf!.files.single.path!, 
              filename: "${DateTime.now().millisecondsSinceEpoch}.pdf",
              contentType: MediaType('application', 'pdf')
            );

      emit(SaleFormLoading());
      final response = await saleUsecase.updateSale(formdata: formdata);
      if(response != null){
        showToast(msg: response['message'], backColor: AppColor.green);
        emit(SaleFormSaved());
      }else{
        emit(SaleFormError("Something went wrong !"));
      }
      emit(SaleFormUpdate());
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Sale Cubit");
      emit(SaleFormError(e.toString()));
    }
  }

}
