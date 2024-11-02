import 'package:flutter/material.dart';
import 'package:food_lis/pages/app.dart'; // Файл, где описана логика главного приложения
import 'package:food_lis/pages/auth.dart'; // Страница авторизации и регистрации
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:firebase_auth/firebase_auth.dart'; // Для работы с аутентификацией
import 'package:google_fonts/google_fonts.dart';

void main() async {
  AndroidYandexMap.useAndroidViewSurface = false;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Инициализация Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
      home: _determineHomeScreen(), // Изменяем стартовый экран
    );
  }

  Widget _determineHomeScreen() {
    // Проверка, авторизован ли пользователь
    if (FirebaseAuth.instance.currentUser != null) {
      // Если пользователь уже авторизован, открываем AuthWrapper
      return const AuthWrapper();
    } else {
      // Если нет, открываем экран онбординга
      return const OnboardingScreen();
    }
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Color> _backgroundColors = [
    Colors.orange,
    Colors.white,
    Colors.orange,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        // Анимация для плавной смены фона
        duration: const Duration(milliseconds: 300),
        color: _backgroundColors[_currentIndex],
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: <Widget>[
                  _buildPage(
                    'assets/images/onboarding/экран1.png',
                    'Удобные фильтры',
                    'Находи нужный ресторан в пару кликов',
                    Colors.white,
                    Colors.white,
                  ),
                  _buildPage(
                    'assets/images/onboarding/экран2.jpg',
                    'Рестораны на карте и в списке',
                    'Выбери свой формат поиска',
                    Color.fromARGB(255, 48, 48, 48),
                    Colors.orange,
                  ),
                  _buildPage(
                    'assets/images/onboarding/экран3.png',
                    'Легкое бронирование',
                    'Бронируй лучший столик в удобное для тебя время',
                    Colors.white,
                    Colors.white,
                  ),
                ],
              ),
            ),
            _buildBottomButton(
              _currentIndex == 2 ? 'Завершить' : 'Далее',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(String imagePath, String title, String description,
      Color textColor, Color dotColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(imagePath, height: 400),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: textColor,
            ),
          ),
          const SizedBox(height: 20),
          _buildDots(dotColor),
        ],
      ),
    );
  }

  Widget _buildDots(Color dotColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300), // анимация
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: _currentIndex == index ? dotColor : Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButton(String text) {
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.only(bottom: 30), // отступ от низа экрана
      padding: const EdgeInsets.symmetric(horizontal: 40), // уменьшение ширины
      child: SizedBox(
        height: 50, // уменьшенная высота кнопки
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            side: _currentIndex == 1 // Условие для обводки, если index == 1
                ? const BorderSide(color: Colors.orange, width: 1)
                : BorderSide.none,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // закругленные углы
            ),
            padding: const EdgeInsets.symmetric(vertical: 10),
            elevation: 0, // убирает тень
          ),
          onPressed: () {
            if (_currentIndex == 2) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AuthWrapper()),
              );
            } else {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            }
          },
          child: Text(
            text,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

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
