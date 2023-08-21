import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shopping_app/base/custom_snackbar.dart';
import 'package:shopping_app/components/colors.dart';
import 'package:shopping_app/components/expanded_widget.dart';
import 'package:shopping_app/controllers/cart_controller.dart';
import 'package:shopping_app/controllers/order_controller.dart';
import 'package:shopping_app/controllers/pant_controller.dart';
import 'package:shopping_app/controllers/product_controller.dart';
import 'package:shopping_app/controllers/review_controller.dart';
import 'package:shopping_app/controllers/sweatshirt_controller.dart';
import 'package:shopping_app/data/api/api_client.dart';
import 'package:shopping_app/models/review_get_model.dart';
import 'package:shopping_app/routes/route_helper.dart';
import 'package:shopping_app/screens/food/sample.dart';
import 'package:shopping_app/screens/reviews/constant.dart';
import 'package:shopping_app/screens/reviews/review_detail.dart';
import 'package:shopping_app/screens/reviews/review_ui.dart';
import 'package:shopping_app/uitls/app_constants.dart';
import 'package:shopping_app/uitls/app_dimensions.dart';
import 'package:shopping_app/widgets/big_text.dart';
import 'package:shopping_app/widgets/icon_text_widget.dart';
import 'package:shopping_app/widgets/text_widget.dart';
import 'package:get/get.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class SweatShirtsDetail extends StatefulWidget {
  int pageId;
  String page;
  SweatShirtsDetail({Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  State<SweatShirtsDetail> createState() => _SweatShirtsDetailState();
}

class _SweatShirtsDetailState extends State<SweatShirtsDetail> {
  int activeIndex = 0;
  bool isMore = false;
  double sideLength = Dimensions.height20 * 2;
  var size_color = Colors.transparent;
  double medium_Length = Dimensions.height20 * 2;
  var medium_color = Colors.transparent;
  double large_Length = Dimensions.height20 * 2;
  var large_color = Colors.transparent;
  double xl_Length = Dimensions.height20 * 2;
  var xl_color = Colors.transparent;
  final controller = CarouselController();
  var selected_size = 'null';
  var reviewsgetlist = <ReviewGetModel>[];
  bool isLoading = false;

  _getReviews() {
    ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find())
        .getReviewsData(AppConstants.REVIEWS_PRODUCT_URI)
        .then((response) {
      Iterable list = json.decode(response.body);
      reviewsgetlist =
          list.map((model) => ReviewGetModel.fromJson(model)).toList();
      isLoading = true;
      print(reviewsgetlist);
    });
  }

  @override
  void initState() {
    super.initState();
    _getReviews();
  }

  @override
  Widget build(BuildContext context) {
    //print(Get.find<CartController>().getCartsData());
    //we are getting a model here

    var productItem =
        Get.find<Sweatshirt>().sweatshirtList[widget.pageId];
    Get.find<ProductController>()
        .initData(productItem, widget.pageId, Get.find<CartController>());
    final urlImages = [
      AppConstants.UPLOADS_URL + productItem.img,
      AppConstants.UPLOADS_URL + productItem.img1,
      AppConstants.UPLOADS_URL + productItem.img2,
      AppConstants.UPLOADS_URL + productItem.img3,
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Dimensions.height10 * 5,
            ),
            Stack(
              children: [
                // Column(
                //   children: [

                CarouselSlider.builder(
                    carouselController: controller,
                    itemCount: urlImages.length,
                    itemBuilder: (context, index, realIndex) {
                      final urlImage = urlImages[index];
                      return buildImage(urlImage, index);
                    },
                    options: CarouselOptions(
                      animateToClosest: true,
                      height: Dimensions.height20 * 20,
                      autoPlay: true,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(seconds: 1),
                      enlargeCenterPage: true,
                      // onPageChanged: (index, reason) =>setState(() => activeIndex = index)
                    )),

                //
                // buildIndicator()
                //   ],
                // ),
                Positioned(
                    //top: 50,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 6),
                          width: Dimensions.height20 * 2,
                          height: Dimensions.height20 * 2,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white70,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.getInitialRoute());
                              //Get.back();
                            },
                            child: Center(
                                child: Icon(
                              Icons.arrow_back_ios,
                              size: Dimensions.height15,
                              color: Colors.black54,
                            )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getCartPage(
                                widget.pageId, widget.page));
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 0),
                            width: Dimensions.height20 * 2,
                            height: Dimensions.height20 * 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white70,
                            ),
                            child: GetBuilder<CartController>(builder: (_) {
                              return Stack(
                                children: [
                                  Positioned(
                                    child: Center(
                                        child: Icon(
                                      Icons.shopping_cart_outlined,
                                      size: Dimensions.height15,
                                      color: Colors.black54,
                                    )),
                                  ),
                                  Get.find<CartController>().totalItems >= 1
                                      ? Positioned(
                                          right: 5,
                                          top: 5,
                                          child: Center(
                                              child: Icon(
                                            Icons.circle,
                                            size: 18,
                                            color: AppColors.mainColor,
                                          )),
                                        )
                                      : Container(),
                                  Get.find<CartController>().totalItems > 1
                                      ? Positioned(
                                          right: Dimensions.height10,
                                          top: 8,
                                          child: Center(
                                              child: Text(
                                            Get.find<CartController>()
                                                .totalItems
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: Dimensions.height10,
                                                color: Color.fromARGB(
                                                    255, 8, 2, 2)),
                                          )),
                                        )
                                      : Container()
                                ],
                              );
                            }),
                          ),
                        )
                      ],
                    )),
              ],
            ),
            // Positioned(
            //     left: 0,
            //     right: 0,
            //     top: Dimensions.sliverHeight - Dimensions.height10,
            //     // bottom: 0,
            //     child:
            Container(
              height: 500,
              //width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.padding20),
                      topLeft: Radius.circular(Dimensions.padding20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(
                      size: Dimensions.font26,
                      text: productItem.title,
                      color: Colors.black87),
                  // SizedBox(
                  //   height: Dimensions.padding10,
                  // ),
                  // Row(
                  //   children: [
                  //     Wrap(
                  //       children: List.generate(
                  //           5,
                  //           (index) => Icon(Icons.star,
                  //               color: AppColors.mainColor, size: 15)),
                  //     ),
                  //     SizedBox(
                  //       width: Dimensions.height10,
                  //     ),
                  //     TextWidget(text: "4.5", color: Color(0xFFccc7c5)),
                  //     SizedBox(
                  //       width: Dimensions.height10,
                  //     ),
                  //     TextWidget(
                  //         text: "1287" + " " + "comments".tr,
                  //         color: Color(0xFFccc7c5))
                  //   ],
                  // ),
                  SizedBox(
                    height: Dimensions.padding20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /* IconAndTextWidget(
                              text: "Normal",
                              color: AppColors.textColor,
                              icon: Icons.circle_sharp,
                              iconColor: AppColors.iconColor1,
                            ),
                            IconAndTextWidget(
                              text: "1.7km",
                              color: AppColors.textColor,
                              icon: Icons.location_on,
                              iconColor: AppColors.mainColor,
                            ),
                            IconAndTextWidget(
                              text: "32min",
                              color: AppColors.textColor,
                              icon: Icons.access_time_rounded,
                              iconColor: AppColors.iconColor2,
                            )*/
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.padding20,
                  ),
                  Text(
                    "Size",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      AnimatedContainer(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          color: size_color,
                          shape: BoxShape.circle,
                        ),
                        height: sideLength,
                        width: sideLength,
                        duration: const Duration(seconds: 0),
                        curve: Curves.easeIn,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (productItem.small != "NA") {
                                if (selected_size == 'null') {
                                  selected_size = productItem.small;
                                } else if (selected_size == "NA") {
                                  showCustomSnackBar("Size is not available",
                                      isError: false, title: "Unavailable!!!");
                                } else if (selected_size == productItem.small) {
                                  selected_size = "null";
                                }

                                sideLength == Dimensions.height20 * 2
                                    ? sideLength = Dimensions.height15 * 3
                                    : sideLength = Dimensions.height20 * 2;
                                size_color == Colors.transparent
                                    ? size_color = AppColors.mainColor
                                    : size_color = Colors.transparent;

                                medium_Length = Dimensions.height20 * 2;
                                medium_color = Colors.transparent;

                                large_Length = Dimensions.height20 * 2;
                                large_color = Colors.transparent;

                                xl_Length = Dimensions.height20 * 2;
                                xl_color = Colors.transparent;
                              } else {
                                showCustomSnackBar("Size is not available",
                                    isError: false, title: "Unavailable!!!");
                              }
                            });
                          },
                          child: Center(
                              child: BigText(
                                  text: productItem.small,
                                  color: AppColors.mainBlackColor)),
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.height10,
                      ),
                      AnimatedContainer(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          color: medium_color,
                          shape: BoxShape.circle,
                        ),
                        height: medium_Length,
                        width: medium_Length,
                        duration: const Duration(seconds: 0),
                        curve: Curves.easeIn,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (productItem.medium != "NA") {
                                if (selected_size == 'null') {
                                  selected_size = productItem.medium;
                                } else if (selected_size == "NA") {
                                  showCustomSnackBar("Size is not available",
                                      isError: false, title: "Unavailable!!!");
                                } else if (selected_size ==
                                    productItem.medium) {
                                  selected_size = "null";
                                }

                                medium_Length == Dimensions.height20 * 2
                                    ? medium_Length = Dimensions.height15 * 3
                                    : medium_Length = Dimensions.height20 * 2;
                                medium_color == Colors.transparent
                                    ? medium_color = AppColors.mainColor
                                    : medium_color = Colors.transparent;

                                sideLength = Dimensions.height20 * 2;
                                size_color = Colors.transparent;

                                large_Length = Dimensions.height20 * 2;
                                large_color = Colors.transparent;

                                xl_Length = Dimensions.height20 * 2;
                                xl_color = Colors.transparent;
                              } else {
                                showCustomSnackBar("Size is not available",
                                    isError: false, title: "Unavailable!!!");
                              }
                            });
                          },
                          child: Center(
                              child: BigText(
                                  text: productItem.medium,
                                  color: AppColors.mainBlackColor)),
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.height10,
                      ),
                      AnimatedContainer(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          color: large_color,
                          shape: BoxShape.circle,
                        ),
                        height: large_Length,
                        width: large_Length,
                        duration: const Duration(seconds: 0),
                        curve: Curves.easeIn,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (productItem.large != "NA") {
                                if (selected_size == 'null') {
                                  selected_size = productItem.large;
                                } else if (selected_size == productItem.large) {
                                  selected_size = "null";
                                }

                                large_Length == Dimensions.height20 * 2
                                    ? large_Length = Dimensions.height15 * 3
                                    : large_Length = Dimensions.height20 * 2;
                                large_color == Colors.transparent
                                    ? large_color = AppColors.mainColor
                                    : large_color = Colors.transparent;

                                sideLength = Dimensions.height20 * 2;
                                size_color = Colors.transparent;

                                medium_Length = Dimensions.height20 * 2;
                                medium_color = Colors.transparent;

                                xl_Length = Dimensions.height20 * 2;
                                xl_color = Colors.transparent;
                              } else {
                                showCustomSnackBar("Size is not available",
                                    isError: false, title: "Unavailable!!!");
                              }
                            });
                          },
                          child: Center(
                              child: BigText(
                                  text: productItem.large,
                                  color: AppColors.mainBlackColor)),
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.height10,
                      ),
                      AnimatedContainer(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          color: xl_color,
                          shape: BoxShape.circle,
                        ),
                        height: xl_Length,
                        width: xl_Length,
                        duration: const Duration(seconds: 0),
                        curve: Curves.easeIn,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (productItem.xlarge != "NA") {
                                if (selected_size == 'null') {
                                  selected_size = productItem.xlarge;
                                } else if (selected_size ==
                                    productItem.xlarge) {
                                  selected_size = "null";
                                }

                                xl_Length == Dimensions.height20 * 2
                                    ? xl_Length = Dimensions.height15 * 3
                                    : xl_Length = Dimensions.height20 * 2;
                                xl_color == Colors.transparent
                                    ? xl_color = AppColors.mainColor
                                    : xl_color = Colors.transparent;

                                sideLength = Dimensions.height20 * 2;
                                size_color = Colors.transparent;

                                medium_Length = Dimensions.height20 * 2;
                                medium_color = Colors.transparent;

                                large_Length = Dimensions.height20 * 2;
                                large_color = Colors.transparent;
                              } else {
                                showCustomSnackBar("Size is not available",
                                    isError: false, title: "Unavailable!!!");
                              }
                            });
                          },
                          child: Center(
                              child: BigText(
                                  text: productItem.xlarge,
                                  color: AppColors.mainBlackColor)),
                        ),
                      ),
                      // Container(
                      //   height: Dimensions.height10,
                      //   width: 20,
                      //   decoration: BoxDecoration(color: AppColors.mainColor),
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       // setState(() {
                      //        // print("state set");
                      //       // });
                      // //     },
                      //   ),
                      // )
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  BigText(
                      size: 22,
                      text: "Description",
                      color: AppColors.mainBlackColor),
                  SizedBox(
                    height: Dimensions.padding20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DescriptionTextWidget(text: productItem.description),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BigText(
                                  size: 22,
                                  text: "Reviews".tr,
                                  color: AppColors.titleColor),
                              GestureDetector(
                                onTap: () => setState(() {}),
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //     builder: (context) => Reviews(),
                                //   ),
                                // ),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: BigText(
                                      size: 15,
                                      text: "Show Reviews",
                                      color: AppColors.mainColor),
                                ),
                              ),
                            ],
                          ),
                          // GetBuilder<Caps>(builder: (pantProduct) {
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: reviewsgetlist.map((rev) {
                              return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.only(bottom: 0.0, top: 0.0),
                                itemCount: 1,
                                itemBuilder: (context, index) {
                                  if (productItem.id == rev.foodId) {
                                    return ReviewCard(
                                      rating: rev.stars!,
                                      reviewText: rev.productReview!,
                                      user: rev.name!,
                                    );
                                  }
                                },
                                // separatorBuilder: (context, index) {

                                //     return Divider(

                                //       height: 0,
                                //     );
                                //     //  SizedBox(height: Dimensions.height10,width: 0,);
                                //   }
                              );
                            }).toList(),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
            left: Dimensions.detailFoodImgPad,
            right: Dimensions.detailFoodImgPad),
        height: Dimensions.buttonButtonCon,
        padding: EdgeInsets.only(
            top: Dimensions.padding30,
            bottom: Dimensions.padding30,
            left: 20,
            right: 20),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(Dimensions.padding20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.find<ProductController>()
                          .setQuantity(false, productItem);
                    },
                    child: Icon(Icons.remove, color: AppColors.signColor),
                  ),
                  SizedBox(width: Dimensions.padding10),
                  GetBuilder<ProductController>(
                    builder: (_) {
                      return BigText(
                          text: Get.find<ProductController>()
                              .certainItems
                              .toString(),
                          color: AppColors.mainBlackColor);
                    },
                  ),
                  SizedBox(width: Dimensions.padding10),
                  GestureDetector(
                    onTap: () {
                      Get.find<ProductController>()
                          .setQuantity(true, productItem);
                    },
                    child: Icon(Icons.add, color: AppColors.signColor),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.padding20),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: Dimensions.radius20 / 2,
                        //spreadRadius: 3,
                        color: AppColors.titleColor.withOpacity(0.05))
                  ]),
            ),
            Expanded(child: Container()),
            GestureDetector(
              onTap: () {
                if (selected_size == "null" || selected_size == "NA") {
                  showCustomSnackBar("Select the size",
                      isError: false, title: "Please!");
                } else {
                  Get.find<ProductController>()
                      .setSize(selected_size, productItem);
                  Get.find<ProductController>().addItem(productItem);
                  print(selected_size);
                  int a = Get.find<ProductController>().certainItems;
                  if (selected_size != "null" && a == 0) {
                    showCustomSnackBar("Atleast Select a Item",
                        isError: false, title: "Set quantity");
                  }
                  if (selected_size != "null" && a >= 1) {
                    showCustomSnackBar("Items added to Cart",
                        isError: false, title: "Cart Updated");
                  }
                }
                // Get.find<OrderController>().size_select(selected_size);
              },
              child: Container(
                child: BigText(
                  size: Dimensions.font20,
                  text: "\₹" +
                      (productItem.price).toString() +
                      " " +
                      "add_to_cart".tr,
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(Dimensions.padding20),
                decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimensions.padding20),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 5),
                          blurRadius: Dimensions.radius20 / 2,
                          //spreadRadius: 3,
                          color: AppColors.mainColor.withOpacity(0.3))
                    ]),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.padding40),
              topRight: Radius.circular(Dimensions.padding40),
            )),
      ),
    );

    // );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        onDotClicked: animateToSlide,
        effect: ExpandingDotsEffect(
            dotWidth: 15, activeDotColor: AppColors.mainColor),
        activeIndex: activeIndex,
        count: 4,
      );

  void animateToSlide(int index) => controller.animateToPage(index);
}

Widget buildImage(String urlImage, int index) =>
    Container(child: Image.network(urlImage, fit: BoxFit.cover));

class ReviewCard extends StatelessWidget {
  final int rating;
  final String reviewText;
  final String user;

  const ReviewCard({
    Key? key,
    required this.rating,
    required this.reviewText,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 16, bottom: 10),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
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
                  BigText(
                    text: ' $user',
                    // style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    color: AppColors.mainBlackColor,
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  SmoothStarRating(
                    starCount: 5,
                    rating: double.parse('$rating'),
                    size: 20.0,
                    color: Colors.orange,
                    borderColor: Colors.orange,
                  ),
                  SizedBox(width: 4),
                  // Text(
                  //   '$rating'+" ratings",
                  //   style: TextStyle(
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            reviewText,
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
