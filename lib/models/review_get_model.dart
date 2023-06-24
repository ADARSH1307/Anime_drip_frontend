class ReviewGetModel {
  int? id;
  int? foodId;
  String? name;
  String? productReview;
  String? stars;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? orderId;

  ReviewGetModel(
      { this.id,
      this.foodId,
      this.name,
      this.productReview,
      this.stars,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.orderId});

  ReviewGetModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    foodId = int.parse(json['food_id']);
    name = json['name'];
    productReview = json['product_review'];
    stars = json['stars'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderId = int.parse(json['order_id']);
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['food_id'] = this.foodId;
  //   data['name'] = this.name;
  //   data['product_review'] = this.productReview;
  //   data['stars'] = this.stars;
  //   data['image'] = this.image;
  //   data['created_at'] = this.createdAt;
  //   data['updated_at'] = this.updatedAt;
  //   data['order_id'] = this.orderId;
  //   return data;
  // }

   @override
  String toString() {
    return "ReviewGetModel(id: $id,food_id: $foodId, name: $name, product_review: $productReview,stars: $stars,image:$image,created_at:$createdAt,updated_at:$updatedAt,order_id:$orderId)";
  }
}




// class ReviewGetModel{
//   int id=0;
//   int order_id=0;
//     int food_id=0;
// int stars=0;
//   String product_review="";
//   String name="";
//   String image="";
  
//   ReviewGetModel(String image,int id,int order_id,int stars,
//       String product_review, int food_id,
//       String name, ){
//     this.id=id;
//         this.order_id=order_id;

//     this.stars=stars;
//         this.food_id=food_id;

//     this.product_review=product_review;
//     this.image=image;
//     this.name=name;
 
//   }
//   ReviewGetModel.fromJson(Map json)
//       :id=json['id'],
//       food_id=json['food_id'],
//       order_id=json['order_id'],
//       stars=json['stars'],
//       product_review=json['product_review'],
//         image=json['image'],
//         name=json['name'];
      
// }