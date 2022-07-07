import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infinity_cached_scroll/ui/screens/home_screen/detail_screen/detail_screen.dart';

class ItemTile extends StatefulWidget {
  const ItemTile({
    super.key,
    required this.url,
    required this.title,
  });

  final String url;
  final String title;

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  bool isCorrect = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: InkWell(
          onTap: () {
            if (isCorrect) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => DetailScreen(url: widget.url, title: widget.title),
                ),
              );
            }
          },
          child: Hero(
            tag: widget.title,
            ///Is used title in tag because it parameter unique
            ///Id was repeated
            child: Material(
              child: CachedNetworkImage(
                imageUrl: widget.url,
                cacheKey: widget.title,
                errorWidget: (BuildContext context, _, __) {
                  setState(()=> isCorrect = false);
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
