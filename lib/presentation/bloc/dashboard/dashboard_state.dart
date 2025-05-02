part of 'dashboard_cubit.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

final class DashboardInitial extends DashboardState {}

final class DashboardIndexChange extends DashboardState {
  final int index;
  const DashboardIndexChange(this.index);

  @override
  List<Object> get props => [index];
}
