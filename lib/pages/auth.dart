import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Импорт Firestore

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController =
      TextEditingController(); // Контроллер для имени
  final TextEditingController surnameController =
      TextEditingController(); // Контроллер для фамилии
  final TextEditingController phoneController =
      TextEditingController(); // Контроллер для номера телефона

  bool isLogin = true;

  Future<void> _authenticate() async {
    try {
      if (isLogin) {
        // Вход в аккаунт
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
      } else {
        // Регистрация
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        // Получаем UID пользователя
        String uid = userCredential.user!.uid;

        // Сохраняем дополнительные данные в Firestore
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'name': nameController.text.trim(),
          'surname': surnameController.text.trim(),
          'email': emailController.text.trim(),
          'phoneNumber': phoneController.text.trim(),
          'created': DateTime.now(), // Дата создания
        });
      }
    } on FirebaseAuthException catch (e) {
      // Обработка ошибок
      print('Ошибка аутентификации: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? 'Вход' : 'Регистрация'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Пароль'),
              obscureText: true,
            ),
            if (!isLogin) ...[
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Имя'),
              ),
              TextField(
                controller: surnameController,
                decoration: InputDecoration(labelText: 'Фамилия'),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Телефон'),
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _authenticate,
              child: Text(isLogin ? 'Войти' : 'Зарегистрироваться'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isLogin = !isLogin;
                });
              },
              child:
                  Text(isLogin ? 'Создать аккаунт' : 'Уже есть аккаунт? Войти'),
            ),
          ],
        ),
      ),
    );
  }
}
