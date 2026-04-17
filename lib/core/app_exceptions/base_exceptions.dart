class BaseExceptions implements Exception {
  final String message;
  final String debugMessage;

  BaseExceptions({required this.message, required this.debugMessage}):super();

  @override
  String toString() => message;
}
