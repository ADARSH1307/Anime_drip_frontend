import 'package:flutter/material.dart';
import 'package:shopping_app/screens/reviews/constant.dart';

class ReviewUI extends StatelessWidget {
  final String image, name, date, comment;
  final double rating;
//  final Function onTap, onPressed;
  //final bool isLess;
  const ReviewUI({
    Key? key,
    required this.image,
    required this.name,
    required this.date,
    required this.comment,
    required this.rating,
    //required this.onTap, required this.onPressed,
    // required this.isLess,
  //   required this.onTap,
  //   required this.isLess,
  //  required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 2.0,
        bottom: 2.0,
        left: 16.0,
        right: 0.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 45.0,
                width: 45.0,
                margin: EdgeInsets.only(right: 16.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("img/anime_drip logo.png"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(44.0),
                ),
              ),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              // SmoothStarRating(
              //   starCount: 5,
              //   rating: rating,
              //   size: 28.0,
              //   color: Colors.orange,
              //   borderColor: Colors.orange,
              // ),
              SizedBox(width: 10),
              // Text(
              //   date,
              //   style: TextStyle(fontSize: 18.0),
              // ),
            ],
          ),
          SizedBox(height: 8.0),
        
            //onTap: onTap,
            
                 Text(
comment,                    
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  
          ),
           SizedBox(height: 10),
        ],
      ),
    );
  }
}
