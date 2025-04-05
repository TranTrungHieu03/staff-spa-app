import 'package:dartz/dartz.dart';
import 'package:staff_app/core/usecase/usecase.dart';
import 'package:staff_app/features/chat/domain/repositories/chat_repository.dart';

class GetMessages implements UseCase<Either, NoParams> {
  final ChatRepository repository;

  GetMessages(this.repository);

  @override
  Future<Either> call(NoParams params) async {
    return await repository.getMessages(params);
  }
}
