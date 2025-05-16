import 'package:flutter/material.dart';

class ProfilePictureWithBadge extends StatelessWidget {
  const ProfilePictureWithBadge({super.key});

  void _showZoomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: InteractiveViewer(
          child: CircleAvatar(
            radius: 120,
            backgroundImage: const AssetImage('assets/keerthi1.jpg'),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 250,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 5,
            top: 50,
            child: Material(
              color: Colors.transparent,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () => _showZoomDialog(context),
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.blue,
                      width: 3,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/keerthi1.jpg',
                      fit: BoxFit.cover,
                      width: 160,
                      height: 160,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            right: 0,
            left: -20,
            child: IgnorePointer(
              child: Image.asset(
                'assets/bronze badge png.png',
                width: 40,
                height: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}