import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_mentor/core/colors.dart';

class ImageCaptureMenu extends StatelessWidget {
  final void Function(File file)? onSelectImage;
  final void Function(List<File> files)? onSelectImages;
  final void Function(File file)? onSelectVideo;
  final ImagePicker picker = ImagePicker();
  final bool isMultiple;
  final bool popAfterSelect;
  final int? imageQuality;
  final Duration? maxVideoDuration;

  ImageCaptureMenu({
    Key? key,
    this.onSelectImage,
    this.onSelectImages,
    this.isMultiple = false,
    this.popAfterSelect = true,
    this.imageQuality,
    this.onSelectVideo,
    this.maxVideoDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          _MenuItem(
            icon: Icons.camera,
            label: 'Камера',
            onPress: () {
              getImage(ImageSource.camera, context, imageQuality: imageQuality);
            },
          ),
          const Divider(height: 8),
          _MenuItem(
            icon: Icons.image,
            label: 'Выбрать изображение',
            onPress: () {
              if (isMultiple == true) {
                getImages(context);
              } else {
                getImage(ImageSource.gallery, context,
                    imageQuality: imageQuality);
              }
            },
          ),
          if (onSelectVideo != null)
            _MenuItem(
              icon: Icons.videocam,
              label: 'Выбрать видео',
              onPress: () {
                getVideo(context, maxVideoDuration);
              },
            ),
        ],
      ),
    );
  }

  Future<void> getImage(ImageSource source, BuildContext context,
      {int? imageQuality}) async {
    try {
      final pickedFile =
          await picker.pickImage(source: source, imageQuality: imageQuality);

      if (pickedFile != null && onSelectImage != null) {
        onSelectImage!(File.fromUri(Uri.file(pickedFile.path)));
        if (popAfterSelect) {
          Navigator.of(context).pop();
        }
      }
    } on PlatformException catch (e) {
      if (e.code == 'camera_access_denied') {
        // Routes.router.navigate(Routes.cameraAccessDenied);
      }
    }
  }

  Future<void> getVideo(BuildContext context, Duration? maxDuration) async {
    try {
      final pickedFile = await picker.pickVideo(
          source: ImageSource.gallery, maxDuration: maxDuration);

      if (pickedFile != null && onSelectVideo != null) {
        onSelectVideo!(File(pickedFile.path));
      }
    } on PlatformException catch (e) {
      if (e.code == 'camera_access_denied') {
        // Routes.router.navigate(Routes.cameraAccessDenied);
      }
    }
  }

  Future<void> getImages(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.image,
        allowCompression: true,
      );

      List<File> list = [];

      if (result != null) {
        list = result.paths.map((path) => File(path!)).toList();
      }

      if (list.isNotEmpty && onSelectImages != null) {
        onSelectImages!(list);
        if (popAfterSelect) {
          Navigator.of(context).pop();
        }
      }
    } on Exception catch (error) {
      // serviceLocator<NotifierService>().showError(
      //   context: context,
      //   error: error,
      // );
    }
  }
}

class _MenuItem extends StatelessWidget {
  final IconData? icon;
  final String? label;
  final void Function()? onPress;

  const _MenuItem({
    Key? key,
    this.icon,
    this.label,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        child: InkWell(
          enableFeedback: true,
          onTap: () {
            if (onPress != null) {
              onPress!();
            }
          },
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Icon(
                    icon,
                    color: primaryColor,
                  ),
                ),
                Text(
                  label!,
                  style: TextStyle(
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
