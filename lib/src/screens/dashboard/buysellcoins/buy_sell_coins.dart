import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradingapp_bot/constants/color_constants.dart';
import 'package:tradingapp_bot/src/data/repositories/coins/buy_coins_repo.dart';
import 'package:tradingapp_bot/src/data/repositories/coins/sell_coins_repo.dart';
import 'package:tradingapp_bot/src/viewmodels/coins/buy_coins_controller.dart';
import 'package:tradingapp_bot/src/viewmodels/coins/sell_coins_controller.dart';
import '../../../../constants/font_size.dart';
import '../../../../utils/CustomWidgets/appbar.dart';
import '../../../../utils/CustomWidgets/custom_textfields.dart';
import '../../../../utils/CustomWidgets/customdropdown.dart';
import '../../../data/repositories/accounts/all_accounts_repo.dart';
import '../../../viewmodels/coins/accounts_coins_controller.dart';
import '../../../viewmodels/socket/socket_controller_new.dart';
import '../../dashboard_screen.dart';

class BuySellCoinsScreen extends StatefulWidget {
  const BuySellCoinsScreen({super.key});

  @override
  State<BuySellCoinsScreen> createState() => _BuySellCoinsScreenState();
}

class _BuySellCoinsScreenState extends State<BuySellCoinsScreen> {
  final TextEditingController quantity = TextEditingController();
  final TextEditingController coinsymbol = TextEditingController();
  bool isManualSymbol = false;  // Track manual symbol entry

  String? _selectedValue;


  final buycoins = Get.put(BuyCoinsController(BuyCoinsRepository()));
  final sellcoins = Get.put(SellCoinsController(SellCoinsRepository()));

  final CoinsAccountController accountController = Get.put(CoinsAccountController(AllAccountRepository()));

  final SocketController socketController = Get.find<SocketController>();


  @override
  void initState() {
    super.initState();
    accountController.fetchAccounts();
  }

  @override
  void dispose() {
    super.dispose();
    _selectedValue = "";
    coinsymbol.dispose();
    quantity.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.jpg'),
          // Your image file path
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          backgroundColor: transparent,
          drawer: const DrawerMain(),
          body: CustomScrollView(
            slivers: [
              const CustomSliverAppBar(
                name: "Buy and Sell",
                icon: "assets/icons/buysellicon.svg",
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Buy and Sell",
                        style: TextStyle(
                            fontSize: headlinesmall,
                            fontWeight: FontWeight.w600),
                      ),
                      const Text(
                        "Select the account you wish to use for buying and selling.",
                        style: TextStyle(
                            fontSize: bodysmall, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(() {
                        return accountController.isLoading.value ?
                        Center(
                          child: CircularProgressIndicator(),
                        ) :
                        accountController.errorMessage.isNotEmpty ?
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
                                accountController.fetchAccounts();
                              },
                              child: Text("Try Again", style: TextStyle(color: white),),
                            ),

                          ],
                        ):

                        accountController.allAccounts.isEmpty ?
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
                        )

                            : CustomDropdown(
                          title: 'Select Account',
                          hintText: 'Select the account',
                          items: accountController.accountItems,
                          selectedValue: _selectedValue,
                          titleon: true,
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value;
                            });
                            if (value != null) {
                              accountController.setSelectedAccount(value);
                            }
                            if (kDebugMode) {
                              print('Selected Account: $_selectedValue');
                            }
                            if (kDebugMode) {
                              print("${accountController.idcontroller.value.text}  ");
                            }
                          },
                        );
                      }),

                      const SizedBox(
                        height: 20,
                      ),
                      Obx(() {
                        return CustomTextField(
                          fillColor: background,
                          controller: accountController.idcontroller.value,
                          readonly: true,
                          titleon: true,
                          hinttext: "Account ID",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field cannot be empty';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          textColor: white,
                          action: TextInputAction.done,
                          text: "Account ID",
                        );
                      }),

                      const SizedBox(
                        height: 20,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Bot Symbol",
                            style: TextStyle(fontSize: bodymedium, color: white),
                          ),
                          SizedBox(width:30 ,),
                          Switch.adaptive(
                            value: isManualSymbol,
                            onChanged: (bool value) {
                              setState(() {
                                isManualSymbol = value;
                              });
                              if (kDebugMode) {
                                print(isManualSymbol);
                              }
                            },
                          ),
                          SizedBox(width:30 ,),

                          Text(
                            "Manual Symbol",
                            style: TextStyle(fontSize: bodymedium, color: white),
                          ),
                        ],
                      ),


                      const SizedBox(height: 20),

                      // Display the symbol input field based on the toggle
                      isManualSymbol
                          ? CustomTextField(
                        fillColor: background,
                        controller: coinsymbol,
                        readonly: false,
                        titleon: true,
                        hinttext: "Enter symbol manually",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field cannot be empty';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textColor: white,
                        action: TextInputAction.done,
                        text: "Manual Symbol",
                      )
                          :  Obx(() {
                            if (kDebugMode) {
                              print(socketController.biggestDumpSymbolController.value);
                            }

                        return CustomTextField(
                          fillColor: background,
                          controller: socketController.biggestDumpSymbolController.value,
                          readonly: true,
                          titleon: true,
                          hinttext: 'Waiting for symbol from bot ' ,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field cannot be empty';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          textColor: white,
                          action: TextInputAction.done,
                          text: "Bot Symbol",
                        );
                      }),


                      const SizedBox(
                        height: 20,
                      ),

                      CustomTextField(
                        fillColor: background,
                        controller: quantity,
                        readonly: false,
                        titleon: true,
                        hinttext: "Quantity",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field cannot be empty';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        textColor: white,
                        action: TextInputAction.done,
                        text: "Quantity",
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx((){
                            return sellcoins.isLoading.value
                                ? Center(
                              child: CircularProgressIndicator(),
                            )
                                : buttonWidget(
                              Border.all(color: purple),
                              null,
                                  () {
                                final quantityValue =
                                double.tryParse(quantity.text);
                                if (quantityValue == null) {
                                  // Show an error message if the input is invalid
                                  if (kDebugMode) {
                                    print('Invalid quantity entered: ${quantity
                                        .text}');
                                  }
                                  Get.snackbar(
                                    'Invalid Input',
                                    'Please enter a valid quantity.',
                                    snackPosition: SnackPosition.BOTTOM,
                                    margin: const EdgeInsets.only(
                                        bottom: 20, right: 20, left: 20),
                                    backgroundColor: red,
                                    colorText: white,
                                    duration: const Duration(seconds: 4),
                                    isDismissible: true,
                                  );
                                  return;
                                }
                                String symbolToUse = isManualSymbol
                                    ? coinsymbol.text
                                    : socketController
                                    .biggestDumpSymbolController
                                    .value
                                    .text;
                                // Proceed with the action (Buy/Sell)
                                if (symbolToUse.isEmpty) {
                                  Get.snackbar(
                                    'Error',
                                    'Please provide a symbol.',
                                    snackPosition: SnackPosition.BOTTOM,
                                    margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                                    backgroundColor: red,
                                    colorText: white,
                                    duration: const Duration(seconds: 4),
                                    isDismissible: true,
                                  );
                                  return;
                                }



                                sellcoins.coinsSell(
                                    accountId: accountController.idcontroller
                                        .value.text,
                                    quantity: quantityValue,
                                    symbol: symbolToUse
                                )
                                    .then((_) {

                                  if (kDebugMode) {
                                    print(
                                        "${accountController.idcontroller.value.text}"
                                            " \n${double.parse(quantity.text )}"
                                            "\n$symbolToUse ");
                                  }
                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                    setState(() {
                                      accountController.resetFields();
                                      quantity.clear();
                                      coinsymbol.clear();
                                      _selectedValue = null;
                                    });
                                  });

                                });
                              },
                              "Sell Coin",
                            );
                          }),
                          const SizedBox(
                            width: 20,
                          ),
                          Obx((){
                            return buycoins.isLoading.value
                                ? Center(
                              child: CircularProgressIndicator(),
                            )
                                : buttonWidget(
                              null,
                              buttonlineargradient(),
                                  () {
                                final quantityValue =
                                double.tryParse(quantity.text);
                                if (quantityValue == null) {
                                  // Show an error message if the input is invalid
                                  if (kDebugMode) {
                                    print('Invalid quantity entered: ${quantity
                                        .text}');
                                  }
                                  Get.snackbar(
                                    'Invalid Input',
                                    'Please enter a valid quantity.',
                                    snackPosition: SnackPosition.BOTTOM,
                                    margin: const EdgeInsets.only(
                                        bottom: 20, right: 20, left: 20),
                                    backgroundColor: red,
                                    colorText: white,
                                    duration: const Duration(seconds: 4),
                                    isDismissible: true,
                                  );
                                  return;
                                }
                                String symbolToUse = isManualSymbol
                                    ? coinsymbol.text
                                    : socketController
                                    .biggestDumpSymbolController
                                    .value
                                    .text;
                                // Proceed with the action (Buy/Sell)
                                if (symbolToUse.isEmpty) {
                                  Get.snackbar(
                                    'Error',
                                    'Please provide a symbol.',
                                    snackPosition: SnackPosition.BOTTOM,
                                    margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                                    backgroundColor: red,
                                    colorText: white,
                                    duration: const Duration(seconds: 4),
                                    isDismissible: true,
                                  );
                                  return;
                                }

                                buycoins.coinsBuys(
                                    accountId: accountController.idcontroller
                                        .value.text,
                                    quantity: quantityValue,
                                    symbol: symbolToUse
                                )
                                    .then((_) {
                                  if (kDebugMode) {
                                    print(
                                        "${accountController.idcontroller.value.text}"
                                            " \n${double.parse(quantity.text )}"
                                            "\n$symbolToUse");
                                    WidgetsBinding.instance.addPostFrameCallback((_) {
                                      setState(() {
                                        accountController.resetFields();
                                        quantity.clear();
                                        coinsymbol.clear();
                                        _selectedValue = null;
                                      });
                                    });


                                    setState(() {
                                      _selectedValue = null;
                                    });


                                  }});
                              },
                              "Buy Coin",
                            );
                          })
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

Widget buttonWidget(BoxBorder? border, Gradient? gradient, VoidCallback ontap,
    String text) {
  return Container(
    height: 51,
    padding: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
        border: border),
    child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          // Make button background transparent
          shadowColor: WidgetStateProperty.all(Colors.transparent),
          // Remove shadow
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
        ),
        onPressed: ontap,
        child: Text(
          text,
          style: TextStyle(
              color: white, fontSize: bodylarge, fontWeight: FontWeight.w500),
        )),
  );
}
