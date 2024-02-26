import 'dart:io';

import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

import '../widgets/image_input.dart';

class EditPhotoScreen extends StatefulWidget {
  static const routeName = '/edit-photo';

  @override
  State<EditPhotoScreen> createState() => _EditPhotoScreenState();
}

class _EditPhotoScreenState extends State<EditPhotoScreen> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController creatorText = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();

  File? _pickedPhoto;

  void _selectPhoto(File pickedPhoto) {
    _pickedPhoto = pickedPhoto;
  }

  @override
  Widget build(BuildContext context) {
    // final selectedPhoto =
    //     Provider.of<GreatPhoto>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editor'),
      ),
      body: ListView(
        children: <Widget>[
          ImageInput(_selectPhoto),
          const CustomScrollView(
            scrollDirection: Axis.horizontal,
            slivers: <Widget>[
              SliverAppBar(
                title: Text('Holder'),
                pinned: true,
              ),
              // Placeholder(child: Text('Number 1')),
              // Placeholder(child: Text('Number 2')),
              // Placeholder(child: Text('Number 3'))
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromRGBO(22, 95, 18, 1),
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            IconButton(
              color: const Color.fromRGBO(228, 185, 11, 1),
              tooltip: 'Open navigation menu',
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
            IconButton(
              color: const Color.fromRGBO(228, 185, 11, 1),
              tooltip: 'Search',
              icon: const Icon(Icons.search),
              onPressed: () {
                TextFormField();
              },
            ),
          ],
        ),
      ),
    );
  }
}
