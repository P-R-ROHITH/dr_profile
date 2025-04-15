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

/// A custom segmented control that displays all options in one big pill-shaped oval.
/// A moving oval (using AnimatedAlign) encapsulates the selected option.
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
  _PillTabBarState createState() => _PillTabBarState();
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
      // Calculate the available width to evenly size the indicator.
      double totalWidth = constraints.maxWidth;
      // Subtracting a bit of margin so that the indicator padding is included.
      double indicatorWidth = totalWidth / widget.tabs.length - 8;

      return Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          children: [
            // Moving oval indicator that animates using AnimatedAlign.
            AnimatedAlign(
              alignment: _calculateAlignment(),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Container(
                width: indicatorWidth,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            // Row of tap-able tab options.
            Row(
              children: List.generate(widget.tabs.length, (index) {
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                      if (widget.onTabChanged != null) {
                        widget.onTabChanged!(index);
                      }
                    },
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      child: Text(
                        widget.tabs[index],
                        style: TextStyle(
                          color: selectedIndex == index ? Colors.white : Colors.black,
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
    });
  }

  /// Calculates alignment for the moving indicator.
  /// For n tabs, maps selectedIndex to Alignment.x in [-1, 1].
  Alignment _calculateAlignment() {
    if (widget.tabs.length == 1) return Alignment.center;
    double x = -1.0 + (selectedIndex * 2 / (widget.tabs.length - 1));
    return Alignment(x, 0);
  }
}

/// The main doctor profile page that uses the custom PillTabBar.
/// The content below changes based on the current selection.
class DoctorProfilePage extends StatefulWidget {
  const DoctorProfilePage({super.key});

  @override
  _DoctorProfilePageState createState() => _DoctorProfilePageState();
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
      body: Column(
        children: [
          const HeaderSection(),
          const SizedBox(height: 16),
          // The custom segmented control sits within horizontal padding.
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
          // Expanded widget shows the content below based on the selected tab.
          Expanded(child: _buildTabContent()),
        ],
      ),
    );
  }
}

/// ---------------- About Tab Content ----------------
class AboutTabContent extends StatelessWidget {
  const AboutTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        DescriptionSection(),
        SizedBox(height: 20),
        SpecializationsSection(),
        SizedBox(height: 20),
        LocationSection(),
        SizedBox(height: 20),
        ReviewsSection(),
        SizedBox(height: 20),
        BookingSection(),
        SizedBox(height: 20),
      ],
    );
  }
}

/// ---------------- Availability, Experience, and Education Placeholders ----------------
class AvailabilityTabContent extends StatelessWidget {
  const AvailabilityTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Availability Information Here',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}

class ExperienceTabContent extends StatelessWidget {
  const ExperienceTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Experience Information Here',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}

class EducationTabContent extends StatelessWidget {
  const EducationTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Education Information Here',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}

/// ---------------- Header Section ----------------
class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image.
        Container(
          height: 250,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://via.placeholder.com/400x250?text=Background+Image',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Top icons: share and favorite.
        Positioned(
          top: 40,
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
        // Profile image and doctor details.
        Positioned(
          left: 16,
          right: 16,
          bottom: 16,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 36,
                  backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150?text=Profile+Photo'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Dr. KeerthiRaj',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Neurologist',
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        SizedBox(
                          width: 8,
                          height: 8,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Available Today',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellowAccent, size: 16),
                        SizedBox(width: 4),
                        Text('4.8', style: TextStyle(color: Colors.white, fontSize: 14)),
                        SizedBox(width: 16),
                        Text('11 yrs exp.', style: TextStyle(color: Colors.white, fontSize: 14)),
                        SizedBox(width: 16),
                        Text('100+ patients', style: TextStyle(color: Colors.white, fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// ---------------- Description Section ----------------
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Session Fee',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(height: 4),
                Text(
                  '₹600.00',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Online Fee',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(height: 4),
                Text(
                  '₹450.00',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}

/// ---------------- Specializations Section ----------------
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
    // List of additional services to be shown when "View More" is tapped.
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
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
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
        const Text(
          'Specializations',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Dermatology',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
        const Text(
          'Services Offered',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: services.map((service) {
            return Chip(
              backgroundColor: Colors.grey[200],
              label: Text(service),
            );
          }).toList(),
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

/// ---------------- Location Section ----------------
class LocationSection extends StatelessWidget {
  const LocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Location',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: const DecorationImage(
              image: NetworkImage('https://via.placeholder.com/400x200?text=Map+Placeholder'),
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }
}

/// ---------------- Reviews Section ----------------
class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.brown[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Bronze Badge',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Text(
                '80% of visitors recommend consulting this doctor',
                style: TextStyle(fontSize: 14),
              ),
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
              Text(
                'Rafna (ID: 72005)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Dr. KeerthiRaj provided exceptional care for my skin. I highly recommend him for anyone looking for a specialist in skin care.',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        )
      ],
    );
  }
}

/// ---------------- Booking Section ----------------
class BookingSection extends StatelessWidget {
  const BookingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Implement booking logic.
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.blue,
      ),
      child: const Text(
        'Book Now',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}