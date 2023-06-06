class ProductModel {
  late int _totalSize;
  late int _typeId;
  late int _offset;
  late List<Product> _products;

  ProductModel(
      {required int totalSize,
      required int typeId,
      required int offset,
      required List<Product> products}) {
    this._totalSize = totalSize;
    this._typeId = typeId;
    this._offset = offset;
    this._products = products;
  }

  int get totalSize => _totalSize;
  int get typeId => _typeId;
  int get offset => _offset;
  List<Product> get products => _products;

   ProductModel.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'] ?? 0;
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products.add(new Product.fromJson(v));
      });
    }
  }
}

class Product {
  int id;
  String title;
  String sub_title;
  String img;
  String img1;
  String img2;
  String img3;
  String description;
  double price;
  bool isFavourite;
  String small;
  String medium;
  String large;
  String xlarge;

  Product(
      {required this.id,
      required this.title,
      required this.sub_title,
      required this.img,
      required this.img1,
      required this.img2,
      required this.img3,
      required this.description,
      required this.price,
      required this.small,
      required this.medium,
      required this.large,
      required this.xlarge,
      this.isFavourite = false});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['name'].toString(),
      sub_title: json['sub_title'].toString(),
      img: json['img'] ?? "img/food0.png",
      img1: json['Image1'] ?? "img/food0.png",
      img2: json['Image2'] ?? "img/food0.png",
      img3: json['Image3'] ?? "img/food0.png",
      small: json['small'].toString(),
      medium: json['medium'].toString(),
      large: json['large'].toString(),
      xlarge: json['xlarge'].toString(),
      description: json['description'] ?? '',
      price: double.parse(json['price'].toString()),
      isFavourite: json['isFavourtie'] ?? false,
    );
  }
  //Convert object to string like
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.title,
      "quantity": this.sub_title,
      "price": this.price,
      "isExist": this.description,
      'img': this.img,
      'Image1': this.img1,
      'Image2': this.img2,
      'Image3': this.img3,
      'small': this.small,
      'medium': this.medium,
      'large': this.large,
      'xlarge': this.xlarge,
      //this part we need for accessing the product model
      //so we will this part later
      'isFavourite': this.isFavourite
    };
  }
}
