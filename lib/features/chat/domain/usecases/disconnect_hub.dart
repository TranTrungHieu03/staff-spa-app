import 'package:dartz/dartz.dart';
import 'package:staff_app/core/errors/failure.dart';
import 'package:staff_app/core/usecase/usecase.dart';
import 'package:staff_app/features/chat/domain/repositories/chat_repository.dart';

class DisconnectHub implements UseCase<Either, NoParams> {
  final ChatRepository repository;

  DisconnectHub(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.disconnect();
  }
}
