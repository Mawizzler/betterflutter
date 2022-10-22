import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:nytimes_bestseller/model/books.dart';
import 'package:nytimes_bestseller/model/lists.dart';
import 'package:shared_preferences/shared_preferences.dart';

final apiProvider = Provider<NYTimesAPI>((ref) => NYTimesAPI());

class NYTimesAPI {
  Future<AsyncValue<List<BookList>>> fetchBookLists() async {
    try {
      NYTimesResponse response = await _get("lists/names.json");
      List<BookList> bookList = [];

      final prefs = await SharedPreferences.getInstance();

      if (response.results.isNotEmpty) {
        for (var element in response.results) {
          var list = BookList.fromJson(Map<String, dynamic>.from(element));
          list.favourite = prefs.getBool(list.listNameEncoded) ?? false;
          bookList.add(list);
        }
      }
      return AsyncData(bookList);
    } catch (e, stackTrace) {
      return AsyncError(e, stackTrace);
    }
  }

  Future<List<Book>> fetchBookList(String list) async {
    NYTimesResponse response =
        await _get("lists.json", queryString: "&list=$list");
    List<Book> books = [];
    if (response.results.isNotEmpty) {
      for (var element in response.results) {
        books.add(Book.fromJson(Map<String, dynamic>.from(element)));
      }
    }
    return books;
  }

  Future<NYTimesResponse> _get(
    String path, {
    String? queryString = "",
  }) async {
    final response = await http.get(Uri.parse(
        'https://api.nytimes.com/svc/books/v3/$path?api-key=0RPvSBA2hjG8mjyBU1tIFUkY322AZsMA$queryString'));
    if (response.statusCode == 200) {
      return NYTimesResponse.fromJson(jsonDecode(response.body));
    }
    throw Exception(response.statusCode);
  }
}

class NYTimesResponse {
  NYTimesResponse({
    required this.status,
    required this.copyright,
    required this.numResults,
    required this.results,
  });

  String status;
  String copyright;
  int numResults;
  List<dynamic> results;

  factory NYTimesResponse.fromJson(Map<String, dynamic> json) =>
      NYTimesResponse(
          status: json["status"] ?? "",
          copyright: json["copyright"] ?? "",
          numResults: json["num_results"] ?? 0,
          results: json["results"] ?? []);
}
