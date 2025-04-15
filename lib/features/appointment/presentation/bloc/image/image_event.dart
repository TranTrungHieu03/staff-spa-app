part of 'image_bloc.dart';

@immutable
sealed class ImageEvent {}

final class PickImageEvent extends ImageEvent {
  final bool isCamera;

  PickImageEvent(this.isCamera);
}

final class ValidateImageEvent extends ImageEvent {
  final File image;

  ValidateImageEvent(this.image);
}

final class RefreshImageEvent extends ImageEvent {}
