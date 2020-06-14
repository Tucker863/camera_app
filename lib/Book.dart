class Book {
  int id;
  String name;
  String author;

  Book({this.id, this.name, this.author});

  factory Book.fromMap(Map<String, dynamic> json) => new Book(
    id: json["id"],
    name: json["name"],
    author: json["author"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "author": author,
  };
}
