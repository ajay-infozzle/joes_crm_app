part of 'whatsapp_cubit.dart';

sealed class WhatsappState extends Equatable {
  const WhatsappState();

  @override
  List<Object> get props => [];
}

final class WhatsappInitial extends WhatsappState {}

final class WhatsappListLoading extends WhatsappState {}
final class WhatsappThreadLoading extends WhatsappState {}

final class WhatsappListLoaded extends WhatsappState {
  final WhatsappChatListModel whatsappChatListModel;
  const WhatsappListLoaded(this.whatsappChatListModel);

  @override
  List<Object> get props => [whatsappChatListModel];
}

final class WhatsappListError extends WhatsappState {
  final String message;
  const WhatsappListError(this.message);

  @override
  List<Object> get props => [message];
}