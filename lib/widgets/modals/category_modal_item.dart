import 'package:flutter/cupertino.dart';
import 'package:konekto/pages/communities/community_list_page.dart';

class CategoryModalItem extends StatelessWidget {
  const CategoryModalItem({super.key, required this.categoryName});
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => CommunitiesListPage(
                          categoryName: categoryName,
                        )));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            margin: const EdgeInsets.symmetric(vertical: 8),
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
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            categoryName,
            style: const TextStyle(
              color: CupertinoColors.black,
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
        )
      ],
    );
  }
}
