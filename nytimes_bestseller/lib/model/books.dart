class Book {
  Book({
    required this.listName,
    required this.displayName,
    required this.bestsellersDate,
    required this.publishedDate,
    required this.rank,
    required this.rankLastWeek,
    required this.weeksOnList,
    required this.asterisk,
    required this.dagger,
    required this.amazonProductUrl,
    required this.isbns,
    required this.bookDetails,
    required this.reviews,
  });

  String listName;
  String displayName;
  DateTime bestsellersDate;
  DateTime publishedDate;
  int rank;
  int rankLastWeek;
  int weeksOnList;
  int asterisk;
  int dagger;
  String amazonProductUrl;
  List<Isbn> isbns;
  List<BookDetail> bookDetails;
  List<Review> reviews;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        listName: json["list_name"],
        displayName: json["display_name"],
        bestsellersDate: DateTime.parse(json["bestsellers_date"]),
        publishedDate: DateTime.parse(json["published_date"]),
        rank: json["rank"],
        rankLastWeek: json["rank_last_week"],
        weeksOnList: json["weeks_on_list"],
        asterisk: json["asterisk"],
        dagger: json["dagger"],
        amazonProductUrl: json["amazon_product_url"],
        isbns: List<Isbn>.from(json["isbns"].map((x) => Isbn.fromJson(x))),
        bookDetails: List<BookDetail>.from(
            json["book_details"].map((x) => BookDetail.fromJson(x))),
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
      );
}

class BookDetail {
  BookDetail({
    required this.title,
    required this.description,
    required this.contributor,
    required this.author,
    required this.contributorNote,
    required this.price,
    required this.ageGroup,
    required this.publisher,
    required this.primaryIsbn13,
    required this.primaryIsbn10,
  });

  String title;
  String description;
  String contributor;
  String author;
  String contributorNote;
  String price;
  String ageGroup;
  String publisher;
  String primaryIsbn13;
  String primaryIsbn10;

  factory BookDetail.fromJson(Map<String, dynamic> json) => BookDetail(
        title: json["title"],
        description: json["description"],
        contributor: json["contributor"],
        author: json["author"],
        contributorNote: json["contributor_note"],
        price: json["price"],
        ageGroup: json["age_group"],
        publisher: json["publisher"],
        primaryIsbn13: json["primary_isbn13"],
        primaryIsbn10: json["primary_isbn10"],
      );
}

class Isbn {
  Isbn({
    required this.isbn10,
    required this.isbn13,
  });

  String isbn10;
  String isbn13;

  factory Isbn.fromJson(Map<String, dynamic> json) => Isbn(
        isbn10: json["isbn10"],
        isbn13: json["isbn13"],
      );
}

class Review {
  Review({
    required this.bookReviewLink,
    required this.firstChapterLink,
    required this.sundayReviewLink,
    required this.articleChapterLink,
  });

  String bookReviewLink;
  String firstChapterLink;
  String sundayReviewLink;
  String articleChapterLink;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        bookReviewLink: json["book_review_link"],
        firstChapterLink: json["first_chapter_link"],
        sundayReviewLink: json["sunday_review_link"],
        articleChapterLink: json["article_chapter_link"],
      );
}
