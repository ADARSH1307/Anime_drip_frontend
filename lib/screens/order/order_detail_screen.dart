import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/base/custom_snackbar.dart';
import 'package:shopping_app/components/colors.dart';
import 'package:shopping_app/controllers/review_controller.dart';
import 'package:shopping_app/data/api/api_client.dart';
import 'package:shopping_app/data/api/callapi.dart';
import 'package:shopping_app/models/review_model.dart';
import 'package:shopping_app/uitls/app_constants.dart';
import 'package:shopping_app/widgets/app_text_field.dart';
import 'package:shopping_app/widgets/big_text.dart';
import '../../base/confirm_dialogue.dart';
import '../../base/custom_button.dart';
import '../../controllers/order_controller.dart';
import '../../controllers/splash_controller.dart';
import '../../helper/app_date_converter.dart';
import '../../models/order_detail_model.dart';
import '../../models/order_model.dart';
import '../../routes/route_helper.dart';
import '../../uitls/app_dimensions.dart';
import '../../uitls/images.dart';
import '../../uitls/styles.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrderModel? orderModel;
  final int orderId;

  OrderDetailsScreen({required this.orderModel, required this.orderId});

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late StreamSubscription _stream;
  late int _foodid;
  void _loadData(BuildContext context, bool reload) async {
    await Get.find<OrderController>().trackOrder(
        widget.orderId.toString(), reload ? null : widget.orderModel, false);
    if (widget.orderModel == null) {
      await Get.find<SplashController>().getConfigData();
    }
    print("my order id is " + widget.orderId.toString());
    Get.find<OrderController>().getOrderDetails(widget.orderId.toString());
  }

  @override
  void initState() {
    super.initState();

    _stream = FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage on Details: ${message.data}");
      _loadData(context, true);
    });

    _loadData(context, false);
  }

  @override
  void dispose() {
    super.dispose();

    _stream.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var btnclicked = 0;
    int updatedReview = 0;
    TextEditingController nameController = TextEditingController();
    TextEditingController productReviewController = TextEditingController();
    // TextEditingController ratingController = TextEditingController();

    _register() {
      // var reviewController = Get.find<ReviewController>();
      var _name = nameController.text;
      var _productReview = productReviewController.text;
      int _rating = updatedReview;
      print(_rating);
      //print(widget.orderId.toString());
      var data = {
        'name': nameController.text.trim(),
        'product_review': productReviewController.text.trim(),
        'food_id': _foodid.toString(),
        'order_id': widget.orderId.toString(),
        'stars': _rating.toString()
        ,
      };

      if (_name.isEmpty) {
        showCustomSnackBar('Enter your name'.tr);
        return;
      } else if (_productReview.isEmpty) {
        showCustomSnackBar('Enter product review'.tr);
        return;
      } else if (_rating == 0) {
        showCustomSnackBar('Rate the product'.tr);
        return;
      } else {
        var btnclicked = 1;
        showCustomSnackBar('Review updated successfully!!!',
            isError: false, title: 'Thanks For Feedback');
        var res = CallApi().postReview(data, AppConstants.REVIEWS_PRODUCT_URI);
        // showCustomSnackBar("Your Review will be updated Shortly!!!",
        //    isError: false, title: "Review Updated");
        // ReviewBody reviewBody =
        //     ReviewBody(name: _name, productReview: _productReview);
        // print(reviewBody.toString());
        // reviewController.reviewpost(reviewBody).then((status) {
        //   if (status.isSuccess) {
        //     print("Success");
        //   }
        // });
      }
    }

    return WillPopScope(
      onWillPop: () async {
        if (widget.orderModel == null) {
          // return Get.offAllNamed(RouteHelper.getInitial());
          return true;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: /*CustomAppBar(title: 'order_details'.tr, onBackPressed: () {
          if(widget.orderModel == null) {
            Get.offAllNamed(RouteHelper.getInitialRoute());
          }else {
            Get.back();
          }
        }),*/
            AppBar(
          backgroundColor: AppColors.mainColor,
          title: Text("order_details".tr),
        ),
        body: GetBuilder<OrderController>(builder: (orderController) {
          double _deliveryCharge = 0;
          double _itemsPrice = 0;

          double _discount = 0;
          double _couponDiscount = 0;
          double _tax = 0;
          double _addOns = 0;
          OrderModel? _order = orderController.trackModel;

          double _subTotal = _itemsPrice + _addOns;
          for (OrderDetailsModel orderDetails in orderController.orderDetails) {
            _itemsPrice =
                _itemsPrice + (orderDetails.price * orderDetails.quantity);
            _foodid = orderDetails.foodId;
          }

          double _total = _itemsPrice +
              _addOns -
              _discount +
              _tax +
              _deliveryCharge -
              _couponDiscount;

          return orderController.orderDetails.isNotEmpty
              ? Column(children: [
                  Expanded(
                    child: Scrollbar(
                        child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      child: Center(
                          child: SizedBox(
                              width: Dimensions.WEB_MAX_WIDTH,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('${'order_id'.tr}:',
                                            style: robotoRegular),
                                        Text(_order!.id.toString(),
                                            style: robotoMedium),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.timer,
                                          size: 20,
                                          color: AppColors.yellowColor,
                                        ),
                                        Text(
                                          DateConverter
                                              .dateTimeStringToDateTime(
                                                  _order.createdAt!),
                                          style: robotoMedium,
                                        ),
                                      ],
                                    ),

                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),

                                    _order.scheduled == 1
                                        ? Row(children: [
                                            Text('${'scheduled_at'.tr}:',
                                                style: robotoRegular),
                                            SizedBox(
                                                width: Dimensions
                                                    .PADDING_SIZE_EXTRA_SMALL),
                                            Text(
                                                DateConverter
                                                    .dateTimeStringToDateTime(
                                                        _order.scheduleAt!),
                                                style: robotoMedium),
                                          ])
                                        : SizedBox(),
                                    Divider(
                                        height: Dimensions.PADDING_SIZE_LARGE),
                                    SizedBox(
                                        height: _order.scheduled == 1
                                            ? Dimensions.PADDING_SIZE_SMALL
                                            : 0),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("order_type".tr,
                                            style: robotoRegular),
                                        Text(_order.orderType!.tr,
                                            style: robotoMedium),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "payment_status".tr,
                                          style: robotoRegular,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  Dimensions.PADDING_SIZE_SMALL,
                                              vertical: Dimensions
                                                  .PADDING_SIZE_EXTRA_SMALL),
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.RADIUS_SMALL),
                                          ),
                                          child: Text(
                                            _order.paymentMethod ==
                                                    'cash_on_delivery'
                                                ? 'cash_on_delivery'.tr
                                                : _order.paymentMethod ==
                                                        'wallet'
                                                    ? 'wallet_payment'.tr
                                                    : 'digital_payment'.tr,
                                            style: robotoRegular.copyWith(
                                                color:
                                                    Theme.of(context).cardColor,
                                                fontSize: Dimensions
                                                    .fontSizeExtraSmall),
                                          ),
                                        )
                                      ],
                                    ),

                                    Divider(
                                        height: Dimensions.PADDING_SIZE_LARGE),

                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text('${'item'.tr}:',
                                                    style: robotoRegular),
                                                SizedBox(
                                                  width: Dimensions.height10,
                                                ),
                                                Text(
                                                  orderController
                                                      .orderDetails.length
                                                      .toString(),
                                                  style: robotoMedium.copyWith(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                    height: 7,
                                                    width: 7,
                                                    decoration: BoxDecoration(
                                                      color: (_order.orderStatus ==
                                                                  'failed' ||
                                                              _order.orderStatus ==
                                                                  'refunded')
                                                          ? Colors.red
                                                          : Colors.green,
                                                      shape: BoxShape.circle,
                                                    )),
                                                SizedBox(
                                                  width: Dimensions.height10,
                                                ),
                                                Text(
                                                  _order.orderStatus ==
                                                          'delivered'
                                                      ? '${'delivered_at'.tr} ${DateConverter.dateTimeStringToDateTime(_order.delivered!)}'
                                                      : _order.orderStatus!.tr,
                                                  style: robotoRegular.copyWith(
                                                      fontSize: Dimensions
                                                          .fontSizeSmall),
                                                ),
                                              ],
                                            )
                                          ]),
                                    ),
                                    Divider(
                                        height: Dimensions.PADDING_SIZE_LARGE),
                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),
                                    // BigText(text: "   Enter Name", color: AppColors.mainBlackColor),
                                    Center(
                                      child: Text("Post a Review",
                                          style: TextStyle(fontSize: 20)),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    AppTextField(
                                      hintText: "name".tr,
                                      textController: nameController,
                                      icon: Icons.person,
                                    ),

                                    SizedBox(
                                      height: 30,
                                    ),
                                    AppTextField(
                                      maxLines: true,
                                      hintText:
                                          "Write your feedback here....".tr,
                                      textController: productReviewController,
                                      icon: Icons.description,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            right: 16, bottom: 10),
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border:
                                              Border.all(color: Colors.grey),
                                        ),
                                        child: Column(
                                          children: [
                                            BigText(
                                                text: "Rate the product",
                                                color:
                                                    AppColors.mainBlackColor),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            RatingBar.builder(
                                              itemSize: 40,
                                              initialRating: 3,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              itemCount: 5,
                                              itemPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              itemBuilder: (context, _) =>
                                                  const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) =>
                                                  updatedReview =
                                                      rating.toInt(),
                                              //  debugPrint(rating.toString()),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      height: 30,
                                    ),

                                    GestureDetector(
                                      onTap: () {
                                        _register();
                                      },
                                      child: Center(
                                        child: Container(
                                          width: 150,
                                          height: 60,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: AppColors.mainColor),
                                          child: Center(
                                            child: BigText(
                                              text: 'Submit'.tr,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Total
                                  ]))),
                    )),
                  ),
                ])
              : Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
