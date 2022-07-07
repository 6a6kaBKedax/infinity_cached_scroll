import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    Key? key,
    required this.url,
    required this.index,
  }) : super(key: key);

  final String url;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          onPressed: () async {
            await Share.share(url, subject: 'very interesting pic');
          },
          icon: const Icon(Icons.share),
        )
      ]),
      body: Center(
        child: Hero(
          tag: index,
          child: Material(
            child: CachedNetworkImage(
              imageUrl: url,
              cacheKey: index.toString(),
              errorWidget: (BuildContext context, _, __) {
                return const Icon(
                  Icons.error_outline_rounded,
                  color: Colors.red,
                );
              },
              progressIndicatorBuilder: (BuildContext context, _, DownloadProgress download) {
                return CircularProgressIndicator.adaptive(
                  value: download.progress,
                  strokeWidth: 1.5,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
