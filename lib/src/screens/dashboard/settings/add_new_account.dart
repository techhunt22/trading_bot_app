import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/color_constants.dart';
import '../../../../constants/font_size.dart';
import '../../../../constants/padding.dart';
import '../../../../utils/CustomWidgets/custom_textfields.dart';
import '../../../../utils/CustomWidgets/customdropdown.dart';
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
  final passphrase = TextEditingController();
  final telegramid = TextEditingController();

  final List<Map<String, dynamic>> _exhangeid = [
    {'value': 'Binance', 'icon': "assets/icons/binance.png"},
    {'value': 'Coinbase', 'icon': "assets/icons/binanceus.png"},
    {'value': 'KuCoin', 'icon': "assets/icons/bittrex.png"},
    {'value': 'Crypto', 'icon': "assets/icons/button.png"},
    {'value': 'OKX', 'icon': "assets/icons/huobi.png"},
    {'value': 'Karakin', 'icon': "assets/icons/kucoin.png"},

  ];

  String? _selectedValue;

  final creataccount = Get.put(CreateAccountController(CreateAccountRepository()));

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    accountname.dispose();
    apikey.dispose();
    secrekey.dispose();
    passphrase.dispose();
    telegramid.dispose();
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



            CustomDropdown(
              title: 'Exchange ID',
              hintText: 'Select Exchange ID',
              items: _exhangeid,
              selectedValue: _selectedValue,
              titleon: true,

              onChanged: (value) {
                setState(() {
                  _selectedValue = value;
                });
                // Add your debug print statement if needed
                if (kDebugMode) {
                  print(_selectedValue);
                }
              },
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
              height: 20,
            ),
            CustomPasswordField(
              fillColor: background,
              controller: passphrase,
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
              controller: telegramid,
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
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
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
                  child: const Text(
                    "Add New Account",
                    style: TextStyle(
                        color: white,
                        fontSize: bodylarge,
                        fontWeight: FontWeight.w500),
                  ),
                  onPressed: () {
                    if (_selectedValue == null || _selectedValue!.isEmpty) {
                      Get.snackbar('Error', 'Please select an Exchange ID',
                          backgroundColor: red,
                        colorText: white,
                          snackPosition: SnackPosition.BOTTOM,
                        margin: const EdgeInsets.only(bottom: 20,right: 20,left: 20),

                      );
                    }

                    else if (_formKey.currentState!.validate()) {
                      // Proceed with account creation if both conditions are fulfilled
                      creataccount.accountcreate(
                        type: _selectedValue!,
                        accountName: accountname.text,
                        exchangeId: _selectedValue!,
                        apiKey: apikey.text,
                        secretKey: secrekey.text,
                        passphrase: passphrase.text,
                        telegramUserId: telegramid.text,
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
