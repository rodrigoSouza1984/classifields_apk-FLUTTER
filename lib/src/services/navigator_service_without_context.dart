
import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future<T?> push<T extends Object?>(Route<T> route) async {
    return await navigatorKey.currentState?.push(route);
  }

  static Future<T?> pushNamed<T extends Object?>(String routeName, {Object? arguments}) async {
    return await navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  static void pop<T extends Object?>([T? result]) {
    navigatorKey.currentState?.pop(result);
  }
}

//NavigationService.pushNamed('/login');   
//NavigationService.pop()