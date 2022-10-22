import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:nytimes_bestseller/model/lists.dart';
import 'package:nytimes_bestseller/screens/list_detail_screen.dart';

final searchBarProvider = StateProvider((ref) => false);
final searchTextProvider = StateProvider((ref) => "");

final bookListsFilterProvider = Provider<AsyncValue<List<BookList>>>((ref) {
  final modelList = ref.watch(bookListNotifierProvider);
  final searchText = ref.watch(searchTextProvider);
  if (searchText.isNotEmpty) {
    return modelList.whenData((value) => value
        .where(((element) => element.displayName
            .toLowerCase()
            .contains(searchText.toLowerCase())))
        .toList());
  }
  return modelList;
});

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchBarState = ref.watch(searchBarProvider);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 8,
        title: searchBarState
            ? CupertinoTextField(
                onChanged: (value) => {
                  ref.read(searchTextProvider.notifier).update((state) => value)
                },
                placeholder: "Search...",
                placeholderStyle: const TextStyle(color: Colors.white70),
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                prefix: const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(
                      Icons.search,
                      size: 20,
                    )),
                decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(4)),
                autofocus: true,
              )
            : const Text("NY Times Bestseller"),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(searchTextProvider.notifier).update((state) => "");
              ref.read(searchBarProvider.notifier).update((state) => !state);
            },
            icon: searchBarState
                ? const Icon(Icons.close)
                : const Icon(Icons.search),
          )
        ],
      ),
      body: const BookListWidget(),
    );
  }
}

class BookListWidget extends ConsumerWidget {
  const BookListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lists = ref.watch(bookListsFilterProvider);

    return lists.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (lists) {
        return GroupedListView<dynamic, String>(
          elements: lists,
          groupBy: (element) => element.favourite.toString(),
          groupSeparatorBuilder: (String groupByValue) => Container(
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              child: Text(
                groupByValue == "false" ? "Bestseller Lists" : "Favorites",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              )),
          order: GroupedListOrder.DESC,
          itemBuilder: (context, element) => ListTile(
            title: Text(element.displayName),
            subtitle: Text((element as BookList).updated),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ListDetailScreen(
                          list: element,
                        )),
              );
            },
          ),
        );
      },
    );
  }
}
