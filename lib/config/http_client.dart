import 'package:http/http.dart';

class HttpClient {
  final Client client = Client();
  String baseUri = 'http://192.168.88.138:8080';
  Map<String, String>? headers;

  HttpClient({ this.headers });

  HttpClient addHeader(String key, String value) {
    headers?[key] = value;
    return this;
  }

  Future<Response> get(String path) {
    Uri url = Uri.parse('$baseUri/$path');
    return client.get(url, headers: headers);
  }

  Future<Response> post(String path, Object? body) async {
    Uri url = Uri.parse('$baseUri/$path');
    return client.post(url, headers: headers, body: body);
  }

  Future<Response> put(String path, Object? body) {
    Uri url = Uri.parse('$baseUri/$path');
    return client.put(url, headers: headers, body: body);
  }

  Future<Response> patch(String path, Object? body) {
    Uri url = Uri.parse('$baseUri/$path');
    return client.patch(url, headers: headers, body: body);
  }

  Future<Response> delete(String path, Object? body) {
    Uri url = Uri.parse('$baseUri/$path');
    return client.delete(url, headers: headers, body: body);
  }

  void close() {
    client.close();
  }
}