import 'failure.dart';

class ApiFailure implements Failure {
  @override
  final String message;

  ApiFailure({required this.message});
}
