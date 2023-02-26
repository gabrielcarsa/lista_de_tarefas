class ToDo{
  String title;
  DateTime date;
  String category;

  ToDo({required this.title, required this.date, required this.category});

  Map<String, dynamic> toJson(){
    return {
      'title': title,
      'date': date.toIso8601String(),//this is way to convert DateTime to String
      'category': category,
    };
  }
}