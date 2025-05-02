part of 'call_cubit.dart';

sealed class CallState extends Equatable {
  const CallState();

  @override
  List<Object> get props => [];
}

final class CallInitial extends CallState {}

final class CallLogLoading extends CallState {}

final class CallLogLoaded extends CallState {
  final CallLogModel callLogModel;
  const CallLogLoaded(this.callLogModel);

  @override
  List<Object> get props => [callLogModel];
}

final class CallLogError extends CallState {
  final String message;
  const CallLogError(this.message);

  @override
  List<Object> get props => [message];
}