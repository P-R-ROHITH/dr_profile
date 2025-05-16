import 'package:flutter/material.dart';

class CalendarButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const CalendarButton({super.key, this.onPressed});

  void _defaultOnPressed(BuildContext context) {
    // Placeholder for calendar functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Calendar functionality will be implemented here')),
    );
    
    // TODO: Implement actual calendar view functionality
    print('Calendar button pressed - implement calendar view');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed != null ? onPressed!() : _defaultOnPressed(context),
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
          ),
        ],
      ),
    );
  }
}