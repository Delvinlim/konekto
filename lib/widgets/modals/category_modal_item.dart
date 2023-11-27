import 'package:flutter/cupertino.dart';

class CategoryModalItem extends StatelessWidget {
  const CategoryModalItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          margin: const EdgeInsets.all(8),
          decoration: ShapeDecoration(
            color: const Color(0xFFD9D9D9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/football.png',
                height: 50.0,
                width: 50.0,
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 6, bottom: 6),
          child: Text(
            'Football',
            style: TextStyle(
              color: CupertinoColors.black,
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
        )
      ],
    );
  }
}
