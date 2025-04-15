import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // No const here for simplicity.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DoctorProfile(),
    );
  }
}

class DoctorProfile extends StatelessWidget {
  const DoctorProfile({super.key});

  // No const here for simplicity.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Profile'),
        backgroundColor: Colors.lightBlue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ProfileHeader(),
            DescriptionSection(),
            FeeStatCards(),
            SpecializationsSection(),
            ServicesSection(),
            LocationSection(),
            ReviewsSection(),
            BronzeBadgeSection(), // Bronze badge now placed above the Book Now button.
            BookingButton(),
          ],
        ),
      ),
    );
  }
}

// ------------------ PROFILE HEADER SECTION ------------------
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.blue[50],
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/doctorprofilepic.png'),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dr. KeerthiRaj",
                      style:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text("MBBS, FCPS, FACC", style: TextStyle(fontSize: 16)),
                    Text("Available Today",
                        style: TextStyle(color: Colors.green)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StatCard(
                  title: "Experience",
                  value: "30 Years",
                  icon: Icons.school,
                  color: Colors.blue),
              StatCard(
                  title: "Rating",
                  value: "4.8 ★",
                  icon: Icons.star,
                  color: Colors.orange),
              StatCard(
                  title: "Patients",
                  value: "150",
                  icon: Icons.people,
                  color: Colors.green),
            ],
          ),
        ],
      ),
    );
  }
}

// ------------------ STAT CARD WIDGET ------------------
class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 36),
              SizedBox(height: 12),
              Text(title,
                  style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text(value,
                  style:
                  TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------ DESCRIPTION SECTION ------------------
class DescriptionSection extends StatelessWidget {
  const DescriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Description",
              style:
              TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text("Dr. KeerthiRaj is a highly experienced, board-certified neurologist with over 11 years of expertise."),
        ],
      ),
    );
  }
}

// ------------------ FEE STAT CARDS SECTION ------------------
class FeeStatCards extends StatelessWidget {
  const FeeStatCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          LargeStatCard(
              title: "Session Fee",
              value: "₹600",
              icon: Icons.payment,
              color: Colors.blue),
          LargeStatCard(
              title: "Online Fee",
              value: "₹450",
              icon: Icons.wifi,
              color: Colors.green),
        ],
      ),
    );
  }
}

// ------------------ LARGE STAT CARD WIDGET ------------------
class LargeStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const LargeStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 5,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding:
          const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 40),
              SizedBox(height: 12),
              Text(title,
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 6),
              Text(value,
                  style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------ SPECIALIZATIONS SECTION ------------------
class SpecializationsSection extends StatelessWidget {
  final List<String> specializations = const ["Dermatology"];

  const SpecializationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Specializations",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Column(
            children: specializations
                .map((specialization) =>
                ListTile(title: Text(specialization)))
                .toList(),
          ),
        ],
      ),
    );
  }
}

// ------------------ SERVICES SECTION WITH EXPANSION TILE ------------------
class ServicesSection extends StatelessWidget {
  final List<String> services = const [
    "Consultation",
    "Skin Treatment",
    "Scar Removal",
    "Anti-aging Therapy",
    "Neurology Surgeries"
  ];

  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ExpansionTile(
          title: Text("Click to view services",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold)),
          children: services
              .map((service) => ListTile(title: Text(service)))
              .toList(),
        ),
      ),
    );
  }
}

// ------------------ LOCATION SECTION WITH ROUNDED IMAGE BUTTON ------------------
class LocationSection extends StatelessWidget {
  const LocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Location",
              style:
              TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              // Placeholder action when location image is clicked.
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/mapimage.jpeg',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------ REVIEWS SECTION ------------------
class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text("Patient Reviews",
          style:
          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }
}

// ------------------ BRONZE BADGE SECTION WITH PINK OVAL BACKGROUND ------------------
class BronzeBadgeSection extends StatelessWidget {
  const BronzeBadgeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Pink oval background container
          Container(
            width: 150,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.pinkAccent,
              borderRadius: BorderRadius.circular(40), // Oval shape
            ),
            child: Center(
              child: Image.asset(
                'assets/bronze badge png.png',
                width: 145,
                height: 145,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "About 80% of the visitors recommended consulting this doctor.",
              style:
              TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------ BOOKING BUTTON ------------------
class BookingButton extends StatelessWidget {
  const BookingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
        child: Text("Book Now",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}