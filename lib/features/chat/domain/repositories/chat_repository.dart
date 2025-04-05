import 'package:dartz/dartz.dart';
import 'package:staff_app/core/errors/failure.dart';
import 'package:staff_app/core/usecase/usecase.dart';
import 'package:staff_app/features/chat/data/models/message_channel_model.dart';
import 'package:staff_app/features/chat/domain/usecases/send_message.dart';

abstract class ChatRepository {
  Future<Either<Failure, Stream<MessageChannelModel>>> getMessages(NoParams params);

  Future<Either<Failure, void>> sendMessage(SendMessageParams message);

  Future<Either<Failure, void>> connect();

  Future<Either<Failure, void>> disconnect();
}
