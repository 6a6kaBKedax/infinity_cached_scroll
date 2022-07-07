import 'package:dio/dio.dart';
import 'package:infinity_cached_scroll/data/models/photo_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../../res/consts/consts.dart';

part 'i_rest_api_requests.g.dart';

@RestApi(baseUrl: Consts.baseUrl)
abstract class IRestApiRequests {
  factory IRestApiRequests(Dio dio, {String baseUrl}) = _IRestApiRequests;

  @GET("/photos")
  Future<List<PhotoModel>> getPhotos(@Query('_start') int _start, @Query('_limit') int _limit);
}
