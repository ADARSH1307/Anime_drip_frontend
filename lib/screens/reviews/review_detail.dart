import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/data/api/api_client.dart';
import 'package:shopping_app/models/review_get_model.dart';

import 'package:shopping_app/screens/reviews/constant.dart';
import 'package:shopping_app/screens/reviews/defaultAppBar.dart';
import 'package:shopping_app/screens/reviews/defaultBackButton.dart';
import 'package:shopping_app/screens/reviews/review_ui.dart';
import 'package:shopping_app/uitls/app_constants.dart';
import 'package:auto_reload/auto_reload.dart';
class Reviews extends StatefulWidget {
  Reviews({Key? key}) : super(key: key);

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  bool isMore = false;
  List<double> ratings = [0.1, 0.3, 0.5, 0.7, 0.9];
var reviewsgetlist = <ReviewGetModel>[];
  //@override
  void initState() {
    
    _getReviews();
    super.initState();

   
  }
  

  _getReviews() {
    ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find())
        .getReviewsData(AppConstants.REVIEWS_PRODUCT_URI)
        .then((response) {
      Iterable list = json.decode(response.body);
      reviewsgetlist =
          list.map((model) => ReviewGetModel.fromJson(model)).toList();
      print(reviewsgetlist);
    });
  }
  

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: DefaultAppBar(
        title: "Reviews",
        child: DefaultBackButton(),
      ),
      body: Column(
        children: [
          Container(
            color: kAccentColor,
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "4.5",
                            style: TextStyle(fontSize: 48.0),
                          ),
                          TextSpan(
                            text: "/5",
                            style: TextStyle(
                              fontSize: 24.0,
                              color: kLightColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SmoothStarRating(
                    //   starCount: 5,
                    //   rating: 4.5,
                    //   size: 28.0,
                    //   color: Colors.orange,
                    //   borderColor: Colors.orange,
                    // ),
                    SizedBox(height: 16.0),
                    Text(
                      "${reviewList.length} Reviews",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: kLightColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 200.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Text(
                            "${index + 1}",
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(width: 4.0),
                          Icon(Icons.star, color: Colors.orange),
                          SizedBox(width: 8.0),
                          // LinearPercentIndicator(
                          //   lineHeight: 6.0,
                          //   // linearStrokeCap: LinearStrokeCap.roundAll,
                          //   width: MediaQuery.of(context).size.width / 2.8,
                          //   animation: true,
                          //   animationDuration: 2500,
                          //   percent: ratings[index],
                          //   progressColor: Colors.orange,
                          // ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: 
            reviewsgetlist.map((rev) {
            return  Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
                  itemCount: reviewList.length,
                  itemBuilder: (context, index) {
                    return ReviewUI(
                      image: reviewList[index].image,
                      name: rev.name!,
                      date: reviewList[index].date,
                      comment: reviewList[index].comment,
                      rating: reviewList[index].rating,
                      // onPressed: () => print("More Action $index"),
                      // onTap: () => setState(() {
                      //   isMore = !isMore;
                      // }),
                      // isLess: isMore,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      thickness: 2.0,
                      color: kAccentColor,
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
