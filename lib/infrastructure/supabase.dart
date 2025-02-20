import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseImageService {
  final supabase = Supabase.instance.client;

  Future<String?> refreshImageUrl(String path) async {
    try {
      // Force refresh the public URL with a timestamp
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final imageUrl = supabase.storage
          .from('userimages')
          .getPublicUrl('$path?v=$timestamp');

      return imageUrl;
    } catch (e) {
      print('Error refreshing image: $e');
      return null;
    }
  }
}
