class ToDo {
  String title;
  DateTime date;
  String category;

  ToDo({required this.title, required this.date, required this.category});

  //named constructor to transform from JSON
  ToDo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        date = DateTime.parse(json['date']),
        category = json['category'];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date':
          date.toIso8601String(), //this is way to convert DateTime to String
      'category': category,
    };
  }

}
