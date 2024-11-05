import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Импорт Firestore
import 'package:google_fonts/google_fonts.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auth Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(), // Устанавливаем страницу входа как стартовую
    );
  }
}

// Страница входа
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;
  static const Color greyLight = Color.fromARGB(255, 175, 175, 175);
  static const Color mainOrange = Color.fromARGB(255, 229, 145, 18);

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  Future<void> _login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      // Логика после успешного входа
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'Пользователь с таким email не найден.';
      } else if (e.code == 'wrong-password' || e.code == "invalid-credential") {
        errorMessage = 'Неверный пароль. Попробуйте еще раз.';
      } else {
        errorMessage = 'Ошибка: ${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                    child: Text(
                      "Вход",
                      style: GoogleFonts.montserrat(
                        color: const Color.fromARGB(255, 48, 48, 48),
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      fillColor: const Color.fromARGB(255, 247, 247, 247),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: mainOrange),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                      labelText: "Email",
                      labelStyle: GoogleFonts.montserrat(color: greyLight),
                      hintText: "Name@.com",
                      hintStyle: GoogleFonts.montserrat(color: greyLight),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    obscureText: passwordVisible,
                    decoration: InputDecoration(
                      fillColor: const Color.fromARGB(255, 247, 247, 247),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: mainOrange),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                      hintText: "12345678",
                      hintStyle: GoogleFonts.montserrat(color: greyLight),
                      labelText: "Пароль",
                      labelStyle: GoogleFonts.montserrat(color: greyLight),
                      suffixIcon: IconButton(
                        color: greyLight,
                        icon: Icon(passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ResetPasswordPage()),
                          );
                        },
                        child: Text(
                          'Забыли пароль?',
                          style: GoogleFonts.montserrat(
                            color: mainOrange,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: _login,
                    style: ButtonStyle(
                      backgroundColor: const WidgetStatePropertyAll(mainOrange),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Войти',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegistrationPage()),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Еще не зарегистрировались? ', // Серая часть текста
                      style: GoogleFonts.montserrat(
                        color: greyLight,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(
                          text: 'Зарегестрироваться', // Оранжевая часть текста
                          style: GoogleFonts.montserrat(
                            color: mainOrange,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Страница регистрации
class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool passwordVisible = false;
  static const Color greyLight = Color.fromARGB(255, 175, 175, 175);
  static const Color mainOrange = Color.fromARGB(255, 229, 145, 18);

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  Future<void> _register() async {
    try {
      // Проверка правильности номера телефона
      String phoneNumber = phoneController.text.trim();
      final phoneRegExp = RegExp(r"^(\+375|8)[1-9]{1}[0-9]{8}$");

      if (!phoneRegExp.hasMatch(phoneNumber)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Введите правильный номер телефона в формате +375XXXXXXXXX')),
        );
        return;
      }

      // Регистрация пользователя
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      String uid = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': nameController.text.trim(),
        'surname': surnameController.text.trim(),
        'email': emailController.text.trim(),
        'phoneNumber': phoneController.text.trim(),
        'created': DateTime.now(),
      });

      // Логика после успешной регистрации
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'email-already-in-use') {
        errorMessage = 'Этот email уже зарегистрирован.';
      } else if (e.code == 'weak-password') {
        errorMessage =
            'Пароль слишком слабый. Используйте более надежный пароль.';
      } else {
        errorMessage = 'Ошибка: ${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: Text(
                "Регистрация",
                style: GoogleFonts.montserrat(
                  color: const Color.fromARGB(255, 48, 48, 48),
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                fillColor: const Color.fromARGB(255, 247, 247, 247),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: mainOrange),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                labelText: "Имя",
                labelStyle: GoogleFonts.montserrat(color: greyLight),
                hintText: "Григорий",
                hintStyle: GoogleFonts.montserrat(color: greyLight),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: surnameController,
              decoration: InputDecoration(
                fillColor: const Color.fromARGB(255, 247, 247, 247),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: mainOrange),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                labelText: "Фамилия",
                labelStyle: GoogleFonts.montserrat(color: greyLight),
                hintText: "Иванов",
                hintStyle: GoogleFonts.montserrat(color: greyLight),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                fillColor: const Color.fromARGB(255, 247, 247, 247),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: mainOrange),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                labelText: "Email",
                labelStyle: GoogleFonts.montserrat(color: greyLight),
                hintText: "Name@.com",
                hintStyle: GoogleFonts.montserrat(color: greyLight),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: passwordVisible,
              decoration: InputDecoration(
                fillColor: const Color.fromARGB(255, 247, 247, 247),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: mainOrange),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                hintText: "12345678",
                hintStyle: GoogleFonts.montserrat(color: greyLight),
                labelText: "Пароль",
                labelStyle: GoogleFonts.montserrat(color: greyLight),
                suffixIcon: IconButton(
                  color: greyLight,
                  icon: Icon(passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                ),
              ),
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                fillColor: const Color.fromARGB(255, 247, 247, 247),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: mainOrange),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                labelText: "Телефон",
                labelStyle: GoogleFonts.montserrat(color: greyLight),
                hintText: "+375XXXXXXXXX",
                hintStyle: GoogleFonts.montserrat(color: greyLight),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              style: ButtonStyle(
                backgroundColor: const WidgetStatePropertyAll(mainOrange),
              ),
              child: Text(
                'Зарегестрироваться',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: RichText(
                text: TextSpan(
                  text: 'Уже есть аккаунт? ', // Серая часть текста
                  style: GoogleFonts.montserrat(
                    color: greyLight,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: 'Войти', // Оранжевая часть текста
                      style: GoogleFonts.montserrat(
                        color: mainOrange,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Страница восстановления пароля
class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  static const Color greyLight = Color.fromARGB(255, 175, 175, 175);
  static const Color mainOrange = Color.fromARGB(255, 229, 145, 18);

  Future<void> _resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Инструкции по восстановлению пароля отправлены на email')),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'Пользователь с таким email не найден';
          break;
        case 'invalid-email':
          errorMessage = 'Некорректный email';
          break;
        default:
          errorMessage = 'Ошибка восстановления пароля: ${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Вход',
          style: GoogleFonts.montserrat(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 47),
                    child: Text(
                      "Забыли пароль",
                      style: GoogleFonts.montserrat(
                        color: const Color.fromARGB(255, 48, 48, 48),
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      fillColor: const Color.fromARGB(255, 247, 247, 247),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: mainOrange),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                      labelText: "Email",
                      labelStyle: GoogleFonts.montserrat(color: greyLight),
                      hintText: "Name@.com",
                      hintStyle: GoogleFonts.montserrat(color: greyLight),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: _resetPassword,
                    style: ButtonStyle(
                      backgroundColor: const WidgetStatePropertyAll(mainOrange),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Отправить пароль на почту',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
