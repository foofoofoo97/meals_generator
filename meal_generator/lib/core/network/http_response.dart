/// Response describes the http Response info.
class HttpResponse<T> {
  /// Response body. may have been transformed, please refer to [ResponseType].
  T? data;

  /// Response headers.
  Map<String, List<String>>? headers;

  /// Http status code.
  int? statusCode;

  String? statusMessage;

  HttpResponse({
    required this.data,
    required this.headers,
    required this.statusCode,
    required this.statusMessage,
  });
}