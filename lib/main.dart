import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'pages/app.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
       apiKey: 'AIzaSyAOoomd6cIIp3aGCc71LyZ8zEI7wyKiFg4',
       appId: '1:791450930167:android:5606a15754605b5d8cfcf2',
       messagingSenderId: '791450930167',
       projectId: 'foodlis-46435',
       storageBucket: 'foodlis-46435.appspot.com',
  ) );
  AndroidYandexMap.useAndroidViewSurface = true;
  runApp(const MyApp());
}
