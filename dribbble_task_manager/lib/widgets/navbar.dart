import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  bool showSmallTitle = false;
  double visibility = 0.0;

  @override
  void initState() {
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverNavigationBar(
      padding: const EdgeInsetsDirectional.only(start: 24, end: 20, top: 0),
      stretch: true,
      middle: visibility > 0.9 ? const Text("Today") : const Text(""),
      backgroundColor:
          CupertinoTheme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
      trailing: const Icon(
        Iconsax.notification5,
        size: 24,
      ),
      leading: const CircleAvatar(
          radius: 18, backgroundImage: AssetImage("images/user.jpg")),
      largeTitle: VisibilityDetector(
        key: const Key('nav-container'),
        onVisibilityChanged: (VisibilityInfo info) {
          setState(() {
            visibility = 1 - info.visibleFraction;
          });
          if (info.visibleFraction > 0) {
            setState(() {
              showSmallTitle = false;
            });
          } else {
            setState(() {
              showSmallTitle = true;
            });
          }
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Hi David!"),
                  Padding(
                    padding: EdgeInsets.only(left: 3, top: 2),
                    child: Text(
                      "8 tasks for today Monday",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                          color: CupertinoColors.systemGrey),
                    ),
                  )
                ])),
      ),
      border: Border(
          bottom: BorderSide(
        width: 1,
        color: CupertinoColors.systemGrey5.withOpacity(visibility),
      )),
    );
  }
}
