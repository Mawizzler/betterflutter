import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'iOS Navbar Demo',
      theme: CupertinoThemeData(
          primaryColor: CupertinoColors.black,
          scaffoldBackgroundColor: CupertinoColors.white,
          barBackgroundColor: CupertinoColors.white,
          textTheme: CupertinoTextThemeData(
            navTitleTextStyle: TextStyle(
                fontSize: 17,
                letterSpacing: -0.5,
                color: CupertinoColors.black,
                fontWeight: FontWeight.w700),
            navLargeTitleTextStyle: TextStyle(
                fontSize: 34,
                letterSpacing: -0.9,
                color: CupertinoColors.black,
                fontWeight: FontWeight.w800),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool showSmallTitle = false;
  double visibility = 0.0;

  @override
  void initState() {
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: Colors.white,
        child: CustomScrollView(slivers: [
          // The CupertinoSliverNavigationBar
          CupertinoSliverNavigationBar(
            stretch: true,
            backgroundColor: Colors.grey.shade100.withOpacity(visibility),
            middle: visibility > 0.9 ? const Text("Browse") : const Text(""),
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
              child: const Text("Browse"),
            ),
            border: Border(
                bottom: BorderSide(
              width: 1,
              color: Colors.grey.shade300.withOpacity(visibility),
            )),
          )
        ]));
  }
}
