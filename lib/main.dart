
//main com provider em uso
// import 'package:classifields_apk_flutter/src/pages/register/register_updates_user.dart';
// import 'package:classifields_apk_flutter/src/pages/signIn/sign_in_screen.dart';
// import 'package:classifields_apk_flutter/src/pages/splashScreen/splash_screen.dart';
// import 'package:classifields_apk_flutter/src/pages/home/home.dart';
// import 'package:classifields_apk_flutter/src/services/navigator_service_without_context.dart';
// import 'package:flutter/material.dart';
// import 'package:classifields_apk_flutter/src/pages/user/list_user.dart';
// import 'package:classifields_apk_flutter/src/pages/user/user_profile.dart';
// import 'package:classifields_apk_flutter/src/Providers/user_provider.dart';
// import 'package:provider/provider.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
  
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => UserProvider())
//       ],
//       child: MaterialApp(
//         title: 'Flutter Demo',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(        
//           primarySwatch: Colors.green,
//           scaffoldBackgroundColor: Colors.white.withAlpha(230)//250 eh branco      
//         ),      
//         //home: Home(),
//         navigatorKey: NavigationService.navigatorKey,//aki para navegar sem contexto
//         initialRoute: '/splash',				
//         routes: {							        
//           '/splash': (ctx) => const SplashScreen(),
//           '/login': (ctx) => SignInScreen(),
//           '/home': (ctx) => Home(),
//           '/register': (ctx) => Register(),
//           '/listUser': (ctx) => UserListPage(),     
//           '/userProfile': (ctx) => UserProfile()    
//         },
//       ),
//     );
//   }
// }



import 'package:classifields_apk_flutter/src/pages/register/register_updates_user.dart';
import 'package:classifields_apk_flutter/src/pages/signIn/sign_in_screen.dart';
import 'package:classifields_apk_flutter/src/pages/splashScreen/splash_screen.dart';
import 'package:classifields_apk_flutter/src/pages/home/home.dart';
import 'package:classifields_apk_flutter/src/services/navigator_service_without_context.dart';
import 'package:flutter/material.dart';
import 'package:classifields_apk_flutter/src/pages/user/list_user.dart';
import 'package:classifields_apk_flutter/src/pages/user/user_profile.dart';
import 'package:classifields_apk_flutter/src/Providers/user_getX.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put<UserControllerGetx>(UserControllerGetx());
  //Get.put<OutroController>(OutroController());//ex para SE TIVER add outro controller
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(        
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white.withAlpha(230)//250 eh branco      
      ),      
      //home: Home(),
      navigatorKey: NavigationService.navigatorKey,//aki para navegar sem contexto
      initialRoute: '/splash',				
      routes: {							        
        '/splash': (ctx) => const SplashScreen(),
        '/login': (ctx) => SignInScreen(),
        '/home': (ctx) => Home(),
        '/register': (ctx) => Register(),
        '/listUser': (ctx) => UserListPage(),     
        '/userProfile': (ctx) => UserProfile()    
      },
    );
  }
}





