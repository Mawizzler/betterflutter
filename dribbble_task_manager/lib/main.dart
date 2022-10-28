import 'package:dribble_task_manager/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:iconsax/iconsax.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Flutter Demo',
      theme: CupertinoThemeData(
          brightness: Brightness.dark,
          primaryColor: Color(0xFF171716),
          scaffoldBackgroundColor: CupertinoColors.white,
          barBackgroundColor: CupertinoColors.white,
          textTheme: CupertinoTextThemeData(
            navTitleTextStyle: TextStyle(
                fontSize: 17,
                fontFamily: 'Mulish',
                color: Color(0xFF0C1111),
                fontWeight: FontWeight.w800),
            navLargeTitleTextStyle: TextStyle(
                fontSize: 28,
                fontFamily: 'Mulish',
                letterSpacing: -0.5,
                color: Color(0xFF0C1111),
                fontWeight: FontWeight.w800),
            textStyle: TextStyle(
              fontSize: 14,
              fontFamily: 'Mulish',
              color: Color(0xFF0C1111),
            ),
          )),
      home: RootView(),
    );
  }
}

class RootView extends StatelessWidget {
  const RootView({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: 1,
        height: 100,
        border: const Border(
            top: BorderSide(width: 0.0, color: CupertinoColors.white)),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Iconsax.calendar5,
              color: CupertinoTheme.of(context).primaryColor,
            ),
            activeIcon: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                    color: CupertinoTheme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(99)),
                child: const Icon(
                  Iconsax.calendar5,
                  color: CupertinoColors.white,
                )),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Iconsax.home5,
              color: CupertinoTheme.of(context).primaryColor,
            ),
            activeIcon: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                    color: CupertinoTheme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(99)),
                child: const Icon(
                  Iconsax.home5,
                  color: CupertinoColors.white,
                )),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Iconsax.sms5,
              color: CupertinoTheme.of(context).primaryColor,
            ),
            activeIcon: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                    color: CupertinoTheme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(99)),
                child: const Icon(
                  Iconsax.sms5,
                  color: CupertinoColors.white,
                )),
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return HomePage();
          },
        );
      },
    );
  }
}
