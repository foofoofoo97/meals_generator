import 'http_response.dart';

abstract class INetworkClient {
  Future<HttpResponse<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters});
}