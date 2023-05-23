import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({Key? key}) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  final ref = FirebaseStorage.instance.ref();
  final users = FirebaseFirestore.instance.collection('users');

  File? galleryImage;
  Future pickImage(ImageSource source) async {
    final galleryImage =
        await ImagePicker().pickImage(source: source, imageQuality: 50);
    if (galleryImage == null) return;

    final imageTemporary = File(galleryImage.path);
    this.galleryImage = imageTemporary;
    setState(() {
      this.galleryImage = imageTemporary;
    });

    //add picked image to the firebase storage
    String pickedImagePath = galleryImage.path;
    addPickedImageToTheFirebaseStorage(pickedImagePath);
  }

  User? user = FirebaseAuth.instance.currentUser;
  void addPickedImageToTheFirebaseStorage(String imagePath) async {
    final userProfilePhotoRef = ref
        .child('users_images')
        .child(user!.uid)
        .child('user_images')
        .child('user_profile_image.jpg');
    await userProfilePhotoRef.putFile(File(imagePath));

    final url = await ref
        .child('users_images')
        .child(user!.uid)
        .child('user_images')
        .child('${user!.email}.jpg')
        .getDownloadURL();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .update({'image_url': url});
    user!.updatePhotoURL(url);
  }

  void showMyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('change profile picture', style: TextStyle(fontSize: 20),),
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
          // actions: [
          //   TextButton(
          //     child: const Text('Close'),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          // ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => showMyDialog(context),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.deepPurple, width: 3),
              borderRadius: BorderRadius.circular(50),
            ),
            child: CircleAvatar(
              child: galleryImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        galleryImage!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    )
                  : user!.photoURL != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            user!.photoURL!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Icon(Icons.person),
            ),
          ),
        ),
      ],
    );
  }
}