import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradingapp_bot/constants/font_size.dart';
import 'package:tradingapp_bot/constants/padding.dart';
import 'package:tradingapp_bot/utils/CustomWidgets/custom_textfields.dart';
import '../../../../constants/color_constants.dart';
import '../../../../utils/CustomWidgets/customdropdown.dart';

import '../../../viewmodels/accounts/all_accounts_controller.dart';
import '../../../viewmodels/accounts/update_account_controller.dart';

class CurrentAccountScreen extends StatefulWidget {
  const CurrentAccountScreen({super.key});

  @override
  State<CurrentAccountScreen> createState() => _CurrentAccountScreenState();
}

class _CurrentAccountScreenState extends State<CurrentAccountScreen> {
  String? _selectedValue;

  final _formKey = GlobalKey<FormState>();

  final AllAccountController allaccount = Get.find<AllAccountController>();
  final UpdateAccountController updateController = Get.find<UpdateAccountController>();
  @override
  void initState() {
    super.initState();
    allaccount.accountAll();

  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: globalPadding,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Current Account",
              style:
                  TextStyle(fontSize: headlinesmall, fontWeight: FontWeight.w600),
            ),
            const Text(
              "Select the account that you want the bot to connect to",
              style: TextStyle(fontSize: bodysmall, fontWeight: FontWeight.w400),
            ),
            Obx(() {
              final accountItems =
                  allaccount.accountIds.map((id) => {'value': id}).toList();

              return CustomDropdown(
                title: '',
                hintText: 'Select the account',
                items: accountItems,
                selectedValue: _selectedValue,
                titleon: true,

                onChanged: (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                  if (value != null) {
                    allaccount.fetchAccountDetails(value);
                  }
                  // Add your debug print statement if needed
                  if (kDebugMode) {
                    print(value);
                  }
                },
              );
            }),
            const SizedBox(
              height: 20,
            ),
            Obx(() {
              return Column(
                children: [
                  CustomTextField(
                    fillColor: background,
                    controller: allaccount.accountName.value,

                    hinttext: "Account Name",
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
                    text: "Exchange ID",
                    controller: allaccount.exchangeId.value,
                    hinttext: "Exchange ID",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field cannot be empty';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    textColor: white,
                    action: TextInputAction.done,

                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomPasswordField(
                    fillColor: background,
                    controller: allaccount.apiKey.value,
                    hinttext: "Your API key",
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
                    controller: allaccount.secretKey.value,
                    hinttext: "Your Secret key",
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
                    height: 20,
                  ),

                  CustomPasswordField(
                    fillColor: background,
                    controller: allaccount.passphrase.value,
                    hinttext: "Only available on Kucoin",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field cannot be empty';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    textColor: white,
                    text: "Passphrase",
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  CustomTextField(
                    fillColor: background,
                    controller: allaccount.telegramId.value,
                    hinttext: "Your Telegram User ID. It should be a number",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field cannot be empty';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    textColor: white,
                    action: TextInputAction.done,
                    text: "Telegram User ID",
                  ),
                ],
              );
            }),

            const SizedBox(
              height: 50,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 51,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadiusDirectional.all(Radius.circular(10)),
                      border: Border.all(color: purple)),
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
                      onPressed: () {},
                      child: const Text(
                        "Delete",
                        style: TextStyle(
                            color: white,
                            fontSize: bodylarge,
                            fontWeight: FontWeight.w500),
                      )),
                ),
                const SizedBox(
                  width: 20,
                ),


                Container(
                  height: 51,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (_selectedValue == null || _selectedValue!.isEmpty) {
                            Get.snackbar(
                              'Error',
                              'Please select an account',
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                              margin: const EdgeInsets.only(
                                  bottom: 20, right: 20, left: 20),
                            );
                          } else {
                            updateController.accountupdate(
                              accountId: _selectedValue!,
                              type: _selectedValue!,
                              accountName: allaccount.accountName.value.text,
                              exchangeId: allaccount.exchangeId.value.text,
                              apiKey: allaccount.apiKey.value.text,
                              secretKey: allaccount.secretKey.value.text,
                              passphrase: allaccount.passphrase.value.text,
                              telegramUserId: allaccount.telegramId.value.text,
                            );
                          }
                        }
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(
                            color: white,
                            fontSize: bodylarge,
                            fontWeight: FontWeight.w500),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
