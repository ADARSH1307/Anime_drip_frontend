import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/components/colors.dart';
import 'package:shopping_app/screens/checkout/payment_failed_dialogue.dart';
import 'package:shopping_app/uitls/app_dimensions.dart';
import 'package:shopping_app/widgets/big_text.dart';

import '../../base/custom_button.dart';
import 'package:get/get.dart';

import '../../routes/route_helper.dart';
import '../../uitls/styles.dart';

class LoginFailedSuccess extends StatelessWidget {
  LoginFailedSuccess();

  @override
  Widget build(BuildContext context) {
    // if(status == 0) {
    //   Future.delayed(Duration(seconds: 1), () {
    //     Get.dialog(PaymentFailedDialog(orderID: orderID), barrierDismissible: false);
    //   });
    // }
    return Scaffold(
      body: Center(
          child: SizedBox(
              width: Dimensions.WEB_MAX_WIDTH,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 100.0,
                      color: AppColors.mainColor,
                    ),

                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                    BigText(
                        text: "Thanks for Co-operating we will reflect your ",
                        color: AppColors.mainBlackColor),
                    BigText(
                        text: "login credentials soon kindly try to ",
                        color: AppColors.mainBlackColor),
                    BigText(
                        text: "register after some time",
                        color: AppColors.mainBlackColor),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_LARGE,
                          vertical: Dimensions.PADDING_SIZE_SMALL),
                      child: Text(
                        'Sorry for the inconvenience',
                        style: robotoMedium.copyWith(
                            fontSize: Dimensions.fontSizeDefault,
                            color: Theme.of(context).disabledColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 30),

                    // Padding(
                    //   padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    //   child: CustomButton(buttonText: 'back_to_home'.tr, onPressed:
                    //       () => Get.offAllNamed(RouteHelper.getInitialRoute())),
                    // ),
                  ]))),
    );
  }
}
