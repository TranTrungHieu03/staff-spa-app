import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:staff_app/core/errors/failure.dart';
import 'package:staff_app/core/usecase/usecase.dart';
import 'package:staff_app/features/appointment/domain/repository/appointment_repository.dart';

class SubmitFeedbackParams {
  final File imageBefore;
  final String appointmentId;
  final String note;
  final int customerId;
  final int staffId;

  SubmitFeedbackParams({
    required this.imageBefore,
    required this.appointmentId,
    required this.note,
    required this.customerId,
    required this.staffId,
  });

  Future<FormData> toFormData() async {
    final fileName = imageBefore.path.split('/').last;

    return FormData.fromMap({
      'imageBefore': await MultipartFile.fromFile(
        imageBefore.path,
        filename: fileName,
      ),
      'appointmentId': appointmentId,
      'note': note,
      'customerId': customerId,
      'staffId': staffId,
    });
  }
}

class SubmitFeedback implements UseCase<Either<Failure, int>, SubmitFeedbackParams> {
  final AppointmentRepository repository;

  SubmitFeedback(this.repository);

  @override
  Future<Either<Failure, int>> call(SubmitFeedbackParams params) async {
    return await repository.submitFeedback(params);
  }
}
