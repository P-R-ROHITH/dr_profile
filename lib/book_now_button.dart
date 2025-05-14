import 'package:flutter/material.dart';

class BookNowButton extends StatelessWidget {
  final VoidCallback? onTap;
  const BookNowButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 24,
      child: IgnorePointer(
        ignoring: false,
        child: Opacity(
          opacity: 0.9,
          child: Center(
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF4359FD),
                      Color(0xFF1458F9),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: onTap,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.93,
                    height: 64,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        ImageIcon(
                          AssetImage('assets/calender.png'),
                          size: 30,
                          color: Colors.white,
                        ),
                        SizedBox(width: 15),
                        Text(
                          'Book Now',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}