import 'package:classifields_apk_flutter/src/pages/signIn/sign_in_screen.dart';
import 'package:classifields_apk_flutter/src/pages/splashScreen/splash_screen.dart';
import 'package:classifields_apk_flutter/src/pages/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(        
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      //home: Home(),
      initialRoute: '/splash',				
      routes: {							        
        '/splash': (ctx) => const SplashScreen(),
        '/login': (ctx) => SignInScreen(),
        '/home': (ctx) => Home()
      },
    );
  }
}


