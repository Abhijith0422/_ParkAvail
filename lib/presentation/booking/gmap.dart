import 'package:url_launcher/url_launcher.dart';

void launchGoogleMaps(double lat, double lon) async {
  final url =
      'https://www.google.com/maps/search/?api=1&query=$lat,$lon'; // Replace with your desired coordinates
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}
