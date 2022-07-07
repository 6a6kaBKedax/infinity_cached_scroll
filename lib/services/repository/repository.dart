import 'package:dio/dio.dart';

import 'rest_api_requests/i_rest_api_requests.dart';

class Repository {
  static final Dio _dio = Dio();

  static final IRestApiRequests client = IRestApiRequests(_dio);
}
