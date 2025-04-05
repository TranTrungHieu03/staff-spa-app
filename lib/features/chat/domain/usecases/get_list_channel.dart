import 'package:dartz/dartz.dart';
import 'package:staff_app/core/usecase/usecase.dart';
import 'package:staff_app/features/chat/domain/repositories/hub_repository.dart';

class GetListChannelParams {
  final String customerId;

  GetListChannelParams(this.customerId);
}

class GetListChannel implements UseCase<Either, GetListChannelParams> {
  final HubRepository _repository;

  GetListChannel(this._repository);

  @override
  Future<Either> call(GetListChannelParams params) async {
    return await _repository.getChannelList(params);
  }
}
