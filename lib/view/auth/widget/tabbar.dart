import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({super.key, required this.onTap, required this.selected, required this.title});

  final VoidCallback onTap;
  final int selected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            Text(title),
            Container(
              height: 1,
              color: selected == 1 && title == "Sign In"? Colors.orange : Colors.grey.shade200,
              width: MediaQuery.sizeOf(context).width / 2,
            ),
          ],
        ),
      ),
    );
  }
}
