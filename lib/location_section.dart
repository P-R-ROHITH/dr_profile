import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationSection extends StatelessWidget {
  const LocationSection({super.key});

  static const String googleMapsUrl =
      'https://www.google.com/maps/place/Medifort+Hospital/@10.9984,76.9951,17z/data=!3m1!4b1!4m6!3m5!1s0x3ba85c8e7d2e7e3b:0x7e6b2e7e3b2e7e3b!8m2!3d10.9984!4d76.9951!16s%2Fg%2F11c5z_4w1z';

  String getStaticMapUrl() {
    // Replace with your Google Static Maps API key if needed
    return 'https://maps.googleapis.com/maps/api/staticmap?center=10.9984,76.9951&zoom=16&size=600x300&markers=color:red%7C10.9984,76.9951&key=YOUR_API_KEY';
  }

  Future<void> _openGoogleMaps() async {
    final Uri url = Uri.parse(googleMapsUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $googleMapsUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE3F2FD),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Location',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: _openGoogleMaps,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                getStaticMapUrl(),
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 180,
                  color: Colors.grey[300],
                  child: const Center(child: Text('Map preview unavailable')),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.blue),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Medifort Hospital, 123 Main Street, City, State',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              TextButton(
                onPressed: _openGoogleMaps,
                child: const Text('Open in Maps'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}