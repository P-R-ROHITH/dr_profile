import 'package:flutter/material.dart';

import 'location_section.dart';
import 'main.dart';
import 'reviews/review.dart';
import 'specializations_section.dart';
import 'stat_cards_section.dart';

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
              const DescriptionSection(),
              const SizedBox(height: 20),
              const SpecializationsSection(),
              const SizedBox(height: 20),
              const LocationSection(),
              const SizedBox(height: 20),
              const ReviewsSection(),
              const SizedBox(height: 20),
              const BookingSection(),
            ],
          ),
        ),
      ],
    );
  }
}

class DescriptionSection extends StatefulWidget {
  const DescriptionSection({super.key});

  @override
  State<DescriptionSection> createState() => _DescriptionSectionState();
}

class _DescriptionSectionState extends State<DescriptionSection> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    const fullDescription =
        'Dr. KeerthiRaj is renowned for his expertise in neurology surgeries with a patient-centered approach. '
        'With over 11 years of experience, he delivers innovative care and compassionate consultation to all his patients. '
        'He specializes in treating neurological disorders, stroke management, and brain surgeries.';
    const truncatedDescription =
        'Dr. KeerthiRaj is renowned for his expertise in neurology surgeries with a patient-centered approach. '
        'With over 11 years of experience...';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isExpanded ? fullDescription : truncatedDescription,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Text(
              isExpanded ? 'Read Less' : 'Read More',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              StatCard(
                value: "₹600.00",
                imagePath: 'assets/rupee png (1).png',
                imageTop: 0,
                imageRight: 100,
                label: "Session Fee",
                height: 110,
              ),
              StatCard(
                value: "---",
                imagePath: 'assets/doctor png.png',
                imageTop: 0,
                imageRight: 100,
                label: "Online Fee",
                height: 110,
              ),
            ],
          ),
        ],
      ),
    );
  }
}