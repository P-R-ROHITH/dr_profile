import 'package:flutter/material.dart';

class ServicesSection extends StatefulWidget {
  const ServicesSection({super.key});

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection> {
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
    return Container(
      color: const Color(0xFFE3F2FD),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Services Offered',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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