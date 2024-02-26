import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:photo_editor_app/screens/photo_list_screen.dart';
import 'package:provider/provider.dart';

import '../provider/photos.dart';

class UploadPhotoScreen extends StatefulWidget {
  static const routeName = '/upload-photo';

  @override
  State<UploadPhotoScreen> createState() => _UploadPhotoScreenState();
}

class _UploadPhotoScreenState extends State<UploadPhotoScreen> {
  final _titleController = TextEditingController();
  late File _pickedImage;

  Future _selectImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _pickedImage = File(image!.path); // won't have any error now
    });
  }

  void _savePhoto() {
    Provider.of<Photos>(context, listen: false)
        .addPhoto(_titleController.text, _pickedImage);
    Navigator.of(context).pushNamed(PhotoListScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload a New Photo'),
      ),
      body: Center(
        child: IconButton(
            icon: const Icon(
              Icons.upload_file,
            ),
            // _savePhoto
            onPressed: () {
              _selectImage();
              _savePhoto();
            }
            // Navigator.of(context).pop();
            ),
      ),
    );
  }
}
