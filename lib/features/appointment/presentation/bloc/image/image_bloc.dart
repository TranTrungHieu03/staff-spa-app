import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:staff_app/core/logger/logger.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    on<PickImageEvent>(_onPickImage);
    on<ValidateImageEvent>(_onValidateImage);
    on<RefreshImageEvent>(_onRefreshImage);
  }

  Future<void> _onRefreshImage(RefreshImageEvent event, Emitter<ImageState> emit) async {
    emit(ImageInitial());
  }

  Future<void> _onPickImage(PickImageEvent event, Emitter<ImageState> emit) async {
    try {
      emit(ImageLoading());
      final status = await Permission.camera.status;
      if (!status.isGranted) {
        final requestStatus = await Permission.camera.request();
        if (!requestStatus.isGranted) {
          emit(ImageInvalid("Permission to access photos is denied."));
          return;
        }
      }
      if (status.isDenied || status.isPermanentlyDenied) {
        emit(ImageInvalid("Permission to access photos is denied. Please enable it in settings."));
        if (status.isPermanentlyDenied) {
          await openAppSettings();
        }
        return;
      }

      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: event.isCamera ? ImageSource.camera : ImageSource.gallery,
      );

      if (image != null) {
        final File file = File(image.path);
        emit(ImagePicked(file));
      } else {
        emit(ImageInvalid("No image selected."));
      }
    } catch (e) {
      emit(ImageInvalid("Error picking image: $e"));
    }
  }

  Future<void> _onValidateImage(ValidateImageEvent event, Emitter<ImageState> emit) async {
    try {
      emit(ImageLoading());

      final File file = event.image;

      final String extension = file.path.split('.').last.toLowerCase();
      if (extension != 'jpg' && extension != 'jpeg') {
        emit(ImageInvalid("Invalid format. Only JPG or JPEG are allowed."));
        return;
      }

      if (file.lengthSync() > 5 * 1024 * 1024) {
        emit(ImageInvalid("File size exceeds 5MB."));
        return;
      }

      final img.Image? decodedImage = img.decodeImage(file.readAsBytesSync());
      if (decodedImage == null) {
        emit(ImageInvalid("Failed to decode the image. Please check if the file is a valid image."));
        return;
      } else if (decodedImage.width < 200 || decodedImage.height < 200) {
        emit(ImageInvalid("Image resolution is too small. Minimum required resolution is 200x200 pixels."));
        return;
      } else if (decodedImage.width > 4096 || decodedImage.height > 4096) {
        AppLogger.debug("${decodedImage.width} and ${decodedImage.height}");
        final startX = (decodedImage.width - 4096) ~/ 2;
        final startY = (decodedImage.height - 4096) ~/ 2;

        final croppedImage = img.copyCrop(
          decodedImage,
          x: startX,
          y: startY,
          width: 4096,
          height: 4096,
        );

        final Directory tempDir = await getTemporaryDirectory();
        final String tempPath = '${tempDir.path}/cropped_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final File croppedImageFile = File(tempPath);

// Lưu ảnh đã cắt ra file tạm thời
        await croppedImageFile.writeAsBytes(img.encodeJpg(croppedImage));
        AppLogger.debug("${croppedImage.width} and ${croppedImage.height}");
        if (!await croppedImageFile.exists()) {
          emit(ImageInvalid("Cropped image file does not exist."));
          return;
        }
        emit(ImageValid(croppedImageFile));
        // emit(ImageInvalid(
        //     "Image resolution is too large. Maximum allowed resolution is 4096x4096 pixels."));
        return;
      }

      emit(ImageValid(event.image));
    } catch (e) {
      emit(ImageInvalid("Validation error: $e"));
    }
  }
}
