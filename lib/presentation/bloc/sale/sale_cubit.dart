import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:joes_jwellery_crm/core/utils/custome_image_picker.dart';
import 'package:joes_jwellery_crm/data/model/assoc_list_model.dart';
import 'package:joes_jwellery_crm/data/model/store_list_model.dart';
import 'package:joes_jwellery_crm/domain/usecases/sale_usecase.dart';

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
}
