import 'package:dribble_task_manager/widgets/list_tile.dart';
import 'package:dribble_task_manager/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final dates = [
    {
      "title": "Daily stand-up",
      "description": "To discuss with team all work processes for the day.",
      "time": "9:00 - 10:20 AM",
      "start": "9:00\nAM",
      "color": 0xFFEDF1FF
    },
    {
      "title": "New UI Kit for the app",
      "description":
          "To collect all assets that contains a set of design elements such as components.",
      "time": "10:20 - 12:35 AM",
      "start": "10:20\nAM",
      "color": 0xFFEFFCEF
    },
    {
      "title": "Lunch break",
      "description": "",
      "time": "12:35 - 1:00 AM",
      "start": "12:35\nAM",
      "color": 0xFFE6F5FB
    },
    {
      "title": "Call with client",
      "description":
          "Discuss site design for a new project and discuss the cost of it",
      "time": "1:00 - 2:00 PM",
      "start": "1:00\nPM",
      "color": 0xFFF2F5FF
    }
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: CustomScrollView(anchor: 0.09, slivers: [
      const Navbar(),
      SliverList(
          delegate: SliverChildBuilderDelegate(childCount: dates.length,
              (BuildContext context, int index) {
        return Container(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: CustomListTile(
              title: dates[index]["title"] as String,
              description: dates[index]["description"] as String,
              time: dates[index]["time"] as String,
              start: dates[index]["start"] as String,
              color: dates[index]["color"] as int,
            ));
      })),
    ]));
  }
}
