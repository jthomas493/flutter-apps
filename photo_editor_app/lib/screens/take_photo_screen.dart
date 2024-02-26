import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:photo_editor_app/screens/photo_list_screen.dart';
import 'package:provider/provider.dart';

import '../provider/photos.dart';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class TakePhotoScreen extends StatefulWidget {
  static const routeName = '/take-photo';

  @override
  State<TakePhotoScreen> createState() => _TakePhotoScreenState();
}

class _TakePhotoScreenState extends State<TakePhotoScreen> {
  final _titleController = TextEditingController();

  late File _storedImage;

  Future<void> _takePicture() async {
    final ImagePicker picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }

    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedImage.copy('${appDir.path}/$fileName');

    await Provider.of<Photos>(context, listen: false)
        .addPhoto(_titleController.text, savedImage);
    Navigator.of(context).pushNamed(PhotoListScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take a New Photo'),
      ),
      body: Center(
        child: IconButton(
          icon: const Icon(
            Icons.camera_alt,
          ),
          // _savePhoto
          onPressed: _takePicture,
        ),
      ),
    );
  }
}
