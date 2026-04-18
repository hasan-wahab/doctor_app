import 'base_exceptions.dart';

class NoInternetException extends BaseExceptions {
  NoInternetException({String? message, String? debugMessage})
    : super(
        message: message ?? 'No internet connection!',
        debugMessage: debugMessage ?? 'Something went wrong',
      );
}

class UnauthorisedException extends BaseExceptions {
  UnauthorisedException()
    : super(
        message: 'Invalid email or password !',
        debugMessage: '401 Unauthorized',
      );
}

class BadRequestException extends BaseExceptions {
  BadRequestException()
    : super(message: 'Invalid request data', debugMessage: '400 Bad Request');
}

class ForbiddenException extends BaseExceptions {
  ForbiddenException()
    : super(message: 'Access denied', debugMessage: '403 Forbidden');
}

class NotFoundException extends BaseExceptions {
  NotFoundException()
    : super(message: 'Data not found', debugMessage: '404 Not Found');
}

class ServerException extends BaseExceptions {
  ServerException()
    : super(
        message: 'Server error, try again later',
        debugMessage: '500 Internal Server Error',
      );
}

class TimeOutException extends BaseExceptions {
  TimeOutException()
    : super(
        message:
            'Request timeout, try again\nPlease check your internet connection!',
        debugMessage: 'Request timed out',
      );
}

class UnknownException extends BaseExceptions {
  UnknownException({String? message, String? debugMessage})
    : super(
        message: message ?? 'Something went wrong',
        debugMessage: debugMessage ?? 'Unknown error occurred',
      );
}

class AppExceptions extends BaseExceptions {
  AppExceptions({String? message, String? debugMessage})
    : super(
        message: message ?? 'Something went wrong',
        debugMessage: debugMessage ?? 'Unknown error occurred',
      );
}
