import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradingapp_bot/constants/font_size.dart';
import 'package:tradingapp_bot/utils/CustomWidgets/custom_textfields.dart';
import '../../../../constants/color_constants.dart';
import '../../../../utils/CustomWidgets/customdropdown.dart';

import '../../../viewmodels/accounts/all_accounts_controller.dart';
import '../../../viewmodels/accounts/delete_account_controller.dart';
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
  final DeleteAccountController delectaccount = Get.find<DeleteAccountController>();
  final UpdateAccountController updateController = Get.find<UpdateAccountController>();
  final TextEditingController exhchangeid = TextEditingController(text: "Binance");

  @override
  void initState() {
    super.initState();
    allaccount.accountAll();
  }
  @override
  void dispose() {
    super.dispose();
    allaccount.resetFields();
    exhchangeid.dispose();
    _selectedValue = "";

  }


  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child:
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              "Current Account",
              style: TextStyle(
                  fontSize: headlinesmall, fontWeight: FontWeight.w600),
            ),
            const Text(
              "Select the account that you want the bot to connect to",
              style:
              TextStyle(fontSize: bodysmall, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() {
              final accountItems =
              allaccount.accountIds.map((id) => {'value': id}).toList();

              return allaccount.isLoading.value ?
              Center(
                child: CircularProgressIndicator(),
              ):

              allaccount.errorMessage.isNotEmpty ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Failed to fetch\nAll Accounts ID."),
                      ElevatedButton(
                        style : ButtonStyle(
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(15)
                          )),
                          backgroundColor: WidgetStatePropertyAll(purple)

                        ),
                        onPressed: (){
                        allaccount.accountAll();
                      },
                        child: Text("Try Again", style: TextStyle(color: white),),
                      ),

                    ],
                  ):

              allaccount.allAccounts.isEmpty ?
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("No Accounts to show.\nAdd Accounts "),
                  // ElevatedButton(
                  //   style : ButtonStyle(
                  //       shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  //           borderRadius: BorderRadiusDirectional.circular(15)
                  //       )),
                  //       backgroundColor: WidgetStatePropertyAll(purple)
                  //
                  //   ),
                  //   onPressed: (){
                  //     allaccount.accountAll();
                  //   },
                  //   child: Text("Try Again", style: TextStyle(color: white),),
                  // ),

                ],
              ):



              CustomDropdown(
                title: 'Account ID',
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
                    controller: allaccount.accname.value,
                    readonly: false,
                    titleon: true,
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
                    readonly: true,
                    titleon: true,
                    controller: exhchangeid,
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      delectaccount.isLoading.value
                          ? const CircularProgressIndicator()
                          : Container(
                        height: 51,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadiusDirectional.all(
                                Radius.circular(10)),
                            border: Border.all(color: purple)),
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                              WidgetStateProperty.all(Colors.transparent),
                              // Make button background transparent
                              shadowColor:
                              WidgetStateProperty.all(Colors.transparent),
                              // Remove shadow
                              shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (_selectedValue == null ||
                                    _selectedValue!.isEmpty) {
                                  Get.snackbar(
                                    'Error',
                                    'Please select an account',
                                    backgroundColor: red,
                                    colorText: white,
                                    snackPosition: SnackPosition.BOTTOM,
                                    margin: const EdgeInsets.only(
                                        bottom: 20, right: 20, left: 20),
                                  );
                                } else {
                                  // Call the delete account method
                                  delectaccount
                                      .deleteAccountId(
                                      accountId: _selectedValue!)
                                      .then((_) {

                                    // After successful deletion, reset the fields
                                    setState(() {
                                      // Reset the selected value
                                      _selectedValue = null;
                                    });
                                    allaccount.accountAll();
                                    allaccount.resetFields();
                                  }).catchError((error) {
                                    // Handle error if deletion fails
                                    Get.snackbar(
                                      'Error',
                                      'Failed to delete the account',
                                      backgroundColor: red,
                                      colorText: white,
                                      snackPosition: SnackPosition.BOTTOM,
                                      margin: const EdgeInsets.only(
                                          bottom: 20, right: 20, left: 20),
                                    );
                                  });
                                }
                              }
                            },
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
                      updateController.isLoading.value  ? const CircularProgressIndicator() :
                      Container(
                        height: 51,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                            gradient: buttonlineargradient(),
                            borderRadius: const BorderRadiusDirectional.all(
                                Radius.circular(10))),
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                              WidgetStateProperty.all(Colors.transparent),
                              // Make button background transparent
                              shadowColor:
                              WidgetStateProperty.all(Colors.transparent),
                              // Remove shadow
                              shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (_selectedValue == null ||
                                    _selectedValue!.isEmpty) {
                                  Get.snackbar(
                                    'Error',
                                    'Please select an account',
                                    backgroundColor: red,
                                    colorText: white,
                                    snackPosition: SnackPosition.BOTTOM,
                                    margin: const EdgeInsets.only(
                                        bottom: 20, right: 20, left: 20),
                                  );
                                } else {
                                  if (kDebugMode) {
                                    print(_selectedValue!);
                                    print(allaccount.apiKey.value.text);
                                    print(allaccount.secretKey.value.text);
                                  }

                                  updateController.accountupdate(
                                    accountId: _selectedValue!,
                                    accountName: allaccount.accname.value.text,
                                    apiKey: allaccount.apiKey.value.text,
                                    secretKey:
                                    allaccount.secretKey.value.text,
                                  ).then((_){
                                    allaccount.accountAll();
                                    setState(() {
                                      // Reset the selected value
                                      _selectedValue = null;
                                    });
                                    allaccount.resetFields();
                                  });


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
              );
            }

            )
          ]),
        ));
  }
}
