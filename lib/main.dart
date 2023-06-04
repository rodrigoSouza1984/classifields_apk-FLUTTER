import 'package:classifields_apk_flutter/src/pages/register/register.dart';
import 'package:classifields_apk_flutter/src/pages/signIn/sign_in_screen.dart';
import 'package:classifields_apk_flutter/src/pages/splashScreen/splash_screen.dart';
import 'package:classifields_apk_flutter/src/pages/home/home.dart';
import 'package:classifields_apk_flutter/src/services/navigator_service_without_context.dart';
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
        scaffoldBackgroundColor: Colors.white.withAlpha(190)        
      ),      
      //home: Home(),
      navigatorKey: NavigationService.navigatorKey,//aki para navegar sem contexto
      initialRoute: '/splash',				
      routes: {							        
        '/splash': (ctx) => const SplashScreen(),
        '/login': (ctx) => SignInScreen(),
        '/home': (ctx) => Home(),
        '/register': (ctx) => Register(),
      },
    );
  }
}


