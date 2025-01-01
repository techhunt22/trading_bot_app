import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/color_constants.dart';
import '../../../../constants/font_size.dart';
import '../../../../utils/CustomWidgets/custom_textfields.dart';
import '../../../data/repositories/accounts/create_account_repo.dart';
import '../../../viewmodels/accounts/create_account_controller.dart';

class AddNewAccountScreen extends StatefulWidget {
  const AddNewAccountScreen({super.key});

  @override
  State<AddNewAccountScreen> createState() => _AddNewAccountScreenState();
}

class _AddNewAccountScreenState extends State<AddNewAccountScreen> {
  final accountname = TextEditingController();
  final apikey = TextEditingController();
  final secrekey = TextEditingController();
  final exhchangeid = TextEditingController(text: "Binance");


  final creataccount = Get.put(CreateAccountController(CreateAccountRepository()));

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    accountname.dispose();
    apikey.dispose();
    secrekey.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Add New Account",
              style: TextStyle(
                  fontSize: headlinesmall, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextField(
              fillColor: background,
              controller: accountname,
              titleon: true,
              hinttext: "Account Name",
              readonly: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
              keyboardType: TextInputType.text,
              textColor: white,
              action: TextInputAction.done,
              text: "Account Name",
            ),
            const SizedBox(
              height: 20,
            ),

            CustomTextField(
              fillColor: background,
              readonly: true,
              titleon: true,
              controller: exhchangeid,
              hinttext: "",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
              keyboardType: TextInputType.none,
              textColor: white,
              action: TextInputAction.done,
              text: "Exchange ID",
            ),


            const SizedBox(
              height: 20,
            ),
            CustomPasswordField(
              fillColor: background,
              controller: apikey,
              hinttext: "Your API Key",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
              keyboardType: TextInputType.text,
              textColor: white,
              text: "API Key",
            ),
            const SizedBox(
              height: 20,
            ),

            CustomPasswordField(
              fillColor: background,
              controller: secrekey,
              hinttext: "Your Secret Key",

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
              keyboardType: TextInputType.text,
              textColor: white,
              text: "Secret Key",
            ),


            const SizedBox(
              height: 50,
            ),
            Center(
              child: Obx(() {
                return   creataccount.isLoading.value  ? const CircularProgressIndicator() :
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      gradient: buttonlineargradient(),
                      borderRadius:
                      const BorderRadiusDirectional.all(Radius.circular(10))),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                      WidgetStateProperty.all(Colors.transparent),
                      // Make button background transparent
                      shadowColor: WidgetStateProperty.all(Colors.transparent),
                      // Remove shadow
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                    ),
                    child: creataccount.isLoading.value
                        ? const CircularProgressIndicator()
                        : const Text(
                      "Add New Account",
                      style: TextStyle(
                          color: white,
                          fontSize: bodylarge,
                          fontWeight: FontWeight.w500),
                    ),
                    onPressed: () {


                     if (_formKey.currentState!.validate()) {
                        // Proceed with account creation if both conditions are fulfilled
                       creataccount.accountcreate(
                         accountName: accountname.text,
                         apiKey: apikey.text,
                         secretKey: secrekey.text,
                       ).then((_) {
                         accountname.clear();
                         apikey.clear();
                         secrekey.clear();
                        });




                      }
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
