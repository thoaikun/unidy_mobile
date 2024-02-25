import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:unidy_mobile/screens/authentication/login_screen.dart';

class HttpClient {
  final Client client = Client();
  final Duration timeLimit = const Duration(seconds: 10);
  String baseUri = dotenv.env['MAIN_SERVER_URL'] ??  'http://192.168.88.138:8080';
  Map<String, String>? headers;

  HttpClient({ this.headers });

  HttpClient addHeader(String key, String value) {
    headers?[key] = value;
    return this;
  }

  Future<Response> get(String path, [Map<String, dynamic>? queryParams]) {
    Uri url = Uri.parse('$baseUri/$path').replace(queryParameters: queryParams);
    return client.get(url, headers: headers).timeout(timeLimit);
  }

  Future<Response> post(String path, [Object? body]) async {
    Uri url = Uri.parse('$baseUri/$path');
    return client.post(url, headers: headers, body: body).timeout(timeLimit);
  }

  Future<Response> put(String path, [Object? body]) {
    Uri url = Uri.parse('$baseUri/$path');
    return client.put(url, headers: headers, body: body).timeout(timeLimit);
  }

  Future<Response> patch(String path, [Object? body]) {
    Uri url = Uri.parse('$baseUri/$path');
    return client.patch(url, headers: headers, body: body).timeout(timeLimit);
  }

  Future<Response> delete(String path, [Object? body]) {
    Uri url = Uri.parse('$baseUri/$path');
    return client.delete(url, headers: headers, body: body).timeout(timeLimit);
  }

  Future<StreamedResponse> uploadImage(String path, List<MultipartFile> files, [Map<String, String>? body]) {
    Uri url = Uri.parse('$baseUri/$path');
    MultipartRequest request = MultipartRequest('POST', url);
    request.headers.addAll({
      'Authorization': headers?['Authorization'] ?? '',
    });
    request.fields.addAll(body ?? {});
    request.files.addAll(files);
    return request.send();
  }

  void close() {
    client.close();
  }
}