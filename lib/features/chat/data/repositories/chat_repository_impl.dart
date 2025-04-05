import 'package:dartz/dartz.dart';
import 'package:staff_app/core/errors/failure.dart';
import 'package:staff_app/core/usecase/usecase.dart';
import 'package:staff_app/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:staff_app/features/chat/data/models/message_channel_model.dart';
import 'package:staff_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:staff_app/features/chat/domain/usecases/send_message.dart';


class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource _remoteDataSource;

  ChatRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, void>> connect() async {
    try {
      await _remoteDataSource.connect();
      return right(null);
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> disconnect() async {
    try {
      await _remoteDataSource.disconnect();
      return right(null);
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<MessageChannelModel>>> getMessages(NoParams params) async {
    try {
      final Stream<MessageChannelModel> response = _remoteDataSource.getMessages();
      return right(response);
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendMessage(SendMessageParams message) async {
    try {
      await _remoteDataSource.sendMessage(message);
      return right(null);
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }
}
