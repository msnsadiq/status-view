import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

class OthersStatus extends StatelessWidget {
  const OthersStatus(
      {Key? key,
      required this.name,
      required this.imageUrl,
      required this.statusCount})
      : super(key: key);
  final String name;
  final String imageUrl;
  final int statusCount;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Badge(
        badgeColor: Colors.greenAccent.shade700,
        animationType: BadgeAnimationType.scale,
        badgeContent: Text(
          statusCount.toString(),
          style: TextStyle(color: Colors.white),
        ),
        child: CircleAvatar(
          radius: 26,
          backgroundImage: NetworkImage(imageUrl),
        ),
      ),
      title: Text(
        name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      subtitle: Text(""),
    );
  }
}
