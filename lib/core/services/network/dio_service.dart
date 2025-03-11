import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:xml/xml_events.dart';

class DioService {
  final Dio _dio;

  DioService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: 'https://tvprofil.net/xmltv/data/',
          connectTimeout: Duration(seconds: 10),
          receiveTimeout: Duration(seconds: 30),
        ),
      );

  Dio get dio => _dio;

  /// Fetch XML stream from EPG source
  Future<Stream<XmlEvent>> fetchXmlStream(String endpoint) async {
    final response = await _dio.get(endpoint, options: Options(responseType: ResponseType.stream));

    return (response.data.stream as Stream)
        .cast<List<int>>()
        .transform(utf8.decoder)
        .toXmlEvents()
        .expand((event) => event);
  }
}
