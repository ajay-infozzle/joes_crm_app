part of 'sms_cubit.dart';

sealed class SmsState extends Equatable {
  const SmsState();

  @override
  List<Object> get props => [];
}

final class SmsInitial extends SmsState {}

final class SmsListLoading extends SmsState {}
final class SmsThreadLoading extends SmsState {}

final class SmsListLoaded extends SmsState {
  final SmsChatListModel smsChatListModel;
  const SmsListLoaded(this.smsChatListModel);

  @override
  List<Object> get props => [smsChatListModel];
}

final class SmsListError extends SmsState {
  final String message;
  const SmsListError(this.message);

  @override
  List<Object> get props => [message];
}
