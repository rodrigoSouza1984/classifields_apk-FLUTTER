import 'package:http/http.dart' as http;
import 'package:classifields_apk_flutter/src/controllers/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:classifields_apk_flutter/src/services/navigator_service_without_context.dart';

class LoggingInterceptor extends http.BaseClient {
  final http.Client _httpClient = http.Client();

  final SignInController authController = SignInController();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    print('Request: ${request.method} ${request.url}, interceptor');
    print('Headers: ${request.headers}, interceptor');

    if (request is http.Request) {
      print('Body: ${request.body}, interceptor');
    }

    final response = await _httpClient.send(request);

    if (response.statusCode == 401) {
      // Realizar a lógica para obter um novo token usando uma nova função da API
      final newToken = await authController.refreshToken();
      print('$newToken, kkkkkkk');
      // Criar uma nova instância da solicitação com os valores atualizados
      final updatedRequest = http.Request(request.method, request.url);

      // Copiar os cabeçalhos da solicitação original para a nova solicitação
      request.headers.forEach((name, value) {
        updatedRequest.headers[name] = value;
      });

      // Atualizar o cabeçalho 'Authorization' da nova solicitação com o novo token
      updatedRequest.headers['Authorization'] = 'Bearer $newToken';

      // Verificar se a solicitação original possui um corpo (body) antes de copiá-lo
      if (request is http.Request && request.body.isNotEmpty) {
        updatedRequest.body = request.body;
      }

      // Enviar a nova solicitação
      final resp = await _httpClient.send(updatedRequest);

      return resp;
    }

    print('Response: ${response.statusCode}, interceptor');
    return response;
  }
}
