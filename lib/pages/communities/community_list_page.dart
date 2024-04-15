import 'package:flutter/cupertino.dart';

import '../../widgets/card/communities_card_widget.dart';

class CommunitiesList extends StatefulWidget {
  const CommunitiesList({super.key, required this.categoryName});
  final String categoryName;

  @override
  State<CommunitiesList> createState() => _CommunitiesListState();
}

class _CommunitiesListState extends State<CommunitiesList> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // Uncomment to change the background color
      // backgroundColor: CupertinoColors.systemPink,
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.categoryName),
        leading: CupertinoNavigationBarBackButton(
          color: CupertinoColors.black,
          onPressed: () => Navigator.of(context).pop(context),
        ),
      ),
      child: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView(children: const [
            CommunitiesCard(
              communityName: 'Aberdeen FC',
              communityImage: 'assets/images/football_team/aberdeen.png',
              communitySince: '2020',
            ),
            // CommunitiesCard(
            //   communityName: 'Chelsea FC',
            //   communityImage: 'assets/images/football_team/chelsea.png',
            // ),
            // CommunitiesCard(
            //   communityName: 'Aldenaire',
            //   communityImage: 'assets/images/football_team/aldenaire.png',
            // ),
            // CommunitiesCard(
            //   communityName: 'Waterloo FC',
            //   communityImage: 'assets/images/football_team/waterloo.png',
            // ),
            // CommunitiesCard(
            //   communityName: 'Keithston FC',
            //   communityImage: 'assets/images/football_team/keithston.png',
            // ),
            // CommunitiesCard(
            //   communityName: 'Deagleders FC',
            //   communityImage: 'assets/images/football_team/deagleders.png',
            // ),
            // CommunitiesCard(
            //   communityName: 'Southside Eagles FC',
            //   communityImage: 'assets/images/football_team/southside.png',
            // ),
            // CommunitiesCard(
            //   communityName: 'L.F.C',
            //   communityImage: 'assets/images/football_team/llfc.png',
            // ),
            // CommunitiesCard(
            //   communityName: 'Golden Common FC',
            //   communityImage: 'assets/images/football_team/golden_common.png',
            // ),
            // CommunitiesCard(
            //   communityName: 'Rangers FC',
            //   communityImage: 'assets/images/football_team/rangers.png',
            // ),
            // CommunitiesCard(
            //   communityName: 'Middlesbrough',
            //   communityImage: 'assets/images/football_team/middlesbrough.png',
            // ),
            // CommunitiesCard(
            //   communityName: 'Paucek & Lage FC',
            //   communityImage: 'assets/images/football_team/paucek.png',
            // ),
            // CommunitiesCard(
            //   communityName: 'Borcelle FC',
            //   communityImage: 'assets/images/football_team/borcelle.png',
            // ),
            // CommunitiesCard(
            //   communityName: 'Hanover FC',
            //   communityImage: 'assets/images/football_team/hanover.png',
            // ),
            // CommunitiesCard(
            //   communityName: 'Barcelona FC',
            //   communityImage: 'assets/images/football_team/barcelona.png',
            // ),
          ])),
    );
  }
}
