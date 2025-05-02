import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial());

  int index = 2 ;

  void changeIndex (int i){
    index = i;
    emit(DashboardIndexChange(index));
  }
}
