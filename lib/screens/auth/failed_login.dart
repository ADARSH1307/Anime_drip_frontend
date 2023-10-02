import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:shopping_app/base/custom_snackbar.dart';
import 'package:shopping_app/components/colors.dart';
import 'package:shopping_app/data/api/callapi.dart';
import 'package:shopping_app/screens/auth/success_login.dart';
import 'package:shopping_app/screens/reviews/defaultAppBar.dart';
import 'package:shopping_app/screens/reviews/defaultBackButton.dart';
import 'package:shopping_app/uitls/app_constants.dart';
import 'package:shopping_app/widgets/app_text_field.dart';
import 'package:shopping_app/widgets/big_text.dart';
import 'package:shopping_app/widgets/mobile_verify.dart';


class FailedLoginPage extends StatefulWidget {
  const FailedLoginPage({Key? key}) : super(key: key);

  @override
  State<FailedLoginPage> createState() => _FailedLoginPageState();
}

class _FailedLoginPageState extends State<FailedLoginPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  String? gender;
  @override
  Widget build(BuildContext context) {
    _register() {
      // var reviewController = Get.find<ReviewController>();
      var _phone = phoneController.text.trim();
      var _comment = commentController.text;
      var _deliverypending = gender;
      // print(_rating);
      //print(widget.orderId.toString());
      var data = {
        'phone': phoneController.text.trim(),
        'comment': commentController.text.trim(),
        'delivery_pending': gender,
      };
      print(data);

      // bool validateMobile(String value) {
      //   String pattern = r'^(?:[+0-9]{3})? ?[0-9]{10}$';
      //   RegExp regExp = new RegExp(pattern);
      //   if (value.length == 0) {
      //     return true;
      //   } else if (!regExp.hasMatch(value)) {
      //     return true;
      //   }
      //   return false;
      // }

      // validateMobile(_phone);
      if (MobileVerify.validateMobile(_phone)) {
        showCustomSnackBar('Enter valid 10 digit number ');
      } else if (_deliverypending == null) {
        showCustomSnackBar('Fill out the delivery pending status');
        return;
      } else {
        // var btnclicked = 1;
        showCustomSnackBar('Form submitted successfully!!!',
            isError: false, title: 'Thanks For Co-operating');
        var res =
            CallApi().postFailedlogin(data, AppConstants.FAILED_LOGIN_URI);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => LoginFailedSuccess(),
          ),
        );

        // showCustomSnackBar("Your Review will be updated Shortly!!!",
        //    isError: false, title: "Review Updated");
        // ReviewBody reviewBody =
        //     Rev4iewBody(name: _name, productReview: _productReview);
        // print(reviewBody.toString());
        // reviewController.reviewpost(reviewBody).then((status) {
        //   if (status.isSuccess) {
        //     print("Success");
        //   }
        // });
      }
    }

    return Scaffold(

        // appBar: DefaultAppBar(
        //   title: "Failed Login",
        //   child: DefaultBackButton(),
        // ),
        body: SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              // BigText(text: "   Enter Name", color: AppColors.mainBlackColor),
              BigText(
                text: "Failed Login",
                color: AppColors.mainBlackColor,
                size: 30,
              ),
              SizedBox(
                height: 40,
              ),
              AppTextField(
                hintText: "phone".tr,
                textController: phoneController,
                icon: Icons.person,
              ),
              SizedBox(
                height: 25,
              ),

              AppTextField(
                maxLines: true,
                hintText: "Any other problem specify here(optional)".tr,
                textController: commentController,
                icon: Icons.description,
              ),
              SizedBox(
                height: 20,
              ),
              BigText(
                  text: "Do you have any pending delivery",
                  color: AppColors.mainBlackColor),
              RadioListTile(
                title: Text("Yes"),
                value: "Yes",
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = value.toString();
                    //print(gender);
                  });
                },
              ),

              RadioListTile(
                title: Text("No"),
                value: "No",
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = value.toString();
                  });
                },
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
                        borderRadius: BorderRadius.circular(15),
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
            ],
          )),
    ));
  }
  
 
  
 
}
