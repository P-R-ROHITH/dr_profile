import 'package:flutter/material.dart';

class EducationTabContent extends StatelessWidget {
  const EducationTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Define your timeline events here.
    final List<TimelineData> timelineItems = [
      TimelineData(
        title: "COLLEGE 1",
        subtitle: "COURSE 1",
        description: "2010 - 2014",
      ),
      TimelineData(
        title: "COLLEGE 2",
        subtitle: "COURSE 2",
        description: "2014 - 2016",
      ),
      TimelineData(
        title: "COLLEGE 3",
        subtitle: "COURSE 3",
        description: "2016 - 2018",
      ),
    ];

    return SingleChildScrollView(
      child: Stack(
        children: [
          // Timeline
          Padding(
            padding: const EdgeInsets.only(top: 0), // No space above timeline!
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: timelineItems.length,
              itemBuilder: (context, index) {
                return TimelineItemWidget(
                  data: timelineItems[index],
                  isFirst: index == 0,
                  isLast: index == timelineItems.length - 1,
                );
              },
            ),
          ),
          // Cap and COMPLETED text, positioned above the blue line
          Positioned(
            left: 2, // Changed from 10 to 7 to move the cap 3 units left
            top: 5,   // Changed from 8 to 5 to move the cap 3 units up
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/graduation cap.png',
                  width: 45,
                  height: 45,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 8),
                const Text(
                  'COMPLETED',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ],
            ),
          ),
          // Cap and COMPLETED text, positioned above the blue line
          Positioned(
            left: 2, // Changed from 10 to 7 to move the cap 3 units left
            top: 5,   // Changed from 8 to 5 to move the cap 3 units up
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/graduation cap.png',
                  width: 45,
                  height: 45,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 8),
                const Text(
                  'COMPLETED',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TimelineData {
  final String title;
  final String subtitle;
  final String description;

  TimelineData({
    required this.title,
    required this.subtitle,
    required this.description,
  });
}

class TimelineItemWidget extends StatelessWidget {
  final TimelineData data;
  final bool isFirst;
  final bool isLast;

  const TimelineItemWidget({
    Key? key,
    required this.data,
    this.isFirst = false,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Map timeline index to hospital image asset
    String? getHospitalImage() {
      if (data.title.contains("COLLEGE 1")) {
        return 'assets/hospital 1.png';
      } else if (data.title.contains("COLLEGE 2")) {
        return 'assets/hospital 2.png';
      } else if (data.title.contains("COLLEGE 3")) {
        return 'assets/hospital 3.png';
      }
      return null;
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline indicator column (much wider)
          Container(
            width: 48, // was 32, now much wider
            child: Column(
              children: [
                // Top vertical line segment
                Expanded(
                  flex: isFirst ? 2 : 1,
                  child: Container(
                    width: 4, // slightly thicker
                    color: const Color(0xFF1458F9),
                  ),
                ),
                // The blue dot
                Container(
                  width: 18, // was 12, now wider
                  height: 18,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1458F9),
                    shape: BoxShape.circle,
                  ),
                ),
                // Bottom vertical line segment
                Expanded(
                  child: Container(
                    width: 4,
                    color: isLast ? Colors.transparent : const Color(0xFF1458F9),
                  ),
                ),
              ],
            ),
          ),
          // Hospital image in a perfect square (much wider)
          if (getHospitalImage() != null)
            Container(
              width: 72, // was 48, now much wider
              height: 72,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 16, right: 4, top: 0), // increased left margin from 4 to 16
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16), // larger radius
                  child: Image.asset(
                    getHospitalImage()!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          // Timeline event details (more horizontal padding)
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 28), // more horizontal padding
              margin: const EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: const TextStyle(
                      fontSize: 18, // Increased from 13 to 18
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    data.subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.description,
                    style: const TextStyle(fontSize: 11),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Timeline indicator widget.
class TimelineIndicator extends StatelessWidget {
  final double height;
  const TimelineIndicator({super.key, this.height = 100});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 9,
            child: Container(
              width: 2,
              color: Colors.grey.shade300,
            ),
          ),
          Positioned(
            top: height / 2 - 6,
            left: 4,
            child: Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Education milestone card widget.
class EducationMilestoneCard extends StatelessWidget {
  final String collegeName;
  final String degree;
  final String duration;
  final String imageAsset;

  const EducationMilestoneCard({
    super.key,
    required this.collegeName,
    required this.degree,
    required this.duration,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline indicator
            const TimelineIndicator(height: 120),
            const SizedBox(width: 12),
            // Image on the left
            Container(
              width: 80, // Adjust the width as needed
              height: 80, // Adjust the height as needed
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(imageAsset),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12), // Spacing between image and text
            // Text on the right
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.school, color: Colors.blue),
                      SizedBox(width: 8),
                      Text(
                        "COMPLETED",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    collegeName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    degree,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    duration,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
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