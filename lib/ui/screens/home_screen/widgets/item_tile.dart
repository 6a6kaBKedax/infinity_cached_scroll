import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infinity_cached_scroll/ui/screens/home_screen/detail_screen/detail_screen.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({
    super.key,
    required this.url,
    required this.id,
  });

  final String url;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => DetailScreen(url: url, id: id),
              ),
            );
          },
          child: Hero(
            tag: id,
            child: Material(
              child: CachedNetworkImage(
                imageUrl: url,
                cacheKey: id.toString(),
                errorWidget: (BuildContext context, _, __) {
                  return const Icon(
                    Icons.error_outline_rounded,
                    color: Colors.red,
                  );
                },
                progressIndicatorBuilder: (BuildContext context, _, DownloadProgress download) {
                  return Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: CircularProgressIndicator.adaptive(
                      value: download.progress,
                      strokeWidth: 1.5,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
