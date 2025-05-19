import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:joes_jwellery_crm/data/model/home_detail_model.dart';
import 'package:joes_jwellery_crm/data/model/store_list_model.dart';
import 'package:joes_jwellery_crm/domain/usecases/home_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeUseCase homeUseCase;

  HomeCubit({required this.homeUseCase}) : super(HomeInitial());

  List<Stores> storeList = [];

  Future<void> fetchHomeData() async {
    emit(HomeLoading());
    try {
      final response = await homeUseCase.call();
      final data = HomeDetailModel.fromJson(response);

      //~ fetch stores as well
      final storeResponse = await homeUseCase.getStores();
      final storeData = StoreListModel.fromJson(storeResponse);
      storeList = storeData.stores ?? [] ;
      
      emit(HomeLoaded(data));
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Home Cubit");
      emit(HomeError(e.toString()));
    }
  }
}
