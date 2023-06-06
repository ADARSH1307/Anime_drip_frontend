// class ReviewBody {
//   String name;
//   String product_review;
//  late int _totalSize;
//  // late int _typeId;
//   late int _offset;
//   late List<Reviews> _products;

//   ReviewBody({required this.name,

//     required this.product_review,
//     required int totalSize,
//       //required int typeId,
//       required int offset,
//       required List<Reviews> products
//     // this.email='', required this.password, required this.country_code, required this.sms_code
//     }
//     ){
//       this._totalSize = totalSize;
//     //this._typeId = typeId;
//     this._offset = offset;
//     this._products = products;
//     }
//   int get totalSize => _totalSize;
//  // int get typeId => _typeId;
//   int get offset => _offset;
//   List<Reviews> get products => _products;
//  factory ReviewBody.fromJson(Map<String, dynamic> json) {
//    return ReviewBody(
//        name : json['name'],

//        product_review : json['product_review'],

//       //  email : json['email'],
//       //  password : json['password'],
//       //  sms_code : json['sms_code'],
//       //  country_code : json['country_code']
//        );
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;

//     data['product_review'] = this.product_review;
//     // data['email'] = this.email;
//     // data['password'] = this.password;
//     // data['sms_code'] = this.sms_code;
//    // data['country_code'] = this.country_code;
//     return data;
//   }
// }
// class Reviews {
//   // int id;
//    int food_id;
//   String name;
//   String product_review;
//   // int stars;
//   // String image;
//   // int order_id;

//   Reviews(
//       {required this.name,
//       required this.product_review,
//             required this.food_id,

//     });

//   factory Reviews.fromJson(Map<String, dynamic> json) {
//     return Reviews(
//       // id: json['id'],
//        name: json['name'].toString(),
//        product_review: json['product_review'].toString(),
//      food_id: int.parse(['food_id'].toString()),
//       // img1: json['Image1'] ?? "img/food0.png",
//       // img2: json['Image2'] ?? "img/food0.png",
//       // img3: json['Image3'] ?? "img/food0.png",
//       // small: json['small'].toString(),
//       // medium: json['medium'].toString(),
//       // large: json['large'].toString(),
//       // xlarge: json['xlarge'].toString(),
//       // description: json['description'] ?? '',
//       // price: double.parse(json['price'].toString()),
//       // isFavourite: json['isFavourtie'] ?? false,
//     );
//   }
//   //Convert object to string like
//   Map<String, dynamic> toJson() {
//     return {
//       // "id": this.id,
//        "name": this.name,
//        "product_review": this.product_review,
//       "food_id": this.food_id,
//       // "isExist": this.description,
//       // 'img': this.img,
//       // 'Image1': this.img1,
//       // 'Image2': this.img2,
//       // 'Image3': this.img3,
//       // 'small': this.small,
//       // 'medium': this.medium,
//       // 'large': this.large,
//       // 'xlarge': this.xlarge,
//       // //this part we need for accessing the product model
//       // //so we will this part later
//       // 'isFavourite': this.isFavourite
//     };
//   }
// }

// // class VerificationBody {
// //   String country_code;
// //   String phone;

// //   VerificationBody({required this.country_code, required this.phone,});

// //   factory VerificationBody.fromJson(Map<String, dynamic> json) {
// //     return VerificationBody(
// //         country_code : json['country_code'],
// //         phone : json['phone'],
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['country_code'] = this.country_code;

// //     data['phone'] = this.phone;
// //     return data;
// //   }
// // }

class ReviewModel {
  late int _totalSize;
  late int _food_id;
  late int _offset;
  late List<Reviews> _products;
  late String _name;
  late String _product_review;

  ReviewModel(
      {required String name,
      required String product_review,
      required int food_id,
      required int totalSize,
      required int typeId,
      required int offset,
      required List<Reviews> products}) {
    
    this._totalSize = totalSize;
    //this._typeId = typeId;
    this._offset = offset;
    this._products = products;

        this._name = name;
    this._food_id = food_id;
    this._product_review = product_review;

  }

  int get totalSize => _totalSize;
    String get name => _name;
  int get food_id => _food_id;
  String get product_review => _product_review;

  // int get typeId => _typeId;
  int get offset => _offset;
  List<Reviews> get products => _products;

  ReviewModel.fromJson(Map<String, dynamic> json) {
    // name:
    // json['name'].toString();
    // product_review:
    // json['product_review'].toString();
    // food_id:
    // int.parse(['food_id'].toString());

    _totalSize = json['total_size'];
    // _typeId = json['type_id'] ?? 0;
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products.add(new Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "product_review": this.product_review,
      "food_id": this.food_id,
    };
  }
}

class Reviews {
  // int id;
 // late List<Reviews> _products;

  int food_id;
  String name;
  String product_review;
  // int stars;
  // String image;
  // int order_id;

  Reviews({
        
    required this.name,
    required this.product_review,
    required this.food_id,
  });

  factory Reviews.fromJson(Map<String, dynamic> json) {
    return Reviews(
      name: json['name'].toString(),
      product_review: json['product_review'].toString(),
      food_id: int.parse(['food_id'].toString()),
    );
  }
  //Convert object to string like
  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "product_review": this.product_review,
      "food_id": this.food_id,
    };
  }
}
