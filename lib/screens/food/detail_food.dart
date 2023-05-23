import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shopping_app/components/colors.dart';
import 'package:shopping_app/components/expanded_widget.dart';
import 'package:shopping_app/controllers/cart_controller.dart';
import 'package:shopping_app/controllers/order_controller.dart';
import 'package:shopping_app/controllers/pant_controller.dart';
import 'package:shopping_app/controllers/product_controller.dart';
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

class DetailFood extends StatefulWidget {
  int pageId;
  String page;
  DetailFood({Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  State<DetailFood> createState() => _DetailFoodState();
}

class _DetailFoodState extends State<DetailFood> {
  int activeIndex = 0;
  bool isMore = false;
  double sideLength = 40;
  var size_color = Colors.transparent;
  double medium_Length = 40;
  var medium_color = Colors.transparent;
  double large_Length = 40;
  var large_color = Colors.transparent;
  double xl_Length = 40;
  var xl_color = Colors.transparent;
  final controller = CarouselController();
  var selected_size;

  @override
  Widget build(BuildContext context) {
    //print(Get.find<CartController>().getCartsData());
    //we are getting a model here

    var productItem =
        Get.find<ProductController>().popularProductList[widget.pageId];
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
              height: 50,
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
                      height: 400,
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
                    left: 20,
                    right: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 6),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
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
                              size: 16,
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
                            width: 40,
                            height: 40,
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
                                      size: 16,
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
                                          right: 10,
                                          top: 8,
                                          child: Center(
                                              child: Text(
                                            Get.find<CartController>()
                                                .totalItems
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 10,
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
            //     top: Dimensions.sliverHeight - 10,
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
                  SizedBox(
                    height: Dimensions.padding10,
                  ),
                  Row(
                    children: [
                      Wrap(
                        children: List.generate(
                            5,
                            (index) => Icon(Icons.star,
                                color: AppColors.mainColor, size: 15)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      TextWidget(text: "4.5", color: Color(0xFFccc7c5)),
                      SizedBox(
                        width: 10,
                      ),
                      TextWidget(
                          text: "1287" + " " + "comments".tr,
                          color: Color(0xFFccc7c5))
                    ],
                  ),
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
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selected_size = productItem.small;
                              sideLength == 40
                                  ? sideLength = 45
                                  : sideLength = 40;
                              size_color == Colors.transparent
                                  ? size_color = AppColors.mainColor
                                  : size_color = Colors.transparent;

                              medium_Length = 40;
                              medium_color = Colors.transparent;

                              large_Length = 40;
                              large_color = Colors.transparent;

                              xl_Length = 40;
                              xl_color = Colors.transparent;
                            });
                          },
                          child: Center(
                              child: BigText(
                                  text: productItem.small,
                                  color: AppColors.mainBlackColor)),
                        ),
                      ),
                      SizedBox(
                        width: 10,
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
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selected_size = productItem.medium;

                              medium_Length == 40
                                  ? medium_Length = 45
                                  : medium_Length = 40;
                              medium_color == Colors.transparent
                                  ? medium_color = AppColors.mainColor
                                  : medium_color = Colors.transparent;

                              sideLength = 40;
                              size_color = Colors.transparent;

                              large_Length = 40;
                              large_color = Colors.transparent;

                              xl_Length = 40;
                              xl_color = Colors.transparent;
                            });
                          },
                          child: Center(
                              child: BigText(
                                  text: productItem.medium,
                                  color: AppColors.mainBlackColor)),
                        ),
                      ),
                      SizedBox(
                        width: 10,
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
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selected_size = productItem.large;

                              large_Length == 40
                                  ? large_Length = 45
                                  : large_Length = 40;
                              large_color == Colors.transparent
                                  ? large_color = AppColors.mainColor
                                  : large_color = Colors.transparent;

                              sideLength = 40;
                              size_color = Colors.transparent;

                              medium_Length = 40;
                              medium_color = Colors.transparent;

                              xl_Length = 40;
                              xl_color = Colors.transparent;
                            });
                          },
                          child: Center(
                              child: BigText(
                                  text: productItem.large,
                                  color: AppColors.mainBlackColor)),
                        ),
                      ),
                      SizedBox(
                        width: 10,
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
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selected_size = productItem.xlarge;

                              xl_Length == 40 ? xl_Length = 45 : xl_Length = 40;
                              xl_color == Colors.transparent
                                  ? xl_color = AppColors.mainColor
                                  : xl_color = Colors.transparent;

                              sideLength = 40;
                              size_color = Colors.transparent;

                              medium_Length = 40;
                              medium_color = Colors.transparent;

                              large_Length = 40;
                              large_color = Colors.transparent;
                            });
                          },
                          child: Center(
                              child: BigText(
                                  text: productItem.xlarge,
                                  color: AppColors.mainBlackColor)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BigText(
                      size: 22,
                      text: "Description",
                      color: AppColors.titleColor),
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
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Reviews(),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: BigText(
                                      size: 15,
                                      text: "View All",
                                      color: AppColors.mainColor),
                                ),
                              ),
                            ],
                          ),
                          ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return ReviewUI(
                                image: reviewList[index].image,
                                name: reviewList[index].name,
                                date: reviewList[index].date,
                                comment: reviewList[index].comment,
                                rating: reviewList[index].rating,
                                onPressed: () => print("More Action $index"),
                                onTap: () => setState(() {
                                  isMore = !isMore;
                                }),
                                isLess: isMore,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                thickness: 2.0,
                                color: kAccentColor,
                              );
                            },
                          ),
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
                        blurRadius: 10,
                        //spreadRadius: 3,
                        color: AppColors.titleColor.withOpacity(0.05))
                  ]),
            ),
            Expanded(child: Container()),
            GestureDetector(
              onTap: () {
                
                Get.find<ProductController>()
                    .setSize(selected_size, productItem);
                    Get.find<ProductController>().addItem(productItem);
                print(selected_size);

                // Get.find<OrderController>().size_select(selected_size);
              },
              child: Container(
                child: BigText(
                  size: 20,
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
                          blurRadius: 10,
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
