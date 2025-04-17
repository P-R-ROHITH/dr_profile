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
class TopSection extends StatefulWidget {
  const TopSection({super.key});

  @override
  State<TopSection> createState() => _TopSectionState();
}

class _TopSectionState extends State<TopSection> {
  bool isFavorited = false; // Track the state of the favorites button

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
          // Back button
          Positioned(
            top: 16,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
              onPressed: () {
                Navigator.pop(context); // Navigate back when pressed
              },
            ),
          ),
          // Share and Favorites buttons
          Positioned(
            top: 16,
            right: 16,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.share, color: Colors.white, size: 28),
                  onPressed: () {
                    // Add share functionality here
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Share button clicked!')),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    isFavorited ? Icons.favorite : Icons.favorite_border,
                    color: isFavorited ? Colors.red : Colors.white,
                    size: 28,
                  ),
                  onPressed: () {
                    setState(() {
                      isFavorited = !isFavorited; // Toggle the favorite state
                    });
                  },
                ),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12), // Reduced width by increasing horizontal padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // TopSection displays the cover image with curved corners and top icons.
              Stack(
                clipBehavior: Clip.none, // Allow overflow for the profile picture
                children: [
                  const TopSection(),
                  Positioned(
                    top: 100, // Keep the current position
                    right: -30, // Keep the current position
                    child: const ProfilePictureWidget(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Neurologic",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Dr. Keerthi Raj",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "MBBS, FCPS, FACC",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.circle, color: Colors.green, size: 12),
                        const SizedBox(width: 8),
                        const Text(
                          "Available now",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
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
      ),
    );
  }
}

/// Widget for an individual stat card.
class StatCard extends StatelessWidget {
  final String value;
  final String label;
  final String? imagePath;
  final double? imageTop;
  final double? imageRight;

  const StatCard({
    super.key,
    required this.value,
    required this.label,
    this.imagePath,
    this.imageTop,
    this.imageRight,
  });

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
              color: const Color.fromRGBO(128, 128, 128, 0.2), // Updated to use Color.fromRGBO
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Stack(
          children: [
            if (imagePath != null)
              Positioned(
                top: imageTop ?? 0,
                right: imageRight ?? 0,
                child: Image.asset(
                  imagePath!,
                  height: 40,
                  width: 40,
                ),
              ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
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
        StatCard(
          value: "11 yrs",
          label: "Experience",
          imagePath: 'assets/suitcase.png', // Replace with your image path
          imageTop: -10, // Adjust the vertical position
          imageRight: 20 , // Adjust the horizontal position
        ),
        StatCard(
          value: "4.8",
          label: "Rating",
          imagePath: 'assets/star png.png', // Replace with your image path
          imageTop: -10,
          imageRight: 20,
        ),
        StatCard(
          value: "100+",
          label: "Patients",
          imagePath: 'assets/patients png.png', // Replace with your image path
          imageTop: -10,
          imageRight: 20,
        ),
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
            StatCard(value: "₹600.00",
                imagePath: 'assets/rupee png (1).png',
                imageTop: -10,
                imageRight: 50,
                label: "Session Fee"),
            StatCard(value: "₹450.00",
                imagePath: 'assets/doctor png.png',
                imageTop: -10,
                imageRight: 50,
                label: "Online Fee"),
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
      'Anti-Aging Treatment',
      'Scar Treatment',
      'Botox Treatment',
      'Skin Consultant',
      'Acne/Pimples Treatment'
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
class ReviewsSection extends StatefulWidget {
  const ReviewsSection({super.key});

  @override
  State<ReviewsSection> createState() => _ReviewsSectionState();
}

class _ReviewsSectionState extends State<ReviewsSection> {
  final List<Map<String, String>> reviews = [
    {
      'name': 'Rafna (ID: 72005)',
      'review':
      'Dr. KeerthiRaj provided exceptional care for my skin. I highly recommend him for anyone looking for a specialist in skin care.',
    },
    {
      'name': 'Arjun (ID: 72006)',
      'review':
      'Dr. KeerthiRaj is an excellent neurologist. His diagnosis and treatment were spot on. Highly recommended!',
    },
    {
      'name': 'Meera (ID: 72007)',
      'review':
      'Very professional and compassionate doctor. He listens to patients carefully and provides the best care.',
    },
  ];

  final List<String> filters = [
    'All',
    'Recents',
    'Positive',
    'Negative',
    'Detailed',
    'Short',
    'Verified',
    'Unverified',
    '5 Stars',
    '4 Stars',
    '3 Stars',
    '2 Stars',
    '1 Star'
  ];

  final Set<String> selectedFilters = {}; // Track selected filters

  void toggleFilter(String filter) {
    setState(() {
      if (filter == 'All') {
        // If "All" is selected, deselect all other filters
        if (selectedFilters.contains('All')) {
          selectedFilters.remove('All');
        } else {
          selectedFilters.clear();
          selectedFilters.add('All');
        }
      } else {
        // If any other filter is selected, deselect "All"
        selectedFilters.remove('All');

        // Prevent both "Positive" and "Negative" from being selected simultaneously
        if (filter == 'Positive' && selectedFilters.contains('Negative')) {
          selectedFilters.remove('Negative');
        } else if (filter == 'Negative' && selectedFilters.contains('Positive')) {
          selectedFilters.remove('Positive');
        }

        // Toggle the selected filter
        if (selectedFilters.contains(filter)) {
          selectedFilters.remove(filter);
        } else {
          selectedFilters.add(filter);
        }
      }
    });
  }

  void showMoreFilters() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'More Filters',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: filters.skip(3).map((filter) {
                  final isSelected = selectedFilters.contains(filter);
                  return ChoiceChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (_) {
                      toggleFilter(filter);
                      Navigator.pop(context); // Close the modal after selection
                    },
                    selectedColor: Colors.blue[100],
                    backgroundColor: Colors.grey[200],
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayedFilters = filters.take(3).toList(); // Always show the first 3 filters

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Reviews',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Showing reviews for:',
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Wrap(
              spacing: 8,
              children: displayedFilters.map((filter) {
                final isSelected = selectedFilters.contains(filter);
                return ChoiceChip(
                  label: Text(filter),
                  selected: isSelected,
                  onSelected: (_) => toggleFilter(filter),
                  selectedColor: Colors.blue[100],
                  backgroundColor: Colors.grey[200],
                );
              }).toList(),
            ),
            TextButton(
              onPressed: showMoreFilters,
              child: const Text('View More'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: reviews.map((review) {
              return Container(
                width: 300, // Adjust width as needed
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.lightBlue[50], // Apply light blue background color
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromRGBO(128, 128, 128, 0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 24, // Adjust size as needed
                      backgroundImage: AssetImage('assets/patients png.png'), // Replace with actual profile picture
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review['name']!.split(' (')[0], // Extract name before ID
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            review['name']!.split(' (')[1].replaceAll(')', ''), // Extract ID
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            review['review']!,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
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
      radius: 150, // Adjust size as needed
      backgroundColor: Colors.transparent,
      child: CircleAvatar(
        radius: 150, // Slightly smaller to create a border effect
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage('assets/doctorprofilepic.png'),
      ),
    );
  }
}