import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'home_screen.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      themeMode: themeProvider.themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.lightBlue[50],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey,
          foregroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
          titleMedium: TextStyle(color: Colors.black),
          labelLarge: TextStyle(color: Colors.black),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.black),
          hintStyle: TextStyle(color: Colors.black),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey,
            foregroundColor: Colors.white,
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey[800],
          foregroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
          labelLarge: TextStyle(color: Colors.white),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white),
          hintStyle: TextStyle(color: Colors.white70),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey[200]!),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey[700],
            foregroundColor: Colors.white,
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    double padding = screenWidth < 400 ? 16.0 : 32.0;
    double iconSize = screenWidth < 400 ? 80.0 : 120.0;
    double buttonFontSize = screenWidth < 400 ? 14.0 : 18.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Note App'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeProvider.toggleTheme(),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder(
                duration: Duration(milliseconds: 400),
                tween: Tween<double>(begin: 1.0, end: 1.05),
                builder: (context, scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: child,
                  );
                },
                child: Icon(Icons.note_add, size: iconSize, color: Colors.amber),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 500),
                        pageBuilder: (_, __, ___) => SignInScreen(),
                        transitionsBuilder: (_, anim, __, child) {
                          return FadeTransition(opacity: anim, child: child);
                        },
                      ),
                    );
                  },
                  child: Text("Sign In", style: TextStyle(fontSize: buttonFontSize)),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 500),
                        pageBuilder: (_, __, ___) => SignUpScreen(),
                        transitionsBuilder: (_, anim, __, child) {
                          return FadeTransition(opacity: anim, child: child);
                        },
                      ),
                    );
                  },
                  child: Text("Sign Up", style: TextStyle(fontSize: buttonFontSize)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// SignInScreen ve SignUpScreen kodları aynı kaldı, yukarıdaki animasyonlar sadece WelcomeScreen ve butonlara uygulandı.

// Sign In Screen
// Sign In Screen
class SignInScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void validateAndSignIn(BuildContext context) {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields")),
      );
    } else {
      bool success = AuthService.signIn(emailController.text, passwordController.text);
      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen(userEmail: emailController.text)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid credentials")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    double padding = screenWidth < 400 ? 16.0 : 32.0;
    double fontSize = screenWidth < 400 ? 14.0 : 18.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeProvider.toggleTheme(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
              ),
              SizedBox(height: 12),
              AnimatedContainer(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                ),
              ),
              SizedBox(height: 20),
              TweenAnimationBuilder(
                duration: Duration(milliseconds: 500),
                tween: Tween<double>(begin: 0.9, end: 1.0),
                builder: (context, scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: child,
                  );
                },
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => validateAndSignIn(context),
                    child: Text('Sign In', style: TextStyle(fontSize: fontSize)),
                  ),
                ),
              ),
              SizedBox(height: 10),
              AnimatedOpacity(
                duration: Duration(milliseconds: 800),
                opacity: 1,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 500),
                        pageBuilder: (_, __, ___) => SignUpScreen(),
                        transitionsBuilder: (_, anim, __, child) {
                          return FadeTransition(opacity: anim, child: child);
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Don't have an account? Sign Up",
                    style: TextStyle(fontSize: fontSize),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Sign Up Screen
class SignUpScreen extends StatelessWidget {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void validateAndSignUp(BuildContext context) {
    if (fullNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields")),
      );
    } else {
      bool success = AuthService.signUp(emailController.text, passwordController.text);
      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen(userEmail: emailController.text)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User already exists")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    double padding = screenWidth < 400 ? 16.0 : 32.0;
    double fontSize = screenWidth < 400 ? 14.0 : 18.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeProvider.toggleTheme(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                child: TextField(
                  controller: fullNameController,
                  decoration: InputDecoration(labelText: 'Full Name'),
                ),
              ),
              SizedBox(height: 12),
              AnimatedContainer(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
              ),
              SizedBox(height: 12),
              AnimatedContainer(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                ),
              ),
              SizedBox(height: 20),
              TweenAnimationBuilder(
                duration: Duration(milliseconds: 500),
                tween: Tween<double>(begin: 0.9, end: 1.0),
                builder: (context, scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: child,
                  );
                },
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => validateAndSignUp(context),
                    child: Text('Sign Up', style: TextStyle(fontSize: fontSize)),
                  ),
                ),
              ),
              SizedBox(height: 10),
              AnimatedOpacity(
                duration: Duration(milliseconds: 800),
                opacity: 1,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 500),
                        pageBuilder: (_, __, ___) => SignInScreen(),
                        transitionsBuilder: (_, anim, __, child) {
                          return FadeTransition(opacity: anim, child: child);
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Already have an account? Sign In",
                    style: TextStyle(fontSize: fontSize),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}