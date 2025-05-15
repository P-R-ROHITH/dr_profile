import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String value;
  final String label;
  final String? imagePath;
  final double? imageTop;
  final double? imageRight;
  final double height;
  final bool showGradientShadow;

  const StatCard({
    super.key,
    required this.value,
    required this.label,
    this.imagePath,
    this.imageTop,
    this.imageRight,
    this.height = 85,
    this.showGradientShadow = false,
  });

  List<Color> _getGradientColors(String label) {
    switch (label) {
      case "Experience":
        return [const Color(0xFF5C4B31).withOpacity(0.5), Colors.white.withOpacity(0.0)];
      case "Rating":
        return [const Color(0xFFFFD700).withOpacity(0.5), Colors.white.withOpacity(0.0)];
      case "Patients":
        return [const Color(0xFF1E88E5).withOpacity(0.5), Colors.white.withOpacity(0.0)];
      default:
        return [Colors.black.withOpacity(0.2), Colors.white.withOpacity(0.0)];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: height,
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(128, 128, 128, 0.1),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Stack(
          children: [
            if (imagePath != null)
              Positioned(
                top: imageTop ?? 0,
                right: imageRight ?? 0,
                child: showGradientShadow
                    ? Container(
                        width: (label == "Rating" || label == "Patients") ? 46 : 38,
                        height: (label == "Rating" || label == "Patients") ? 46 : 38,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: _getGradientColors(label),
                            center: Alignment.center,
                            radius: 0.7,
                          ),
                        ),
                        child: Center(
                          child: Image.asset(
                            imagePath!,
                            height: (label == "Rating" || label == "Patients") ? 36 : 28,
                          ),
                        ),
                      )
                    : Image.asset(
                        imagePath!,
                        height: 60,
                        width: 60,
                      ),
              ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatCardsSection extends StatelessWidget {
  const StatCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        StatCard(
          value: "11 years",
          label: "Experience",
          imagePath: 'assets/suitcase.png',
          imageTop: -8,
          imageRight: 5,
          showGradientShadow: true,
        ),
        StatCard(
          value: "4.8",
          label: "Rating",
          imagePath: 'assets/star png.png',
          imageTop: -8,
          imageRight: 0,
          showGradientShadow: true,
          height: 85,
        ),
        StatCard(
          value: "100+",
          label: "Patients",
          imagePath: 'assets/patients png.png',
          imageTop: -8,
          imageRight: 0,
          showGradientShadow: true,
          height: 85,
        ),
      ],
    );
  }
}