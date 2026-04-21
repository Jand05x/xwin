import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show kIsWeb; 

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDFHu-DOItcroStX_6Xmb1XsEFtHIcjaLU',
    appId: '1:677104751369:web:e8e02c89fec8173d2bb9d8',
    messagingSenderId: '677104751369',
    projectId: 'xwin2-40f87',
    authDomain: 'xwin2-40f87.firebaseapp.com',
    storageBucket: 'xwin2-40f87.firebasestorage.app',
  );
}