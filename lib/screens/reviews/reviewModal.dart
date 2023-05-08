class ReviewModal {
  String image;
  String name;
  double rating;
  String date;
  String comment;

  ReviewModal({required this.image, required this.name, required this.rating, required this.date, required this.comment});

  

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['name'] = this.name;
    data['rating'] = this.rating;
    data['date'] = this.date;
    data['comment'] = this.comment;
    return data;
  }
}
