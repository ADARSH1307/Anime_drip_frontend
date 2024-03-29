import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:shopping_app/components/colors.dart';
import 'package:shopping_app/screens/account/account_page.dart';
import 'package:shopping_app/screens/cart/cart_history.dart';
import 'package:shopping_app/screens/cart/cart_page.dart';
import 'package:shopping_app/screens/home/home_page_body.dart';
import 'package:shopping_app/screens/home/update_dialog.dart';
import 'package:shopping_app/screens/order/order_screen.dart';
import 'package:shopping_app/screens/reviews/post_review.dart';
import 'package:shopping_app/widgets/big_text.dart';

import '../category/category_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2;
  List pages = [
    CategoryPage(),
    OrderScreen(),
    HomePageBody(),
    CartPage(pageId: 0, page: "cart-history"),
    AccountPage(),
    // PostReviewPage(orderId: null, orderModel: null,)
  ];

  void onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void initState() {
    super.initState();
     final newVersion = NewVersionPlus(
      androidId: 'org.telegram.messenger',
    );

    Timer(const Duration(milliseconds: 800), () {
      checkNewVersion(newVersion);
    });
    
   
  }
  void checkNewVersion(NewVersionPlus newVersion) async {
    final status = await newVersion.getVersionStatus();
    if(status != null) {
      if(status.canUpdate) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return UpdateDialog(
              allowDismissal: false,
              description: "• Separated tabs for chats: users, groups, channels, bots, favorites, unread, admin/creator. • Many options to cutomize tabs. • Multi-account (upto 10). • Categories. Create custom groups of chats (family, work, sports...). • Categories can be saved and restored. • Change default app folder.",
              version: status.storeVersion,
              appLink: status.appStoreLink,
            );
          },
        );
        // newVersion.showUpdateDialog(
        //   context: context,
        //   versionStatus: status,
        //   dialogText: 'New Version is available in the store (${status.storeVersion}), update now!',
        //   dialogTitle: 'Update is Available!',
        // );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: BigText(
                text: 'Exit App',
                color: AppColors.mainBlackColor,
                size: 25,
              ),
              content: Row(
                children: [
                  Text('Do you want to exit '),
                  Text(
                    "Anime Drip",
                    // style: TextStyle(decoration: TextDecoration.underline),
                  )
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  //return false when click on "NO"
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        AppColors.mainColor, // Set the background color
                    foregroundColor: Colors.white, // Set the text color
                    padding: EdgeInsets.all(8), // Set button padding
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Set button border radius
                    ),
                  ),
                  child: Text(
                    'Yes',
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //return true when click on "Yes"

                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        AppColors.mainColor, // Set the background color
                    foregroundColor: Colors.white, // Set the text color
                    padding: EdgeInsets.all(8), // Set button padding
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Set button border radius
                    ),
                  ),
                  child: Text('No'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        backgroundColor: Color(0xFFf9f9fa),
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedFontSize: 0.0,
          unselectedFontSize: 0.0,
          onTap: onTap,
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.mainColor,
          unselectedItemColor: Colors.amberAccent,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.category), label: "home"),

            BottomNavigationBarItem(icon: Icon(Icons.archive), label: "home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: "home"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "home"),
            // BottomNavigationBarItem(icon: Icon(Icons.read_more),
            //     label: "home"

            // )
          ],
        ),
      ),
    );
  }
}
