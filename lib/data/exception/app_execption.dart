class AppException implements Exception {
  final dynamic _message;
  final dynamic _prefix;
  final int? code;
 
  AppException([this._message, this._prefix, this.code]);
 
  @override
  String toString() {
    return '$_message$_prefix';
  }
}
 
//~ Exception class representing a fetch data error during communication.
class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, ''); //Error During Communication
}
 
//~ Exception class representing a bad request error.
class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, ''); //Bad request
}
 
//~ Exception class representing an unauthorized request error.
class UnauthorisedException extends AppException {
  UnauthorisedException([String? message]) : super(message, ''); //Unauthorised request
}
 
//~ Exception class representing an invalid input error.
class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, ''); //Invalid Input
}
 
//~ Exception class representing a no internet connection error.
class NoInternetException extends AppException {
  NoInternetException([String? message]) : super(message, 'No Internet Connection');
}
 
//~ Exception class representing server error.
class InternalServerException extends AppException {
  InternalServerException([String? message]) : super(message, 'Something went wrong !');
}