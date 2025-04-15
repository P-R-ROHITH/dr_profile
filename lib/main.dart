import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DoctorProfile(),
    );
  }
}

class DoctorProfile extends StatelessWidget {
  const DoctorProfile({super.key});

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
            SpecializationsSection(),
            LocationSection(),
            ReviewsSection(),
            BookingButton(),
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.blue[50],
      child: Row(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/doctorprofilepic.png'), // Add your image asset
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Dr. KeerthiRaj", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text("MBBS, FCPS, FACC", style: TextStyle(fontSize: 16)),
                Text("Available Today", style: TextStyle(color: Colors.green)),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text("11 years", style: TextStyle(fontSize: 16)),
                        Text("Experience", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    Column(
                      children: [
                        Text("4.8", style: TextStyle(fontSize: 16)),
                        Text("Rating", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    Column(
                      children: [
                        Text("100+", style: TextStyle(fontSize: 16)),
                        Text("Patients", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class StatsContainer extends StatelessWidget {
  const StatsContainer({super.key});


class DescriptionSection extends StatelessWidget {
  const DescriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Description", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(
            "Dr. KeerthiRaj is a highly experienced, board certified neurologist with over 11 years of expertise in neurology surgeries. His specialization includes...",
            textAlign: TextAlign.justify,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text("Session Fee", style: TextStyle(fontSize: 16)),
                  Text("₹600.00", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                children: [
                  Text("Online Fee", style: TextStyle(fontSize: 16)),
                  Text("₹450.00", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SpecializationsSection extends StatelessWidget {
  const SpecializationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Specializations", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          CheckboxListTile(
            title: Text("Dermatology"),
            value: true,
            onChanged: (bool? value) {},
          ),
          CheckboxListTile(
            title: Text("Anti-Aging Treatment"),
            value: false,
            onChanged: (bool? value) {},
          ),
          CheckboxListTile(
            title: Text("Scar Treatment"),
            value: false,
            onChanged: (bool? value) {},
          ),
          CheckboxListTile(
            title: Text("Skin consultant"),
            value: false,
            onChanged: (bool? value) {},
          ),
          CheckboxListTile(
            title: Text("Acne/Pimples Treatment"),
            value: false,
            onChanged: (bool? value) {},
          ),
          TextButton(
            onPressed: () {},
            child: Text("View more"),
          ),
        ],
      ),
    );
  }
}

class LocationSection extends StatelessWidget {
  const LocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Location", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Image.asset('assets/mapimage.jpeg'), // Add your map asset
        ],
      ),
    );
  }
}

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Patient Reviews", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Row(
            children: [
              Icon(Icons.star, color: Colors.yellow),
              Icon(Icons.star, color: Colors.yellow),
              Icon(Icons.star, color: Colors.yellow),
              Icon(Icons.star, color: Colors.yellow),
              Icon(Icons.star_border),
            ],
          ),
          SizedBox(height: 8),
          Text(
            "These feedbacks represent personal opinions and experiences of a person.",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 8),
          ListTile(
            title: Text("Rafna", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("ID 72605 - I really recommend Dr. KeerthiRaj for skin issues. She is very kind and patient-friendly."),
            trailing: Text("4/5"),
          ),
        ],
      ),
    );
  }
}

class BookingButton extends StatelessWidget {
  const BookingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          // Navigate to book an appointment
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.blue, padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20), // Text color
        ),
        child: Text("Book Now"),
      ),
    );
  }
}