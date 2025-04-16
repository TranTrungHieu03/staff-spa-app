import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:staff_app/core/errors/failure.dart';
import 'package:staff_app/core/usecase/usecase.dart';
import 'package:staff_app/features/appointment/domain/repository/appointment_repository.dart';

class UpdateFeedbackParams {
  final int feedbackId;
  final File imageAfter;

  UpdateFeedbackParams({
    required this.feedbackId,
    required this.imageAfter,
  });

  Future<FormData> toFormData() async {
    final fileName = imageAfter.path.split('/').last;

    return FormData.fromMap({
      'feedbackId': feedbackId,
      'imageAfter': await MultipartFile.fromFile(
        imageAfter.path,
        filename: fileName,
      ),
    });
  }
}

class UpdateFeedback implements UseCase<Either<Failure, int>, UpdateFeedbackParams> {
  final AppointmentRepository repository;

  UpdateFeedback(this.repository);

  @override
  Future<Either<Failure, int>> call(UpdateFeedbackParams params) async {
    return await repository.updateFeedback(params);
  }
}
