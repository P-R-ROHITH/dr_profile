import 'package:flutter/material.dart';

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
    return LayoutBuilder(builder: (context, constraints) {
      double totalWidth = constraints.maxWidth;
      double indicatorWidth = totalWidth / widget.tabs.length - 8; // Subtract a bit for margin.

      return Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.blue,
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
                  color: Colors.white,
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
                          color: selectedIndex == index ? Colors.blue : Colors.white,
                          fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.normal,
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
    });
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
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(Icons.share, color: Colors.white, size: 28),
                Icon(Icons.favorite_border, color: Colors.white, size: 28),
              ],
            ),
          ),
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

  Widget _buildTabContent() {
    switch (_selectedTab) {
      case 0:
        return const AboutTabContent();
      case 1:
        return const AvailabilityTabContent();
      case 2:
        return const ExperienceTabContent();
      case 3:
        return const EducationTabContent();
      default:
        return const AboutTabContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // TopSection displays the cover image with curved corners and top icons.
            Stack(
              clipBehavior: Clip.none, // Allow overflow for the profile picture
              children: [
                const TopSection(),
                // Add the ProfilePictureWidget here so it scrolls with the rest of the content
                Positioned(
                  top: 120, // Keep the current position
                  right: -30, // Keep the current position
                  child: const ProfilePictureWidget(),
                ),
              ],
            ),
            const SizedBox(height: 200), // Add spacing to avoid overlap with the profile picture
            const Center(
              child: Text(
                "Neurologic",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            const StatCardsSection(), // Stat cards moved down
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: PillTabBar(
                tabs: _tabs,
                initialIndex: _selectedTab,
                onTabChanged: (index) {
                  setState(() {
                    _selectedTab = index;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            _buildTabContent(),
          ],
        ),
      ),
    );
  }
}

/// Widget for an individual stat card.
class StatCard extends StatelessWidget {
  final String value;
  final String label;

  const StatCard({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(77),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget that displays 3 stat cards in a row.
class StatCardsSection extends StatelessWidget {
  const StatCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        StatCard(value: "11 yrs", label: "Experience"),
        StatCard(value: "4.8", label: "Rating"),
        StatCard(value: "100+", label: "Patients"),
      ],
    );
  }
}

/// Content for the About tab.
class AboutTabContent extends StatelessWidget {
  const AboutTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DescriptionSection(),
        const SizedBox(height: 20),
        SpecializationsSection(),
        const SizedBox(height: 20),
        const LocationSection(),
        const SizedBox(height: 20),
        const ReviewsSection(),
        const SizedBox(height: 20),
        const BookingSection(),
        const SizedBox(height: 20),
      ],
    );
  }
}

/// Placeholder widget for the Availability tab.
class AvailabilityTabContent extends StatelessWidget {
  const AvailabilityTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Availability Information Here',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

/// Placeholder widget for the Experience tab.
class ExperienceTabContent extends StatelessWidget {
  const ExperienceTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Experience Information Here',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

/// Placeholder widget for the Education tab.
class EducationTabContent extends StatelessWidget {
  const EducationTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Education Information Here',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

/// Description section with fee statcards.
class DescriptionSection extends StatelessWidget {
  const DescriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Dr. KeerthiRaj is renowned for his expertise in neurology surgeries with a patient-centered approach. With over 11 years of experience, he delivers innovative care and compassionate consultation to all his patients.',
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            StatCard(value: "₹600.00", label: "Session Fee"),
            StatCard(value: "₹450.00", label: "Online Fee"),
          ],
        )
      ],
    );
  }
}

/// Specializations section.
class SpecializationsSection extends StatelessWidget {
  const SpecializationsSection({super.key});

  final List<String> services = const [
    'Anti-Aging Treatment',
    'Scar Treatment',
    'Skin Consultant',
    'Acne/Pimples Treatment'
  ];

  @override
  Widget build(BuildContext context) {
    final List<String> additionalServices = [
      'Botox Treatment',
      'Dermal Fillers',
      'Laser Hair Removal',
      'Chemical Peel',
      'Pulsed Dye Laser Therapy',
      'Microdermabrasion',
      'Hair Transplant'
    ];

    void showMoreOptions() {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'More Services Offered',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: additionalServices
                      .map((service) => Chip(
                    label: Text(service),
                    backgroundColor: Colors.grey[200],
                  ))
                      .toList(),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Specializations', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Dermatology', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 16),
        const Text('Services Offered', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: services
              .map((service) => Chip(
            label: Text(service),
            backgroundColor: Colors.grey[200],
          ))
              .toList(),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: showMoreOptions,
            child: const Text('View More'),
          ),
        )
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
        color: Colors.pink,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/bronze badge png.png'),
          ),
          SizedBox(width: 8),
          Text('Bronze Badge Holder', style: TextStyle(fontSize: 14, color: Colors.white)),
        ],
      ),
    );
  }
}

/// Location section using an asset image.
class LocationSection extends StatelessWidget {
  const LocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Location', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: const DecorationImage(
              image: AssetImage('assets/mapimage.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }
}

/// Reviews section.
class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            BronzeBadgeWidget(),
            SizedBox(width: 16),
            Expanded(
              child: Text('80% of visitors recommend consulting this doctor', style: TextStyle(fontSize: 14)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Rafna (ID: 72005)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Dr. KeerthiRaj provided exceptional care for my skin. I highly recommend him for anyone looking for a specialist in skin care.', style: TextStyle(fontSize: 14)),
            ],
          ),
        )
      ],
    );
  }
}

/// Booking section.
class BookingSection extends StatelessWidget {
  const BookingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
    );
  }
}

/// Profile picture widget.
class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 130, // Adjust size as needed
      backgroundColor: Colors.transparent,
      child: CircleAvatar(
        radius: 130, // Slightly smaller to create a border effect
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage('assets/doctorprofilepic.png'),
      ),
    );
  }
}