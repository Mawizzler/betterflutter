import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nytimes_bestseller/model/nytimes.dart';
import 'package:shared_preferences/shared_preferences.dart';

final bookListNotifierProvider =
    StateNotifierProvider<BookListNotifier, AsyncValue<List<BookList>>>((ref) {
  NYTimesAPI service = ref.read(apiProvider);
  return BookListNotifier(service);
});

class BookListNotifier extends StateNotifier<AsyncValue<List<BookList>>> {
  BookListNotifier(this._service) : super(const AsyncLoading()) {
    getBooks();
  }
  final NYTimesAPI _service;

  void getBooks() async {
    state = await _service.fetchBookLists();
  }

  void toggleFavourite(BookList bookList) {
    final name = bookList.listNameEncoded;
    state = state.whenData((value) => value.map((bookList) {
          return bookList.listNameEncoded == name
              ? BookList(
                  listName: bookList.listName,
                  displayName: bookList.displayName,
                  listNameEncoded: bookList.listNameEncoded,
                  newestPublishedDate: bookList.newestPublishedDate,
                  oldestPublishedDate: bookList.oldestPublishedDate,
                  updated: bookList.updated,
                  favourite: !bookList.favourite,
                )
              : bookList;
        }).toList());
    saveFavourite(bookList);
  }

  void saveFavourite(BookList bookList) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(bookList.listNameEncoded, !bookList.favourite);
  }
}

class BookList {
  BookList({
    required this.listName,
    required this.displayName,
    required this.listNameEncoded,
    required this.oldestPublishedDate,
    required this.newestPublishedDate,
    required this.updated,
    this.favourite = false,
  });

  String listName;
  String displayName;
  String listNameEncoded;
  DateTime oldestPublishedDate;
  DateTime newestPublishedDate;
  String updated;
  bool favourite;

  factory BookList.fromJson(Map<String, dynamic> json) => BookList(
      listName: json["list_name"] ?? "",
      displayName: json["display_name"] ?? "",
      listNameEncoded: json["list_name_encoded"] ?? "",
      oldestPublishedDate: json["oldest_published_date"] == null
          ? DateTime.now()
          : DateTime.parse(json["oldest_published_date"]),
      newestPublishedDate: json["newest_published_date"] == null
          ? DateTime.now()
          : DateTime.parse(json["newest_published_date"]),
      updated: json["updated"] ?? "");
}
