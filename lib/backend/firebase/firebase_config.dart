import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyC0sQD-rssMIyfLl6YQVCZzG3g5_zDUjow",
            authDomain: "sipsense-62fcd.firebaseapp.com",
            projectId: "sipsense-62fcd",
            storageBucket: "sipsense-62fcd.appspot.com",
            messagingSenderId: "836965882628",
            appId: "1:836965882628:web:4a800c7af197082f690e51",
            measurementId: "G-5JN3H9YRTD"));
  } else {
    await Firebase.initializeApp();
  }
}
