
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/components/colors.dart';
import 'package:shopping_app/uitls/app_dimensions.dart';
import 'package:shopping_app/widgets/big_text.dart';

import 'pant_items_page.dart';


class SpecialCollectionPage extends StatefulWidget {
  const SpecialCollectionPage({Key? key}) : super(key: key);

  @override
  State<SpecialCollectionPage> createState() => _SpecialCollectionPageState();
}

class _SpecialCollectionPageState extends State<SpecialCollectionPage> {
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print("Current height is " + MediaQuery.of(context).size.height.toString());
    return Scaffold(
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
                      child: Icon(Icons.search,
                          color: Colors.white),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                        color: AppColors.mainColor,
                      ),
                    )
                  ]),
            ),
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new PantItemsPage())),
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                          color: Color.fromRGBO(227, 192, 192, 1),
                        ),
                        margin: EdgeInsets.only(
                            top: Dimensions.height10,
                            bottom: Dimensions.height10,
                            left: Dimensions.width15),
                        width: 370,
                        height: 130,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "images/anime_tshirt.jpg")),
                                color: AppColors.mainBlackColor,
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius15),
                              ),
                              //margin: EdgeInsets.only(right: 240),
                              height: 130,
                              width: 130,
                            ),
                            SizedBox(
                              width: 45,
                            ),
                            Column(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  'Naruto Special',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Collection',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'T-shirts',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
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
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
