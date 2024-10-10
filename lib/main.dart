import 'package:flutter/material.dart';
import 'package:food_lis/pages/app.dart'; // Файл, где описана логика главного приложения
import 'package:food_lis/pages/auth.dart'; // Страница авторизации и регистрации
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Для работы с аутентификацией

void main() async {
  AndroidYandexMap.useAndroidViewSurface = false;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Инициализация Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  final Color scaffoldBackgroundColor =
      const Color.fromARGB(255, 247, 247, 247);
  final Color bottomNavBarBackgroundColor =
      const Color.fromARGB(255, 247, 247, 247);
  final Color unselectedItemColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        splashFactory: NoSplash.splashFactory,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: bottomNavBarBackgroundColor,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: unselectedItemColor,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: AuthWrapper(), // Здесь мы проверяем состояние аутентификации
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance
          .authStateChanges(), // Отслеживаем изменения состояния авторизации
      builder: (context, snapshot) {
        // Проверяем, авторизован ли пользователь
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
                child: CircularProgressIndicator(
              color: Color.fromARGB(255, 243, 175, 79),
            )), // Загрузка данных
          );
        } else if (snapshot.hasData) {
          // Если пользователь авторизован, показываем главное приложение
          return const MyAppPage();
        } else {
          // Если пользователь не авторизован, перенаправляем на страницу авторизации
          return const AuthPage();
        }
      },
    );
  }
}
