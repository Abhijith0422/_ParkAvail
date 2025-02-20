import 'dart:async';
import 'package:flutter/material.dart';
import '../api/supabase_service.dart';

class RefreshableNetworkImage extends StatefulWidget {
  final String userId;
  final String initialUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  const RefreshableNetworkImage({
    super.key,
    required this.userId,
    required this.initialUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  State<RefreshableNetworkImage> createState() =>
      _RefreshableNetworkImageState();
}

class _RefreshableNetworkImageState extends State<RefreshableNetworkImage> {
  late String currentUrl;
  Timer? _refreshTimer;
  final _supabaseService = SupabaseService();

  @override
  void initState() {
    super.initState();
    currentUrl = widget.initialUrl;
    // Refresh URL every 50 minutes (before 1-hour expiration)
    _refreshTimer = Timer.periodic(
      const Duration(minutes: 50),
      (_) => _refreshImageUrl(),
    );
  }

  Future<void> _refreshImageUrl() async {
    try {
      final newUrl = await _supabaseService.refreshImageUrl(widget.userId);
      if (mounted) {
        setState(() => currentUrl = newUrl);
      }
    } catch (e) {
      debugPrint('Failed to refresh image URL: $e');
    }
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Image.network(
      currentUrl,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      errorBuilder: (context, error, stackTrace) {
        // Try refreshing URL on error
        _refreshImageUrl();
        return const Icon(Icons.broken_image);
      },
    );
  }
}
