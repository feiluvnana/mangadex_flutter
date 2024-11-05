import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mangadex_flutter/core/services/local/cache_service.dart';

class CachedImage extends StatefulWidget {
  final String imageUrl;
  final String cacheKey;
  const CachedImage({super.key, required this.imageUrl, required this.cacheKey});

  @override
  State<CachedImage> createState() => _CachedImageState();
}

class _CachedImageState extends State<CachedImage> {
  bool _isSaveImageCompleted = false;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      _getCache();
    }
  }

  Future<void> _getCache() async {
    final file = CacheService.getImage(widget.cacheKey);
    if (file == null) {
      await CacheService.saveImage(widget.cacheKey, widget.imageUrl);
      _isSaveImageCompleted = true;
    } else {
      _isSaveImageCompleted = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Image.network(widget.imageUrl);
    }
    if (!_isSaveImageCompleted) {
      return const SizedBox.shrink();
    }
    return Image.file(CacheService.getImage(widget.cacheKey)!);
  }
}
