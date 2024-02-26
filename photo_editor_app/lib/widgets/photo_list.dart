import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../provider/photos.dart';

class PhotoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.value(FirebaseAuth.instance.currentUser),
        builder: (context, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                  color: Color.fromRGBO(228, 185, 11, 1)),
            );
          }
          return FutureBuilder(
              future: Provider.of<Photos>(context, listen: false).fetchImages(),
              builder: (context, snapshot) => snapshot.connectionState ==
                      ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    )
                  : Consumer<Photos>(
                      child: const Center(
                        child: Text('No Images yet, take some pictures!'),
                      ),
                      builder: (context, greatPhotos, child) => greatPhotos
                              .items.isEmpty
                          ? const Center(
                              child: Text(
                                  'There are no images yet, take some pictures'),
                            )
                          : PhotoViewGallery.builder(
                              itemCount: greatPhotos.items.length,
                              scrollPhysics: const BouncingScrollPhysics(),
                              builder: (BuildContext context, i) {
                                return PhotoViewGalleryPageOptions(
                                  imageProvider:
                                      FileImage(greatPhotos.items[i].photo),
                                  initialScale:
                                      PhotoViewComputedScale.contained * 0.8,
                                  heroAttributes: PhotoViewHeroAttributes(
                                      tag: greatPhotos.items[i].id),
                                );
                              },
                              backgroundDecoration:
                                  const BoxDecoration(color: Colors.white),
                              loadingBuilder: (context, event) => Center(
                                child: Container(
                                  width: 20.0,
                                  height: 20.0,
                                  child: CircularProgressIndicator(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ),
                            ),
                    ));
        });
  }
}
