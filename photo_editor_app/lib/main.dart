import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:provider/provider.dart';

import './provider/photos.dart';
import './screens/photo_list_screen.dart';
import './screens/auth_screen.dart';
import './screens/splash_screen.dart';
import './screens/take_photo_screen.dart';
import './screens/edit_photo_screen.dart';
import './screens/upload_photo_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Photos(),
        ),
      ],
      child: MaterialApp(
        title: 'StarLit Editor',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: const Color.fromRGBO(22, 95, 18, 1),
              secondary: const Color.fromRGBO(228, 185, 11, 1),
              background: const Color.fromRGBO(22, 95, 18, 1),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(22, 95, 18, 1),
                ),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(22, 95, 18, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color.fromRGBO(22, 95, 18, 1),
              ),
            )),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, userSnapshot) {
            // if (userSnapshot.connectionState == ConnectionState.waiting) {
            //   return SplashScreen();
            // }
            // if (userSnapshot.hasData) {
            return PhotoListScreen();
            // }
            // return AuthScreen();
          },
        ),
        routes: {
          PhotoListScreen.routeName: (context) => PhotoListScreen(),
          UploadPhotoScreen.routeName: (context) => UploadPhotoScreen(),
          TakePhotoScreen.routeName: (context) => TakePhotoScreen(),
          EditPhotoScreen.routeName: (context) => EditPhotoScreen(),
        },
      ),
    );
  }
}
