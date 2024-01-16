import 'failure.dart';

class DtoFailure implements Failure {
  @override
  final String message;

  DtoFailure({required this.message});
}
