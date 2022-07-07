import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'application/application.dart';

void main() {
  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;
  runApp(const Application());
}
