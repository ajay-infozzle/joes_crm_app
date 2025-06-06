part of 'reports_cubit.dart';

sealed class ReportsState extends Equatable {
  const ReportsState();

  @override
  List<Object> get props => [];
}

final class ReportsInitial extends ReportsState {}
final class WaterTaxiLoading extends ReportsState {}
final class WaterTaxiLoaded extends ReportsState {}
class WaterTaxiError extends ReportsState {
  final String message;
  const WaterTaxiError(this.message);

  @override
  List<Object> get props => [message];
}

final class AppraisalLoading extends ReportsState {}
final class AppraisalLoaded extends ReportsState {}
class AppraisalError extends ReportsState {
  final String message;
  const AppraisalError(this.message);

  @override
  List<Object> get props => [message];
}