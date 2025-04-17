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
    return LayoutBuilder(
      builder: (context, constraints) {
        double totalWidth = constraints.maxWidth;
        double indicatorWidth = totalWidth / widget.tabs.length - 8;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Cover picture without padding
            Stack(
              clipBehavior: Clip.none,
              children: [
                const TopSection(),
                Positioned(
                  top: 100,
                  right: -30,
                  child: const ProfilePictureWidget(),
                ),
              ],
            ),
            // Add padding to everything else except reviews
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 16),
                  const StatCardsSection(),
                  const SizedBox(height: 16),
                  PillTabBar(
                    tabs: _tabs,
                    initialIndex: _selectedTab,
                    onTabChanged: (index) {
                      setState(() {
                        _selectedTab = index;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            // Review section without padding
            TabContentWidget(selectedTab: _tabs[_selectedTab]),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTabContent(),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Static sections that remain unchanged
        const SpecializationsSection(),
        const SizedBox(height: 20),
        const LocationSection(),
        const SizedBox(height: 20),
        const ReviewsSection(),
        const SizedBox(height: 20),
        const BookingSection(),
      ],
    );
  }

  Widget _buildTabContent() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DescriptionSection(),
        SizedBox(height: 20),
        SpecializationsSection(),
        SizedBox(height: 20),
        LocationSection(),
        SizedBox(height: 20),
        ReviewsSection(),
        SizedBox(height: 20),
        BookingSection(),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Dr. KeerthiRaj is renowned for his expertise in neurology surgeries with a patient-centered approach. With over 11 years of experience, he delivers innovative care and compassionate consultation to all his patients.',
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              StatCard(
                  value: "₹600.00",
                  imagePath: 'assets/rupee png (1).png',
                  imageTop: -10,
                  imageRight: 50,
                  label: "Session Fee"
              ),
              StatCard(
                  value: "₹450.00",
                  imagePath: 'assets/doctor png.png',
                  imageTop: -10,
                  imageRight: 50,
                  label: "Online Fee"
              ),
            ],
          )
        ],
      ),
    );
  }
}

/// Specializations section.
class SpecializationsSection extends StatefulWidget {
  const SpecializationsSection({super.key});

  @override
  State<SpecializationsSection> createState() => _SpecializationsSectionState();
}

class _SpecializationsSectionState extends State<SpecializationsSection> {
  bool showAllServices = false;

  final List<String> services = const [
    'Anti-Aging Treatment',
    'Scar Treatment',
    'Skin Consultant',
    'Acne/Pimples Treatment',
    'Neurological Disorders',
    'Stroke Treatment',
    'Headache Management',
    'Movement Disorders',
    'Epilepsy Treatment',
    'Sleep Disorders',
    'Multiple Sclerosis',
    'Brain Tumor Treatment',
    'Spine Disorders',
    'Memory Loss Treatment',
    'Parkinson\'s Disease'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
              'Specializations',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 8),
          const Text(
              'Dermatology',
              style: TextStyle(fontSize: 16)
          ),
          const SizedBox(height: 16),
          const Text(
              'Services Offered',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ...List.generate(
                showAllServices ? services.length : 4,
                    (index) => Chip(
                  label: Text(services[index]),
                  backgroundColor: Colors.grey[200],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: TextButton(
              onPressed: () {
                setState(() {
                  showAllServices = !showAllServices;
                });
              },
              child: Text(
                showAllServices ? 'Show Less' : 'View More',
                style: const TextStyle(color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
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

/// Location section using an asset image.
class LocationSection extends StatelessWidget {
  const LocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
              'Location',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
          ),
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
      ),
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
  final List<Map<String, dynamic>> reviews = [
    {
      'name': 'Rafna (ID: 72005)',
      'review': 'Dr. KeerthiRaj provided exceptional care for my skin. I highly recommend him for anyone looking for a specialist in skin care.',
      'rating': 5, // Added rating
    },
    {
      'name': 'Arjun (ID: 72006)',
      'review': 'Dr. KeerthiRaj is an excellent neurologist. His diagnosis and treatment were spot on. Highly recommended!',
      'rating': 4, // Added rating
    },
    {
      'name': 'Meera (ID: 72007)',
      'review': 'Very professional and compassionate doctor. He listens to patients carefully and provides the best care.',
      'rating': 5, // Added rating
    },
  ];

  final List<String> allFilters = [
    'All Reviews',
    'Recent',
    'Critical',
    'Positive',
    'With Photos',
    'With Rating',
    'Verified Visits',
    'Most Helpful',
  ];

  final int initialVisibleFilters = 4;
  bool showAllFilters = false;
  String selectedFilter = 'All Reviews';

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(viewportFraction: 0.75);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Patient Reviews',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    Icon(Icons.star, color: Colors.amber, size: 16),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'These feedbacks represent personal opinions and experiences of a person.',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Increased padding
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE4E9),
                        borderRadius: const BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 25, // Increased from 16 to 20
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage('assets/bronze badge png.png'),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Bronze Badge',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF757575),
                                ),
                              ),
                              SizedBox(height: 4),
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
                    ),
                    const SizedBox(width: 12), // Increased spacing
                    Container(
                      height: 32,
                      width: 1,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(width: 12), // Increased spacing
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8), // Added vertical padding
                        child: Text(
                          '• About 80% of patients recommended consulting this doctor',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Showing reviews for',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ...List.generate(
                      showAllFilters ? allFilters.length : initialVisibleFilters,
                          (index) => _buildFilterChip(allFilters[index], allFilters[index] == selectedFilter),
                    ),
                    if (!showAllFilters)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showAllFilters = true;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey[300]!, width: 1),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                'More Filters',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: 16,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                if (showAllFilters)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        showAllFilters = false;
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text('Show Less'),
                        Icon(Icons.keyboard_arrow_up, size: 16),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 220,
            child: PageView.builder(
              controller: pageController,
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: pageController,
                  builder: (context, child) {
                    double value = 0.0;
                    if (pageController.position.haveDimensions) {
                      value = pageController.page! - index;
                      value = (1 - value.abs()).clamp(0.85, 1.0);
                    }

                    return Transform.scale(
                      scale: value,
                      child: Opacity(
                        opacity: value.clamp(0.7, 1.0),
                        child: child,
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[50],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromRGBO(128, 128, 128, 0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundImage: AssetImage('assets/patients png.png'),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      reviews[index]['name']!.split(' (')[0],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      reviews[index]['name']!.split(' (')[1].replaceAll(')', ''),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: List.generate(
                                        5,
                                            (starIndex) => Icon(
                                          (reviews[index]['rating'] ?? 0) > starIndex
                                              ? Icons.star
                                              : Icons.star_border,
                                          color: Colors.amber,
                                          size: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            reviews[index]['review']!,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = label;
          filterReviews(label);
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? Border.all(color: Colors.blue, width: 1)
              : Border.all(color: Colors.grey[300]!, width: 1),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[600],
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  void filterReviews(String filter) {
    switch (filter) {
      case 'Recent':
      // Sort reviews by date
        break;
      case 'Critical':
      // Filter negative reviews
        break;
      case 'Positive':
      // Filter positive reviews
        break;
      case 'With Photos':
      // Filter reviews with photos
        break;
      default:
      // Show all reviews
        break;
    }
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

/// Widget for displaying tab content with description and icon.
class TabContentWidget extends StatelessWidget {
  final String selectedTab;

  const TabContentWidget({
    super.key,
    required this.selectedTab,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildTabContent(),
        ),
        const SizedBox(height: 20),
        // Static sections that remain unchanged
        const SpecializationsSection(),
        const SizedBox(height: 20),
        const LocationSection(),
        const SizedBox(height: 20),
        const ReviewsSection(),
        const SizedBox(height: 20),
      ],
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
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hospital image
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: const DecorationImage(
                          image: AssetImage('assets/sp medifort hosp.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Hospital name and address
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "SP Medifort Hospital",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Airport road, Eanchakkal",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                "Offline",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 45, // Reduced from 50 to 45
                          height: 45, // Reduced from 50 to 45
                          margin: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: const DecorationImage(
                              image: AssetImage('assets/mapimage.jpeg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "3 KM",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  "Timing:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    // Left column with MON-FRI and timing
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "MON - FRI",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 16,
                              color: Colors.grey[700],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "09:00AM - 06:00PM",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(width: 48),
                    // Right column with SAT-SUN and Not Available
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "SAT - SUN",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "Not Available",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(
                  height: 20,
                  thickness: 1,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      // Add calendar view functionality here
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "View Calendar",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      case 'Experience':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Work Experience',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                JobListingCard(
                  jobTitle: "Senior Neurologist",
                  institution: "Apollo Hospitals",
                  employmentType: "Full-time",
                  duration: "2020 - Present • 4 yrs",
                  location: "Bangalore, Karnataka, India",
                  imageAsset: "assets/hospital 1.png",
                ),
                SizedBox(height: 8),
                JobListingCard(
                  jobTitle: "Consultant Neurologist",
                  institution: "Columbia Asia Hospital",
                  employmentType: "Full-time",
                  duration: "2015 - 2020 • 5 yrs",
                  location: "Bangalore, Karnataka, India",
                  imageAsset: "assets/hospital 2.png",
                ),
                SizedBox(height: 8),
                JobListingCard(
                  jobTitle: "Junior Neurologist",
                  institution: "Manipal Hospitals",
                  employmentType: "Full-time",
                  duration: "2012 - 2015 • 3 yrs",
                  location: "Bangalore, Karnataka, India",
                  imageAsset: "assets/hospital 3.png",
                ),
              ],
            ),
          ],
        );
      case 'Education':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Education & Qualifications',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // First Education Card
            EducationMilestoneCard(
              collegeName: "BANGALORE MEDICAL COLLEGE",
              degree: "MBBS, Medicine",
              duration: "2010 - 2012",
              imageAsset: "assets/hospital 1.png",
            ),
            const SizedBox(height: 12),
            // Second Education Card
            EducationMilestoneCard(
              collegeName: "AIIMS DELHI",
              degree: "FCPS - Neurology",
              duration: "2013 - 2015",
              imageAsset: "assets/hospital 2.png",
            ),
            const SizedBox(height: 12),
            // Third Education Card
            EducationMilestoneCard(
              collegeName: "AMERICAN COLLEGE OF CARDIOLOGY",
              degree: "FACC",
              duration: "2016 - 2017",
              imageAsset: "assets/hospital 3.png",
            ),
          ],
        );
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
              width: 60,
              height: 60,
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
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TimelineIndicator(height: 120),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage(imageAsset),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
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
                )
              ],
            )
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