import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:staff_app/core/common/widgets/loader.dart';
import 'package:staff_app/core/common/widgets/show_snackbar.dart';
import 'package:staff_app/core/helpers/helper_functions.dart';
import 'package:staff_app/core/utils/constants/sizes.dart';
import 'package:staff_app/features/appointment/presentation/bloc/image/image_bloc.dart';

class BasicScreenImage extends StatefulWidget {
  const BasicScreenImage({super.key, required this.image});

  final File image;

  @override
  State<BasicScreenImage> createState() => _BasicScreenImageState();
}

class _BasicScreenImageState extends State<BasicScreenImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Photo")),
      body: BlocConsumer<ImageBloc, ImageState>(
        listener: (context, state) {
          if (state is ImageInvalid) {
            TSnackBar.warningSnackBar(context, message: state.error);
            // goHome();
          } else if (state is ImageValid) {
            // goSkinAnalysing(state.image);
            context.read<ImageBloc>().add(RefreshImageEvent());
          } else if (state is ImageLoading) {
            const TLoader();
          }
        },
        builder: (context, state) {
          if (state is ImagePicked) {
            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: THelperFunctions.screenHeight(context) * 0.6,
                      ),
                      child: Container(
                          width: THelperFunctions.screenWidth(context),
                          // height: THelperFunctions.screenHeight(context) * 0.6,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(TSizes.md),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(TSizes.md),
                              child: Image.file(
                                state.image,
                                fit: BoxFit.cover,
                              ))),
                    ),
                    const SizedBox(height: TSizes.md),
                    SizedBox(
                      width: THelperFunctions.screenWidth(context) * 0.5,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<ImageBloc>().add(ValidateImageEvent(state.image));
                        },
                        child: Text(AppLocalizations.of(context)!.submit),
                      ),
                    ),
                  ],
                ),
                if (state is ImageLoading) const TLoader()
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
