import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final ref = FirebaseStorage.instance
            .ref()
            .child('${authResult.user!.uid} .jpg');

        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({
          'username': username,
          'email': email,
          'image_url': url,
        });
      }
    } catch (err) {
      var message = 'An error occured, please check your creditials';

      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ));
      setState(() {
        _isLoading = false;
      });
    }
    // catch (err) {
    //   print(err);
    //   setState(() {
    //     _isLoading = false;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'StarLit Editor',
        ),
        elevation: 0,
        foregroundColor: const Color.fromRGBO(228, 185, 11, 1),
      ),
      backgroundColor: const Color.fromRGBO(22, 95, 18, 1),
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}
