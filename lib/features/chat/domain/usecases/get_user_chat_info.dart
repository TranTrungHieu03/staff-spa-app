import 'package:dartz/dartz.dart';
import 'package:staff_app/core/usecase/usecase.dart';
import 'package:staff_app/features/chat/domain/repositories/hub_repository.dart';

class GetUserChatInfoParams {
  final int userId;

  GetUserChatInfoParams(this.userId);
}

class GetUserChatInfo implements UseCase<Either, GetUserChatInfoParams> {
  final HubRepository _repository;

  GetUserChatInfo(this._repository);

  @override
  Future<Either> call(GetUserChatInfoParams params) async {
    return await _repository.getUserChatInfo(params);
  }
}
