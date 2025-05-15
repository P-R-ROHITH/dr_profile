import 'package:flutter/material.dart';

class ProfilePictureWithBadge extends StatelessWidget {
  const ProfilePictureWithBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 250,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Profile picture with blue border
          Positioned(
            left: 5,
            top: 50,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.blue,
                  width: 3,
                ),
              ),
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Colors.transparent,
                backgroundImage: const AssetImage('assets/keerthi1.jpg'),
              ),
            ),
          ),
          // Bronze badge
          Positioned(
            bottom: 15,
            right: 0,
            left: -20,
            child: Image.asset(
              'assets/bronze badge png.png',
              width: 40,
              height: 40,
            ),
          ),
        ],
      ),
    );
  }
}