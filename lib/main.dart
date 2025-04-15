import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DoctorProfile(),
    );
  }
}

class DoctorProfile extends StatelessWidget {
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
            ServicesSection(), // NEW: Services Section added here
            LocationSection(),
            ReviewsSection(),
            BookingButton(),
          ],
        ),
      ),
    );
  }
}

// 📌 Profile Header (Unchanged)
class ProfileHeader extends StatelessWidget {
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
                    Text("Dr. KeerthiRaj", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    Text("MBBS, FCPS, FACC", style: TextStyle(fontSize: 16)),
                    Text("Available Today", style: TextStyle(color: Colors.green)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StatCard(title: "Experience", value: "30 Years", icon: Icons.school, color: Colors.blue),
              StatCard(title: "Rating", value: "4.8 ★", icon: Icons.star, color: Colors.orange),
              StatCard(title: "Patients", value: "150", icon: Icons.people, color: Colors.green),
            ],
          ),
        ],
      ),
    );
  }
}

// 📌 Reusable StatCard (Unchanged)
class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  }) : super(key: key);

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
              Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}

// 📌 Description Section (Unchanged)
class DescriptionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Description", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text("Dr. KeerthiRaj is a highly experienced, board-certified neurologist with over 11 years of expertise."),
        ],
      ),
    );
  }
}

// 📌 Fee StatCards Section (Unchanged)
class FeeStatCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          LargeStatCard(title: "Session Fee", value: "₹600", icon: Icons.payment, color: Colors.blue),
          LargeStatCard(title: "Online Fee", value: "₹450", icon: Icons.wifi, color: Colors.green),
        ],
      ),
    );
  }
}

// 📌 Reusable Large StatCard (Unchanged)
class LargeStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const LargeStatCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 40),
              SizedBox(height: 12),
              Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 6),
              Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}

// 📌 Specializations Section (Unchanged)
class SpecializationsSection extends StatelessWidget {
  final List<String> specializations = [
    "Dermatology", // Specialization
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Specializations", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Column(
            children: specializations.map((specialization) => SpecializationTile(specialization)).toList(),
          ),
        ],
      ),
    );
  }
}

class SpecializationTile extends StatelessWidget {
  final String specialization;

  const SpecializationTile(this.specialization, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.check_circle, color: Colors.blue),
      title: Text(specialization, style: TextStyle(fontSize: 16)),
    );
  }
}

// 📌 NEW: Services Section with ExpansionTile
class ServicesSection extends StatelessWidget {
  final List<String> services = [
    "Consultation",
    "Skin Treatment",
    "Scar Removal",
    "Anti-aging Therapy",
    "Neurology Surgeries"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Services Provided", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ExpansionTile(
              title: Text("Click to view services", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              children: services.map((service) => ListTile(title: Text(service))).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// 📌 Location Section (Placeholder)
class LocationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text("Location", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }
}

// 📌 Reviews Section (Placeholder)
class ReviewsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text("Patient Reviews", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }
}

// 📌 Booking Button
class BookingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.blue, padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20)),
        child: Text("Book Now"),
      ),
    );
  }
}