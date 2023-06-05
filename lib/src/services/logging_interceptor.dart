import 'package:http/http.dart' as http;
import 'package:classifields_apk_flutter/src/controllers/sign_in_controller.dart';
import 'package:classifields_apk_flutter/src/services/navigator_service_without_context.dart';

class LoggingInterceptor extends http.BaseClient {
  final http.Client _httpClient = http.Client();

  final SignInController authController = SignInController();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final response = await _httpClient.send(request);
    print('${response.statusCode}, response.statusCode');
    if (response.statusCode == 401) {
      final newToken = await authController.refreshToken();
      final updatedRequest = http.Request(request.method, request.url);

      request.headers.forEach((name, value) {
        updatedRequest.headers[name] = value;
      });

      updatedRequest.headers['Authorization'] = 'Bearer $newToken';

      if (request is http.Request && request.body.isNotEmpty) {
        updatedRequest.body = request.body;
      }

      final resp = await _httpClient.send(updatedRequest);

      if (resp.statusCode == 401) {
        await authController.logout();
        NavigationService.pushNamedAndRemoveUntil('/login');
        //NavigationService.pushNamed('/login');
      }

      return resp;
    }

    return response;
  }
}
