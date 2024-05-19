import 'package:flutter/cupertino.dart';
import 'package:konekto/pages/communities/community_list_page.dart';

class CategoryModalItem extends StatelessWidget {
  const CategoryModalItem(
      {super.key,
      required this.categoryName,
      required this.categoryImage,
      required this.categoryId});
  final String? categoryId;
  final String? categoryName;
  final String? categoryImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => CommunitiesList(
                          categoryId: categoryId ?? '1',
                          categoryName: categoryName ?? 'Default Category',
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
                // TODO Default network image
                Image.network(
                  categoryImage ?? '',
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
            categoryName ?? 'Default Category',
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
