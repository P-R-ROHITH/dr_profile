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
      // Divide available width evenly among tabs (subtracting a little margin).
      double indicatorWidth = totalWidth / widget.tabs.length - 8;

      return Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.blue, // Big container is blue.
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          children: [
            // Animated white oval indicator under the selected tab.
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
            // Row of tap-able tab options.
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

  /// Maps the selected index to an Alignment value.
  Alignment _calculateAlignment() {
    if (widget.tabs.length == 1) return Alignment.center;
    double x = -1.0 + (selectedIndex * 2 / (widget.tabs.length - 1));
    return Alignment(x, 0);
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
      // Wrap the entire page in a SingleChildScrollView so it is scrollable.
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Cover image at the very top using asset.
            Image.asset(
              'assets/coverpic.jpg',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const HeaderSection(),
            const SizedBox(height: 16),
            const StatCardsSection(),
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
              // Using withAlpha instead of withOpacity to avoid precision loss.
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

/// Placeholder widget for Availability tab content.
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

/// Placeholder widget for Experience tab content.
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

/// Placeholder widget for Education tab content.
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

/// Header section using asset images.
class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Header background image from assets.
        Container(
          height: 250,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/header_bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Top row icons.
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
                  // Using the doctor profile asset.
                  backgroundImage: AssetImage('assets/doctorprofilepic.png'),
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
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
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
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                          ),
                        ),
                        SizedBox(width: 4),
                        Text('Available Today', style: TextStyle(fontSize: 14, color: Colors.white)),
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
        // Two statcards for fee details.
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

/// Bronze badge widget using an asset image.
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
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/bronze badge png.png'),
          ),
          const SizedBox(width: 8),
          const Text('Bronze Badge Holder', style: TextStyle(color: Colors.white, fontSize: 14)),
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
              Text(
                'Rafna (ID: 72005)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
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
        // Implement booking logic.
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