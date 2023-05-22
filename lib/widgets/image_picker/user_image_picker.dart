import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({Key? key}) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? galleryImage;
  Future pickImage(ImageSource source) async {
    final galleryImage = await ImagePicker().pickImage(source: source);
    if (galleryImage == null) return;

    final imageTemporary = File(galleryImage.path);
    this.galleryImage = imageTemporary;
    setState(() => this.galleryImage = imageTemporary);
  }

  void showMyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('change profile picture'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                      onPressed: () => pickImage(ImageSource.camera),
                      child: const Icon(
                        Icons.camera,
                        semanticLabel: 'camera',
                      )),
                  const Text('camera'),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                      onPressed: () => pickImage(ImageSource.gallery),
                      child: const Icon(
                        Icons.photo_library_outlined,
                        semanticLabel: 'from Gallery',
                      )),
                  const Text('from Gallery'),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showMyDialog(context),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.deepPurple, width: 3),
          borderRadius: BorderRadius.circular(50),
        ),
        child: CircleAvatar(
          child: galleryImage == null
              ? const Icon(Icons.person)
              : ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.file(
                    galleryImage!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      ),
    );
  }
}
