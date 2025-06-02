part of 'email_cubit.dart';

sealed class EmailState extends Equatable {
  const EmailState();

  @override
  List<Object> get props => [];
}

final class EmailInitial extends EmailState {}

final class EmailTempsLoading extends EmailState {}
class EmailTempsLoaded extends EmailState {
  final List<Emailtpls> emailTemps;
  const EmailTempsLoaded(this.emailTemps);

  @override
  List<Object> get props => [emailTemps];
}
class EmailTempsError extends EmailState {
  final String message;
  const EmailTempsError(this.message);

  @override
  List<Object> get props => [message];
}

final class EmailTemplDetailLoading extends EmailState {}
final class EmailTemplDeleted extends EmailState {}
class EmailTemplDetailLoaded extends EmailState {
  final Emailtpls emailTemp;
  const EmailTemplDetailLoaded(this.emailTemp);

  @override
  List<Object> get props => [emailTemp];
}
class EmailTemplDetailError extends EmailState {
  final String message;
  const EmailTemplDetailError(this.message);

  @override
  List<Object> get props => [message];
}

final class EmailTemplFormLoading extends EmailState {}
final class EmailTemplFormUpdate extends EmailState {}
final class EmailTemplFormSaved extends EmailState {}
class EmailTemplFormError extends EmailState {
  final String message;
  const EmailTemplFormError(this.message);

  @override
  List<Object> get props => [message];
}