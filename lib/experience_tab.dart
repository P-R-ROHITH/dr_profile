import 'package:flutter/material.dart';

class ExperienceTabContent extends StatelessWidget {
  const ExperienceTabContent({super.key});

  @override
  Widget build(BuildContext context) {
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
  }
}

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
              width: 120,
              height: 120,
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