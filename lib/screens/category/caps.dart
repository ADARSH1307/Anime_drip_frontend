import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopping_app/controllers/caps_controller.dart';
import 'package:shopping_app/controllers/category_controller.dart';
import 'package:shopping_app/controllers/hoodie_controller.dart';
import 'package:shopping_app/controllers/keychain_controller.dart';
import 'package:shopping_app/controllers/pant_controller.dart';
import 'package:shopping_app/controllers/shirt_controller.dart';
import 'package:shopping_app/controllers/shoes_controller.dart';
import 'package:shopping_app/routes/route_helper.dart';
import 'package:shopping_app/screens/food/detail_food.dart';
import 'package:shopping_app/uitls/app_constants.dart';
import 'package:shopping_app/widgets/big_text.dart';

import '../../components/colors.dart';
import '../../uitls/app_dimensions.dart';

class CapsItemsPage extends StatefulWidget {
  const CapsItemsPage({Key? key}) : super(key: key);

  @override
  State<CapsItemsPage> createState() => _CapsItemsPageState();
}

class _CapsItemsPageState extends State<CapsItemsPage> {
  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    
    //print("Current height is " + MediaQuery.of(context).size.height.toString());
    return Container(
      //padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight),
      child: Scaffold(
        //resizeToAvoidBottomInset: true,

        backgroundColor: AppColors.buttonBackgroundColor,
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              child: Container(
                margin: EdgeInsets.only(
                    top: Dimensions.height45, bottom: Dimensions.height15),
                padding: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
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
                              Icon(Icons.arrow_drop_down_rounded)
                            ],
                          )
                        ],
                      ),
                      Container(
                        width: Dimensions.height45,
                        height: Dimensions.height45,
                        child: Icon(Icons.search, color: Colors.white),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                          color: AppColors.mainColor,
                        ),
                      )
                    ]),
              ),
            ),
            GetBuilder<Caps>(builder: (pantProduct) {
              return Row(
                children: [
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 400,
                              childAspectRatio: 1 / 1,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 0),
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: pantProduct.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Get.toNamed(RouteHelper.getPopularFoodRoute(index, "category"));
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                            AppConstants.UPLOADS_URL +
                                                pantProduct.capsList[index].img)),
                                    color: AppColors.buttonBackgroundColor,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius15),
                                  ),
                                 margin: EdgeInsets.only(
                                        top: Dimensions.height10,
                                        bottom: Dimensions.height10,
                                        left: Dimensions.width10,
                                        right: Dimensions.width15),
                                  height: 250,
                                  width: 180,
                                  child: Column(
                                    verticalDirection: VerticalDirection.up,
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.only(left: 10, right: 20),
                                        width: 180,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(
                                                Dimensions.radius15),
                                            bottomRight: Radius.circular(
                                                Dimensions.radius15),
                                          ),
                                          color: AppColors.mainColor
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            BigText(
                                                text: pantProduct
                                                    .capsList[index].title,
                                                /* element.value,*/
                                                color: Colors.black87),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "\u{20B9}1000000 (30% off)",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            /*Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Wrap(
                                                    children: List.generate(
                                                        5,
                                                        (index) => Icon(
                                                              Icons.star,
                                                              size: 17,
                                                              color: Colors.yellow,
                                                            )),
                                                  ),
                                                  Text(
                                                    '4.5k',
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ],
                                              ),*/
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
