part of 'leads_cubit.dart';

sealed class LeadsState extends Equatable {
  const LeadsState();

  @override
  List<Object> get props => [];
}

final class LeadsInitial extends LeadsState {}

final class LeadsAddFormUpdate extends LeadsState {}
final class LeadsAddFormLoading extends LeadsState {}
final class LeadsAdded extends LeadsState {}
final class LeadsAddError extends LeadsState {
  final String message;
  const LeadsAddError(this.message);

  @override
  List<Object> get props => [message];
}

final class LeadsEditFormUpdate extends LeadsState {}
final class LeadsEditFormLoading extends LeadsState {}
final class LeadsUpdated extends LeadsState {}
final class LeadsEditError extends LeadsState {
  final String message;
  const LeadsEditError(this.message);

  @override
  List<Object> get props => [message];
}

final class SearchTextChange extends LeadsState {}
final class LeadsSearching extends LeadsState {}
final class LeadsLoaded extends LeadsState {}
final class LeadsSearchError extends LeadsState {
  final String message;
  const LeadsSearchError(this.message);

  @override
  List<Object> get props => [message];
}


final class LeadsDetailLoading extends LeadsState {}
final class LeadsDetailLoaded extends LeadsState {}
final class LeadsDetailError extends LeadsState {
  final String message;
  const LeadsDetailError(this.message);

  @override
  List<Object> get props => [message];
}

final class LeadsPhotoUpdating extends LeadsState {}
final class LeadsPhotoUpdated extends LeadsState {}
final class LeadsPhotoError extends LeadsState {
  final String message;
  const LeadsPhotoError(this.message);

  @override
  List<Object> get props => [message];
}

final class LeadsSendingEmail extends LeadsState {}
final class LeadsEmailSent extends LeadsState {}
final class LeadsEmailSentError extends LeadsState {
  final String message;
  const LeadsEmailSentError(this.message);

  @override
  List<Object> get props => [message];
}
