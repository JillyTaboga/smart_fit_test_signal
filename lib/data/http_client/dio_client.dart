import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_fit_test_signal/data/http_client/http_client.dart';

@Injectable(as: HttpClient)
class DioClient implements HttpClient {
  final dio = Dio();

  @override
  Future<HttpResponse> get(String url, {Map<String, String>? query}) async {
    final response = await dio.get(url, queryParameters: query);
    return HttpResponse(
      statusCode: response.statusCode,
      data: response.data,
    );
  }
}
