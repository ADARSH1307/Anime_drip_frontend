import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/controllers/category_controller.dart';
import 'package:shopping_app/controllers/hoodie_controller.dart';
import 'package:shopping_app/controllers/pant_controller.dart';
import 'package:shopping_app/controllers/shirt_controller.dart';
import 'package:shopping_app/routes/route_helper.dart';
import 'package:shopping_app/screens/food/detail_food.dart';
import 'package:shopping_app/uitls/app_constants.dart';
import 'package:shopping_app/widgets/big_text.dart';

import '../../components/colors.dart';
import '../../uitls/app_dimensions.dart';



class ShirtItemsPage extends StatefulWidget {
  const ShirtItemsPage({Key? key}) : super(key: key);

  @override
  State<ShirtItemsPage> createState() => _ShirtItemsPageState();
}

class _ShirtItemsPageState extends State<ShirtItemsPage> {
  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    // Calculate responsive dimensions based on the screen size
    double height45 = screenHeight * 0.05;
    double height15 = screenHeight * 0.015;
        double height10 = screenHeight * 0.010;
        double height400 = screenHeight * 0.4;

        double height200 = screenHeight * 0.2;


    double width40 = screenWidth * 0.04;
        double width15 = screenWidth * 0.015;
                double width225 = screenWidth * 0.55;


    double width10 = screenWidth * 0.01;
    double containerHeight = isPortrait ? screenHeight * 0.35 : screenHeight * 0.5;
    double containerWidth = isPortrait ? screenWidth * 0.4 : screenWidth * 0.3;

    return Container(
      child: Scaffold(
        backgroundColor: AppColors.buttonBackgroundColor,
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              child: Container(
                margin: EdgeInsets.only(
                  top: height45,
                  bottom: height15,
                ),
                padding: EdgeInsets.only(
                  left: width40,
                  right: width40,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        BigText(text: "ANIME", color: AppColors.mainColor),
                        Row(
                          children: [
                            BigText(
                              text: "  DRIP",
                              color: Colors.black54,
                            ),
                            Icon(Icons.arrow_drop_down_rounded),
                          ],
                        ),
                      ],
                    ),
                    // Container(
                    //   width: height45,
                    //   height: height45,
                    //   child: Icon(Icons.search, color: Colors.white),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(Dimensions.radius15),
                    //     color: AppColors.mainColor,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            GetBuilder<Shirt>(builder: (pantProduct) {
              return Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: isPortrait ? height400 : height200,
                        childAspectRatio: 1 / 1,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        mainAxisExtent: width225,
                        
                      ),
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: pantProduct.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getShirtsRoute(index, "category"));
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          AppConstants.UPLOADS_URL + pantProduct.shirtList[index].img),
                                    ),
                                    color: AppColors.buttonBackgroundColor,
                                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                                  ),
                                  margin: EdgeInsets.only(
                                    top: height10,
                                    bottom: height10,
                                    left: width40,
                                    right: width15,
                                  ),
                                  height: containerHeight,
                                  width: containerWidth,
                                  child: Column(
                                    verticalDirection: VerticalDirection.up,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: width10, right: width40),
                                        width: containerWidth,
                                        height: Dimensions.height30*2,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(Dimensions.radius15),
                                            bottomRight: Radius.circular(Dimensions.radius15),
                                          ),
                                          color: AppColors.mainColor,
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            BigText(
                                              text: pantProduct.shirtList[index].title,
                                              color: Colors.black87,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "\u{20B9}1000 (30% off)",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

