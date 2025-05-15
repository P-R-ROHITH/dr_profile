import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:url_launcher/url_launcher.dart';
import 'book_now_button.dart';
import 'profile_top_section.dart';
import 'reviews/review.dart';
import 'location_section.dart';
import 'profile_pic.dart';
import 'top_section_buttons.dart';
import 'stat_cards_section.dart';
import 'about_tab.dart';
import 'specializations_section.dart';
import 'services_section.dart';
import 'availability_tab.dart';
import 'experience_tab.dart';
import 'education_tab.dart';
void main() {
  runApp(const MyApp());
}

/// The root widget.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor Profile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFE3F2FD), // Light blue background
      ),
      home: const DoctorProfilePage(),
    );
  }
}

/// A custom segmented control that displays options in a big blue pill-shaped container.
/// A white moving oval encapsulates the selected option.
class PillTabBar extends StatefulWidget {
  final List<String> tabs;
  final int initialIndex;
  final ValueChanged<int>? onTabChanged;

  const PillTabBar({
    super.key,
    required this.tabs,
    this.initialIndex = 0,
    this.onTabChanged,
  });

  @override
  State<PillTabBar> createState() => _PillTabBarState();
}

class _PillTabBarState extends State<PillTabBar> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double totalWidth = constraints.maxWidth;
        double indicatorWidth = totalWidth / widget.tabs.length - 8;

        return Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.grey[300], // Grey background for the pill
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            children: [
              AnimatedAlign(
                alignment: _calculateAlignment(),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Container(
                  width: indicatorWidth,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white, // White background for the selected tab
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              Row(
                children: List.generate(widget.tabs.length, (index) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                        widget.onTabChanged?.call(index);
                      },
                      child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        child: Text(
                          widget.tabs[index],
                          style: TextStyle(
                            color: selectedIndex == index
                                ? Colors.blue // Blue for the selected tab
                                : Colors.black, // Black for unselected tabs
                            fontWeight: selectedIndex == index
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }

  Alignment _calculateAlignment() {
    if (widget.tabs.length == 1) return Alignment.center;
    double x = -1.0 + (selectedIndex * 2 / (widget.tabs.length - 1));
    return Alignment(x, 0);
  }
}

/// A widget to display the cover photo (with curved bottom corners) and top icons.
class TopSection extends StatelessWidget {
  const TopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: Stack(
        children: [
          Image.asset(
            'assets/coverpic.jpg',
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          // All three buttons in one widget
          const TopSectionButtons(),
        ],
      ),
    );
  }
}

/// The main doctor profile page.
class DoctorProfilePage extends StatefulWidget {
  const DoctorProfilePage({super.key});

  @override
  State<DoctorProfilePage> createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  int _selectedTab = 0;
  final List<String> _tabs = ['About', 'Availability', 'Experience', 'Education'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Remove bottomNavigationBar
      body: Stack(
        children: [
          // Main scrollable content
          SingleChildScrollView(
            child: Column(
              children: [
                // Profile Section
                const ProfileTopSection(),
                // Light blue background section
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFE3F2FD),
                  ),
                  child: Column(
                    children: [
                      // Gradient Widget (copied from SpecializationsSection)
                      Container(
                        height: 50, // Adjust height as needed
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFE3F2FD), Colors.white], // Reversed: light blue to white
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      TabContentWidget(
                        selectedTab: _tabs[_selectedTab],
                        tabs: _tabs,
                        initialIndex: _selectedTab,
                        onTabChanged: (index) {
                          setState(() {
                            _selectedTab = index;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 100), // Add space at the bottom for the floating button
              ],
            ),
          ),
          // Floating Book Now button
          BookNowButton(),
          
          
        ],
      ),
    );
  }
}


/// Content for the About tab.
class AboutTabContent extends StatelessWidget {
  const AboutTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DescriptionSection(),
        const SizedBox(height: 20),
        const SpecializationsSection(),
        const SizedBox(height: 20),
        const ServicesSection(),
        const SizedBox(height: 20),
        const LocationSection(),
        const SizedBox(height: 20),
        const ReviewsSection(),
        const SizedBox(height: 20),
        const BookingSection(),
      ],
    );
  }
}
/// Bronze badge widget using an asset image within a pink oval container.
class BronzeBadgeWidget extends StatelessWidget {
  const BronzeBadgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE4E9),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/bronze badge png.png'),
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bronze Badge',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF757575),
                ),
              ),
              Text(
                'Holder',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF757575),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



/// Booking section.
class BookingSection extends StatelessWidget {
  const BookingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton(
            onPressed: () {
              // Booking logic goes here.
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              backgroundColor: Colors.blue,
            ),
            child: const Text(
              'Book Now',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 16), // Added bottom spacing
      ],
    );
  }
}


/// Widget for displaying tab content with description and icon.
class TabContentWidget extends StatelessWidget {
  final String selectedTab;
  final List<String> tabs;
  final int initialIndex;
  final ValueChanged<int>? onTabChanged;

  const TabContentWidget({
    super.key,
    required this.selectedTab,
    required this.tabs,
    this.initialIndex = 0,
    this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withAlpha(25), // 0.1 opacity ≈ 25 in alpha (0.1 * 255)
            blurRadius: 10,
       ) ],
      ),
      // Make the tab longer by increasing the minHeight
      constraints: const BoxConstraints(
        minHeight: 600, // Increase this value to make the tab longer
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Big Oval Container (PillTabBar)
          Padding(
            padding: const EdgeInsets.all(16),
            child: PillTabBar(
              tabs: tabs,
              initialIndex: initialIndex,
              onTabChanged: onTabChanged,
            ),
          ),
          const SizedBox(height: 20),
          // Tab Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildTabContent(),
          ),
          const SizedBox(height: 20),
          // Static sections
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SpecializationsSection(),
              const ServicesSection(), // Add this line
              const LocationSection(),
              const ReviewsSection(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case 'About':
        return const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DescriptionSection(),
          ],
        );
      case 'Availability':
        return const AvailabilityTabContent();
      case 'Experience':
        return const ExperienceTabContent();
      case 'Education':
        return const EducationTabContent();
      default:
        return const SizedBox.shrink();
    }
  }
}

/// Job listing card widget.
class JobListingCard extends StatelessWidget {
  final String jobTitle;
  final String institution;
  final String employmentType;
  final String duration;
  final String location;
  final String imageAsset;

  const JobListingCard({
    super.key,
    required this.jobTitle,
    required this.institution,
    required this.employmentType,
    required this.duration,
    required this.location,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120, // Increased from 60 to 80
              height: 120, // Increased from 60 to 80
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(imageAsset),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jobTitle,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    institution,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.work, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        employmentType,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        duration,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
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