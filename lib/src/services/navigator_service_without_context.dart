
import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future<T?> push<T extends Object?>(Route<T> route) async {
    return await navigatorKey.currentState?.push(route);
  }

  static Future<T?> pushNamed<T extends Object?>(String routeName, {Object? arguments}) async {
    try{     
      return await navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
    }catch(err){
      print('erro pushname, $err');
    }
    
  }

  static void pushNamedAndRemoveUntil(String newRouteName) {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(newRouteName, (route) => false);
  }

  static void pop<T extends Object?>([T? result]) {
    navigatorKey.currentState?.pop(result);
  }
}

//NavigationService.pushNamed('/login');   
//NavigationService.pushNamed('/login', arguments: args); => com argumentos
//NavigationService.pushNamedAndRemoveUntil('/home');
//NavigationService.pop()