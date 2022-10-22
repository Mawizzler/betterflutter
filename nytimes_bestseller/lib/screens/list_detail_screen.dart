import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nytimes_bestseller/model/books.dart';
import 'package:nytimes_bestseller/model/lists.dart';
import 'package:nytimes_bestseller/model/nytimes.dart';

final bookListProvider =
    FutureProvider.family<List<Book>, String>((ref, list) async {
  NYTimesAPI service = ref.read(apiProvider);
  return service.fetchBookList(list);
});

final bookListItemProvider = Provider.family<BookList, String>((ref, list) {
  final lists = ref.watch(bookListNotifierProvider);
  return lists.maybeWhen(
    data: (data) =>
        data.where((element) => element.listNameEncoded == list).first,
    orElse: () => throw Exception("Item not available"),
  );
});

class ListDetailScreen extends StatelessWidget {
  final BookList list;
  const ListDetailScreen({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(list.displayName),
          actions: [
            Consumer(
              builder: (context, ref, child) {
                final item =
                    ref.watch(bookListItemProvider(list.listNameEncoded));
                return (IconButton(
                    onPressed: () {
                      ref
                          .read(bookListNotifierProvider.notifier)
                          .toggleFavourite(item);
                    },
                    icon: item.favourite
                        ? const Icon(CupertinoIcons.star_fill)
                        : const Icon(CupertinoIcons.star)));
              },
            ),
          ],
        ),
        body: ListDetailWidget(list.listNameEncoded));
  }
}

class ListDetailWidget extends ConsumerWidget {
  final String listName;
  const ListDetailWidget(this.listName, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Book>> books = ref.watch(bookListProvider(listName));

    return books.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (books) {
        return ListView.builder(
          itemCount: books.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(90),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Center(
                        child: Text(
                      "${books[index].rank}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ))),
              ),
              title: Text(books[index].bookDetails.first.title),
              subtitle: Text(books[index].bookDetails.first.author),
            );
          },
        );
      },
    );
  }
}
