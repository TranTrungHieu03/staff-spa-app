part of 'image_bloc.dart';

@immutable
sealed class ImageState {}

final class ImageInitial extends ImageState {}

final class ImageLoading extends ImageState {}

final class ImagePicked extends ImageState {
  final File image;

  ImagePicked(this.image);
}

final class ImageValid extends ImageState {
  final File image;

  ImageValid(this.image);
}

final class ImageCrop extends ImageState {
  final File image;

  ImageCrop(this.image);
}

final class ImageInvalid extends ImageState {
  final String error;

  ImageInvalid(this.error);
}
