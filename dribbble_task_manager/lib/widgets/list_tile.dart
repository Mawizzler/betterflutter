import 'package:flutter/cupertino.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {required this.title,
      required this.description,
      required this.time,
      required this.start,
      required this.color,
      super.key});

  final String title;
  final String description;
  final String time;
  final String start;
  final int color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 16),
            width: 80,
            child: Text(
              start,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 14,
                  letterSpacing: -0.3,
                  color: Color(0xFF0C1111),
                  fontWeight: FontWeight.w700),
            ),
          ),
          Stack(alignment: Alignment.centerLeft, children: [
            Container(
              width: MediaQuery.of(context).size.width - 80,
              color: CupertinoTheme.of(context).primaryColor,
              height: 1,
            ),
            Container(
              height: 18,
              width: 18,
              decoration: BoxDecoration(
                  color: Color(color),
                  borderRadius: BorderRadius.circular(99),
                  border: Border.all(
                      width: 5,
                      color: CupertinoTheme.of(context).primaryColor)),
            ),
            Container(
                width: MediaQuery.of(context).size.width - 80,
                padding: const EdgeInsets.only(left: 30, right: 20),
                child: Container(
                    decoration: BoxDecoration(
                      color: Color(color),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                                fontSize: 17,
                                letterSpacing: -0.3,
                                color: Color(0xFF0C1111),
                                fontWeight: FontWeight.w700),
                          ),
                          Visibility(
                              visible: description != "",
                              child: Column(children: [
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                    maxLines: 3,
                                    description,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: -0.3,
                                      color: Color(0xFF5C5C5C),
                                    )),
                              ])),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            time,
                            style: const TextStyle(
                                fontSize: 14,
                                letterSpacing: -0.3,
                                color: Color(0xFF0C1111),
                                fontWeight: FontWeight.w800),
                          ),
                        ]))),
          ]),
        ],
      ),
    );
  }
}
