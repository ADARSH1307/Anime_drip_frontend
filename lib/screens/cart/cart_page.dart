import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:shopping_app/base/common_text_button.dart';
import 'package:shopping_app/base/custom_button.dart';
import 'package:shopping_app/base/custom_loader.dart';
import 'package:shopping_app/base/custom_snackbar.dart';
import 'package:shopping_app/base/no_data_found.dart';
import 'package:shopping_app/components/colors.dart';
import 'package:shopping_app/controllers/auth_controller.dart';
import 'package:shopping_app/controllers/cart_controller.dart';
import 'package:shopping_app/controllers/location_controller.dart';
import 'package:shopping_app/controllers/popular_product.dart';
import 'package:shopping_app/controllers/product_controller.dart';
import 'package:shopping_app/controllers/user_controller.dart';
import 'package:shopping_app/controllers/order_controller.dart';
import 'package:shopping_app/models/cart_item.dart';
import 'package:shopping_app/models/place_order.dart';
import 'package:shopping_app/routes/route_helper.dart';
import 'package:shopping_app/screens/checkout/payment_option_button.dart';
import 'package:shopping_app/screens/home/home_page.dart';
import 'package:shopping_app/screens/home/main_food_page.dart';
import 'package:shopping_app/screens/home/update_dialog.dart';
import 'package:shopping_app/uitls/app_constants.dart';
import 'package:shopping_app/uitls/app_dimensions.dart';
import 'package:shopping_app/widgets/big_text.dart';
import 'package:shopping_app/widgets/text_widget.dart';
import 'package:http/http.dart' as http;
import '../../controllers/splash_controller.dart';
import '../../uitls/styles.dart';
import '../../widgets/app_text_field.dart';
import '../checkout/order_type_button.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:nil/nil.dart';

class CartPage extends StatefulWidget {
  final int pageId;
  String page;

  CartPage({Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late bool _isCashOnDeliveryAccepted;
  late bool _isDigitalPaymentAccepted;
  int address = 0;
  final TextEditingController _noteController = TextEditingController();

  late var _razorpay;
  // late var selected_size;
  @override
  void initState() {
    final newVersion = NewVersionPlus(
      androidId: 'org.telegram.messenger',
    );

    Timer(const Duration(milliseconds: 800), () {
      checkNewVersion(newVersion);
    });
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
    _isCashOnDeliveryAccepted =
        Get.find<SplashController>().configModel!.cashOnDelivery!;
    _isDigitalPaymentAccepted =
        Get.find<SplashController>().configModel!.digitalPayment!;
  }

  void checkNewVersion(NewVersionPlus newVersion) async {
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      if (status.canUpdate) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return UpdateDialog(
              allowDismissal: false,
              description:
                  "• Separated tabs for chats: users, groups, channels, bots, favorites, unread, admin/creator. • Many options to cutomize tabs. • Multi-account (upto 10). • Categories. Create custom groups of chats (family, work, sports...). • Categories can be saved and restored. • Change default app folder.",
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

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print("Payment Done");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("Payment Fail");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _addressController = TextEditingController();
    final TextEditingController _noteController = TextEditingController();

    //  var location = Get.find<LocationController>().getUserAddress();

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
                top: 60,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 6),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.mainColor,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          if (widget.page == "recommended") {
                            Get.toNamed(RouteHelper.getRecommendedFoodRoute(
                                widget.pageId, widget.page));
                          } else if (widget.page == 'popular') {
                            Get.toNamed(RouteHelper.getPopularFoodRoute(
                                widget.pageId, widget.page));
                          }
                          //else if (widget.page == 'cart-history') {
                          //   // showCustomSnackBar(
                          //   //     "Product review is not available from cart history",
                          //   //     isError: false,
                          //   //     title: "Order more");
                          //   Get.offNamed(RouteHelper.getInitialRoute());
                          // }
                          else {
                            print("nkjsajkfna");
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new HomePage()));
                          }
                        },
                        child: Center(
                            child: Icon(
                          Icons.arrow_back_ios,
                          size: 16,
                          color: Colors.white,
                        )),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    // Container(
                    //   //padding: const EdgeInsets.only(left: 6),
                    //   width: 40,
                    //   height: 40,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(20),
                    //     color: AppColors.mainColor,
                    //   ),
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       print("my page id is " + widget.pageId.toString());

                    //       Get.offNamed(RouteHelper.getInitialRoute());
                    //     },
                    //     child: Center(
                    //         child: Icon(
                    //       Icons.home_outlined,
                    //       size: 20,
                    //       color: Colors.white,
                    //     )),
                    //   ),
                    // ),
                    Container(
                      padding: const EdgeInsets.only(left: 0),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.mainColor,
                      ),
                      child: GetBuilder<CartController>(builder: (_) {
                        return Stack(
                          children: [
                            Positioned(
                              child: Center(
                                  child: Icon(
                                Icons.shopping_cart_outlined,
                                size: 16,
                                color: Colors.white,
                              )),
                            ),
                            Get.find<CartController>().totalItems >= 1
                                ? Positioned(
                                    right: 3,
                                    top: 1,
                                    child: Center(
                                        child: Icon(
                                      Icons.circle,
                                      size: 20,
                                      color: Colors.white,
                                    )),
                                  )
                                : Container(),
                            Get.find<CartController>().totalItems >= 1
                                ? Positioned(
                                    right: 7,
                                    top: 4,
                                    child: Center(
                                        child: Text(
                                      Get.find<CartController>()
                                          .totalItems
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black54),
                                    )),
                                  )
                                : Container()
                          ],
                        );
                      }),
                    )
                  ],
                )),
            GetBuilder<CartController>(builder: (_) {
              return Get.find<CartController>().getCarts.length > 0
                  ? Positioned(
                      top: 100,
                      left: 0,
                      right: 0,
                      //with bottom property 0, we can make it scrollable
                      bottom: 0,
                      child: Container(
                        color: Colors.white,
                        //height: 600,
                        //width: 300,
                        child: GetBuilder<CartController>(
                            builder: (cartController) {
                          // print("here from cart "+cartController.getCarts[1].quantity.toString());
                          List<CartItem> _cartList =
                              Get.find<CartController>().getCarts;
                          return MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                                itemCount: _cartList.length,
                                itemBuilder: (_, index) {
                                  if (_cartList[index].quantity > 0) {
                                    return Container(
                                        //color: Colors.red,
                                        width: double.maxFinite,
                                        height: 100,
                                        margin: EdgeInsets.all(
                                            Dimensions.padding10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          //this setting should come at the end to make sense. this is important for the cart + - button
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                var getPageIndex = Get.find<
                                                        ProductController>()
                                                    .popularProductList
                                                    .indexOf(_cartList[index]
                                                        .product);

                                                // page = "recommended";
                                                if (getPageIndex < 0) {
                                                  getPageIndex =
                                                      Get.find<PopularProduct>()
                                                          .popularProductList
                                                          .indexOf(
                                                              _cartList[index]
                                                                  .product);
                                                  // page="popular";
                                                }
                                                if (getPageIndex < 0) {
                                                  showCustomSnackBar(
                                                      "Product review is not available from cart history",
                                                      isError: false,
                                                      title: "Order more");
                                                } else {
                                                  if (widget.page ==
                                                      "recommended") {
                                                    Get.toNamed(RouteHelper
                                                        .getRecommendedFoodRoute(
                                                            getPageIndex,
                                                            widget.page));
                                                  } else if (widget.page ==
                                                      "popular") {
                                                    Get.toNamed(RouteHelper
                                                        .getPopularFoodRoute(
                                                            getPageIndex,
                                                            widget.page));
                                                  } else if (widget.page ==
                                                      'cart-history') {
                                                    showCustomSnackBar(
                                                        "Product review is not available from cart history",
                                                        isError: false,
                                                        title: "Order more");
                                                  } else {
                                                    Get.toNamed(RouteHelper
                                                        .getInitialRoute());
                                                  }
                                                }
                                              },
                                              child: Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            AppConstants
                                                                    .UPLOADS_URL +
                                                                _cartList[index]
                                                                    .img)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                .padding20),
                                                    color: Colors.white),
                                              ),
                                            ),
                                            SizedBox(
                                              width: Dimensions.padding10,
                                            ),
                                            Expanded(
                                              child: Container(
                                                //since column needs height, without this container height this column would take min
                                                //size. Previously this column inside the Row, it didn't know the height. Now because of
                                                //container height, column would occupy the maximun height
                                                height: 100,
                                                //width:260,
                                                child: Column(
                                                  //mainAxisSize: MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  //spacebetween pushes to the end of the upper boundary
                                                  //spaceAround has the middle upper boundary
                                                  //spaceEvenly has the lowest upper boundary
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      cartController
                                                          .getCarts[index]
                                                          .title,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    /* BigText(text: cartController.getCarts[index].title,
                                                  color: AppColors.titleColor),*/
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Size :",
                                                        ),
                                                        BigText(
                                                            text: _cartList[
                                                                    index]
                                                                .selected_size,
                                                            color: AppColors
                                                                .mainBlackColor)
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        BigText(
                                                            text: "\₹ " +
                                                                cartController
                                                                    .getCarts[
                                                                        index]
                                                                    .price
                                                                    .toString(),
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    150,
                                                                    27,
                                                                    150)),
                                                        SizedBox(
                                                          width: Dimensions
                                                              .padding10,
                                                        ),
                                                        Expanded(
                                                            child: Container()),
                                                        Align(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .all(Dimensions
                                                                    .padding5),
                                                            child: Row(
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    var quantity =
                                                                        -1;
                                                                    var selected_size =
                                                                        _cartList[index]
                                                                            .selected_size;
                                                                    Get.find<CartController>().addItem(
                                                                        _cartList[index]
                                                                            .product,
                                                                        quantity,
                                                                        selected_size);
                                                                  },
                                                                  child: Icon(
                                                                      Icons
                                                                          .remove,
                                                                      color: AppColors
                                                                          .signColor),
                                                                ),
                                                                SizedBox(
                                                                    width: Dimensions
                                                                        .padding5),
                                                                GetBuilder<
                                                                    ProductController>(
                                                                  builder: (_) {
                                                                    return BigText(
                                                                        text: _cartList[index]
                                                                            .quantity
                                                                            .toString(),
                                                                        color: AppColors
                                                                            .mainBlackColor);
                                                                  },
                                                                ),
                                                                SizedBox(
                                                                    width: Dimensions
                                                                        .padding5),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    var quantity =
                                                                        1;
                                                                    var selected_size =
                                                                        _cartList[index]
                                                                            .selected_size;
                                                                    Get.find<CartController>().addItem(
                                                                        _cartList[index]
                                                                            .product,
                                                                        quantity,
                                                                        selected_size);
                                                                  },
                                                                  child: Icon(
                                                                      Icons.add,
                                                                      color: AppColors
                                                                          .signColor),
                                                                ),
                                                              ],
                                                            ),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        Dimensions
                                                                            .padding20),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              0),
                                                                      blurRadius:
                                                                          10,
                                                                      //spreadRadius: 3,
                                                                      color: AppColors
                                                                          .titleColor
                                                                          .withOpacity(
                                                                              0.05))
                                                                ]),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ));
                                  } else {
                                    return SizedBox
                                        .shrink(); // Return an empty SizedBox for zero quantity items
                                  }
                                }),
                          );
                        }),
                      ))
                  : NoDataScreen(text: "Your cart is empty!");
            })
          ],
        ),
        bottomNavigationBar:
            GetBuilder<UserController>(builder: (userController) {
          return GetBuilder<OrderController>(builder: (orderController) {
            // _noteController.text = orderController.foodNote ?? "";
            _noteController.text = orderController.foodNote ?? '';
            return !orderController.isLoading
                ? Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(
                        left: Dimensions.detailFoodImgPad,
                        right: Dimensions.detailFoodImgPad),
                    height: Dimensions.buttonButtonCon + 50,
                    padding: EdgeInsets.only(
                        top: Dimensions.padding10,
                        bottom: Dimensions.padding10,
                        left: 10,
                        right: 10),
                    child: GetBuilder<CartController>(builder: (_) {
                      print("my type is ${orderController.orderType}");
                      return Get.find<CartController>().getCarts.length > 0
                          ? Column(
                              children: [
                                InkWell(
                                  onTap: () => showModalBottomSheet(
                                      context: context,
                                      // backgroundColor: Colors.white
                                      backgroundColor: Colors.transparent,
                                      // isScrollControlled: true,
                                      builder: (_) {
                                        return Column(
                                          children: [
                                            Expanded(
                                                child: Scrollbar(
                                                    child:
                                                        SingleChildScrollView(
                                              physics: BouncingScrollPhysics(),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.9,
                                                decoration: new BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      new BorderRadius.only(
                                                    topLeft:
                                                        const Radius.circular(
                                                            25.0),
                                                    topRight:
                                                        const Radius.circular(
                                                            25.0),
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 700,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20,
                                                              right: 20,
                                                              top: 20),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      Dimensions
                                                                          .padding20),
                                                              topLeft: Radius
                                                                  .circular(
                                                                      Dimensions
                                                                          .padding20))),
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            _isCashOnDeliveryAccepted
                                                                ? PaymentOptionButton(
                                                                    icon: Icons
                                                                        .money,
                                                                    title:
                                                                        'cash_on_delivery'
                                                                            .tr,
                                                                    subtitle:
                                                                        'pay_your_payment_after_getting_food'
                                                                            .tr,
                                                                    index: 0,
                                                                  )
                                                                : SizedBox(),
                                                            _isDigitalPaymentAccepted
                                                                ? PaymentOptionButton(
                                                                    icon: Icons
                                                                        .paypal_outlined,
                                                                    title:
                                                                        'digital_payment'
                                                                            .tr,
                                                                    subtitle:
                                                                        'faster_and_safe_way'
                                                                            .tr,
                                                                    index: 1,
                                                                  )
                                                                : SizedBox(),
                                                            SizedBox(
                                                              height: Dimensions
                                                                  .height20,
                                                            ),
                                                            // Text(
                                                            //     'delivery_option'
                                                            //         .tr,
                                                            //     style:
                                                            //         robotoMedium),
                                                            // OrderTypeButton(
                                                            //   value: 'delivery',
                                                            //   title:
                                                            //       'home_delivery'
                                                            //           .tr,
                                                            //   amount: Get.find<
                                                            //           CartController>()
                                                            //       .totalAmount,
                                                            //   isFree: false,
                                                            // ),
                                                            // OrderTypeButton(
                                                            //   value: 'take_away',
                                                            //   title:
                                                            //       'take_away'.tr,
                                                            //   amount: 10,
                                                            //   isFree: true,
                                                            // ),
                                                            // SizedBox(
                                                            // height: Dimensions
                                                            //     .PADDING_SIZE_LARGE),
                                                            SizedBox(
                                                              height: Dimensions
                                                                  .height20,
                                                            ),
                                                            Text(
                                                                'Delivery Address'
                                                                    .tr,
                                                                style:
                                                                    robotoMedium),
                                                            AppTextField(
                                                              hintText: '',
                                                              textController:
                                                                  _noteController,
                                                              icon: Icons.note,
                                                              maxLines: true,
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            CustomButton(
                                                              onPressed: () => {
                                                                orderController
                                                                    .setFoodNote(
                                                                        _noteController
                                                                            .text
                                                                            .trim()),
                                                                _updateAddress(
                                                                    orderController),
                                                              },
                                                              margin: EdgeInsets
                                                                  .all(Dimensions
                                                                      .PADDING_SIZE_SMALL),
                                                              buttonText:
                                                                  'Confirm'.tr,
                                                            )
                                                          ]),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )))
                                          ],
                                        );
                                      }).whenComplete(() {
                                    orderController.setFoodNote(
                                        _noteController.text.trim());
                                  }),
                                  child: Container(
                                    width: double.maxFinite,
                                    margin: EdgeInsets.symmetric(
                                        vertical: Dimensions.height10 / 2),
                                    child: CommonTextButton(
                                        text:
                                            "payment_and_delivery_options".tr),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.all(Dimensions.padding20),
                                      child: Row(
                                        children: [
                                          SizedBox(width: Dimensions.padding10),
                                          GetBuilder<CartController>(
                                            builder: (_) {
                                              return BigText(
                                                  text: "\₹ " +
                                                      Get.find<CartController>()
                                                          .totalAmount
                                                          .toString(),
                                                  color:
                                                      AppColors.mainBlackColor);
                                            },
                                          ),
                                          SizedBox(width: Dimensions.padding10),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.padding20),
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(0, 0),
                                                blurRadius: 10,
                                                //spreadRadius: 3,
                                                color: AppColors.titleColor
                                                    .withOpacity(0.05))
                                          ]),
                                    ),
                                    Expanded(child: Container()),
                                    GestureDetector(
                                        onTap: () async {
                                          //sendNotification("body", "test", false);
                                          if (address == 1) {
                                            if (!Get.find<AuthController>()
                                                .isLoggedIn()) {
                                              Get.toNamed(
                                                  RouteHelper.getSignInRoute());
                                            } else {
                                              //await  Get.find<AuthController>().updateToken();
                                              if (Get.find<LocationController>()
                                                  .addressList
                                                  .isEmpty) {
                                                Get.toNamed(RouteHelper
                                                    .getAddAddressRoute());
                                              } else {
                                                var location = Get.find<
                                                        LocationController>()
                                                    .getUserAddress();
                                                orderController.placeOrder(
                                                    PlaceOrderBody(
                                                        cart: Get.find<
                                                                CartController>()
                                                            .getCarts,
                                                        /*
                              next line 100 is a fake data
                               */
                                                        orderAmount: 100.0,
                                                        orderNote:
                                                            orderController
                                                                .foodNote!,
                                                        address: location
                                                            .address,
                                                        latitude: location
                                                            .latitude,
                                                        longitude: location
                                                            .longitude,
                                                        contactPersonName: location
                                                                .contactPersonName ??
                                                            Get.find<UserController>()
                                                                .userInfoModel!
                                                                .fName,
                                                        contactPersonNumber: location
                                                                .contactPersonNumber ??
                                                            Get.find<UserController>()
                                                                .userInfoModel!
                                                                .phone,
                                                        scheduleAt: '',
                                                        distance: 10,
                                                        orderType:
                                                            orderController
                                                                .orderType,
                                                        paymentMethod: orderController
                                                                    .paymentMethodIndex ==
                                                                0
                                                            ? 'cash_on_delivery'
                                                            : 'digital_payment'),
                                                    _callback);

                                                Get.find<CartController>()
                                                    .clear();
                                                //  Get.find<CartController>().removeCartSharedPreference();
                                                Get.find<CartController>()
                                                    .addToHistory();
                                              }
                                            }

                                            var amount =
                                                Get.find<CartController>()
                                                    .totalAmount
                                                    .toString();
                                            var options = {
                                              'key': "rzp_test_jvYWYte2pFbrwd",
                                              //     // amount will be multiple of 100
                                              //(int.parse(amountController.text) * 100)
                                              'amount':
                                                  (double.parse(amount) * 100)
                                                      .toString(),
                                              'name': 'your payment',
                                              //     'description': 'Demo',
                                              'timeout': 300, // in seconds
                                              'prefill': {
                                                'contact': '',
                                                'email': '',
                                              }
                                            };
                                            // _razorpay.open(options);
                                          } else {
                                            showCustomSnackBar(
                                                "Fill out the payment and delivery details");
                                          }
                                          ;
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: Dimensions.height10),
                                          child: CommonTextButton(
                                            text: "check_out".tr,
                                          ),
                                        ))
                                  ],
                                )
                              ],
                            )
                          : Container();
                    }),
                    decoration: BoxDecoration(
                        color: AppColors.buttonBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.padding20),
                          topRight: Radius.circular(Dimensions.padding20),
                        )),
                  )
                : CustomLoader();
          });
        }));
  }

  void _callback(bool isSuccess, String message, String orderID) async {
    if (isSuccess) {
      Get.find<CartController>().clearCartList();
      Get.find<OrderController>().stopLoader();
      Get.find<CartController>().addToCartList();

      //pay online
      if (Get.find<OrderController>().paymentMethodIndex == 1) {
        Get.offNamed(RouteHelper.getPaymentRoute(
            orderID, Get.find<UserController>().userInfoModel!.id!));

        Get.offNamed(RouteHelper.getOrderSuccessRoute(orderID, "success"));
        //pay by cash, cash on delivery
      } else if (Get.find<OrderController>().paymentMethodIndex == 0) {
        Get.offNamed(RouteHelper.getOrderSuccessRoute(orderID, "success"));
      } else {
        if (GetPlatform.isWeb) {
          Get.back();
        } else {
          Get.offNamed(RouteHelper.getPaymentRoute(
              orderID, Get.find<UserController>().userInfoModel!.id!));
        }
      }
    } else {
      showCustomSnackBar(message);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _razorpay.clear();
    super.dispose();
  }

  _updateAddress(OrderController orderController) {
    if (orderController.foodNote != "") {
      address = 1;
      showCustomSnackBar("Payment and Address Details updated",
          isError: false, title: "Details updated");
      Navigator.pop(context);
    } else {
      showCustomSnackBar("Enter address");
      address = 0;
    }
  }
}
