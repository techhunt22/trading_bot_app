import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradingapp_bot/constants/color_constants.dart';
import 'package:tradingapp_bot/src/data/repositories/bot/start_bot_repo.dart';
import 'package:tradingapp_bot/src/data/repositories/bot/stop_bot_repo.dart';
import 'package:tradingapp_bot/src/viewmodels/bot/start_bot_controller.dart';
import 'package:tradingapp_bot/src/viewmodels/bot/stop_bot_controller.dart';

import '../../../../constants/font_size.dart';
import '../../../../constants/padding.dart';
import '../../../../utils/CustomWidgets/appbar.dart';
import '../../../../utils/CustomWidgets/custom_textfields.dart';
import '../../../../utils/CustomWidgets/customdropdown.dart';
import '../../../data/repositories/accounts/all_accounts_repo.dart';
import '../../../viewmodels/coins/accounts_coins_controller.dart';
import '../../../viewmodels/socket/socket_controller_new.dart';
import '../../dashboard_screen.dart';

class BotStartScreen extends StatefulWidget {
  const BotStartScreen({super.key});

  @override
  State<BotStartScreen> createState() => _BotStartScreenState();
}

class _BotStartScreenState extends State<BotStartScreen> {
  final StartBotController startBotController = Get.put(
      StartBotController(StartBotRepository()));
  final StopBotController stopBotController = Get.put(
      StopBotController(StopBotRepository()));
  final CoinsAccountController accountController = Get.put(
      CoinsAccountController(AllAccountRepository()));

  String? _selectedValue;
  final socketController = Get.find<SocketController>();
  int displayedItemsCount = 25;


  @override
  void initState() {
    super.initState();
    accountController.fetchAccounts();
  }

  @override
  void dispose() {
    super.dispose();
    accountController.resetFields();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.jpg')
          ,
          // Your image file path
          fit: BoxFit.cover,),
      ),
      child:
      Scaffold(
          backgroundColor: transparent,
          drawer: const DrawerMain(),
          body:
          CustomScrollView(
            slivers
                : [
                  const CustomSliverAppBar(
                name: "Bot",
                icon: "assets/icons/manual.svg",
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: globalPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Bot",
                        style:
                        TextStyle(fontSize: headlinesmall,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      const
                      Text
                        (
                        "Start or Stop the Bot",
                        style: TextStyle(
                            fontSize: titlesmall,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 30),
                      Obx
                        (() =>
                            Text(
                              'Connection Status: ${socketController
                                  .connectionStatus.value}',
                              style: TextStyle(
                                  color: white, fontSize: titlemedium),
                            ),
                      ),
                      SizedBox(height: 20),

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
                              style: ButtonStyle(
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadiusDirectional
                                              .circular(15)
                                      )),
                                  backgroundColor: WidgetStatePropertyAll(
                                      purple)

                              ),
                              onPressed: () {
                                accountController.fetchAccounts();
                              },
                              child: Text(
                                "Try Again", style: TextStyle(color: white),),
                            ),

                          ],
                        ) :

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
                              print("ACCOUNT ID ${accountController.idcontroller
                                  .value
                                  .text}  ");
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
                          titleon: false,
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


                      Obx(() {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            startBotController.isLoading.value
                                ? CircularProgressIndicator()
                                : botButton(
                              text: "Start Bot",
                              gradient: true,
                              iscolor: false,
                              ontap: () async {
                                await startBotController.botStart(
                                    accountId: accountController.idcontroller
                                        .value.text);
                                socketController.clearData();
                              },


                            ),
                            stopBotController.isLoading.value
                                ? CircularProgressIndicator()
                                : botButton(
                              text: "Stop Bot",
                              gradient: false,
                              iscolor: true,
                              ontap: () async {
                                await stopBotController.botStop(
                                    accountId: accountController.idcontroller
                                        .value.text);
                                socketController.clearData();
                              },
                            ),
                          ],
                        );
                      }),
                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Coins",
                            style:
                            TextStyle(color: white, fontSize: titlelarge),
                          ),
                          Text(
                            "Filtered Coins",
                            style:
                            TextStyle(color: white, fontSize: titlelarge),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Obx(() {
                            if (socketController.botData.isEmpty) {
                              return Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 20.0),
                                child: Text(
                                  'No coins available.',
                                  style: TextStyle(color: white),
                                ),
                              );
                            }


                            if (kDebugMode) {
                              print(
                                  "BOT DATA COINS : ${socketController.botData
                                      .length}");
                            }
                            return SizedBox(
                              width: 150,
                              child: ListView.builder(
                                padding:
                                const EdgeInsets.symmetric(vertical: 10),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: displayedItemsCount <
                                    socketController.botData.length
                                    ? displayedItemsCount + 1
                                    : socketController.botData.length + 1,

                                itemBuilder: (context, index) {
                                  if (index == displayedItemsCount) {
                                    // Show More button
                                    return ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                          WidgetStatePropertyAll(purple),
                                          shape: WidgetStatePropertyAll(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadiusDirectional
                                                      .circular(15)))),
                                      onPressed: () {
                                        setState(() {
                                          displayedItemsCount +=
                                          25; // Load 10 more items
                                        });
                                      },
                                      child: Text('Show More',
                                          style: TextStyle(color: white)),
                                    );
                                  } else
                                  if (index < socketController.botData.length) {
                                    List<String> fieldsToDisplay = [
                                      "coins",
                                      "message",

                                    ]; // Specify fields to display
                                    List<Widget> items = _buildList(
                                        socketController.botData,
                                        fieldsToDisplay);
                                    return Column(
                                      children: items,
                                    );

                                    // return ListTile(
                                    //   title: Text(
                                    //     ' ${entry.value}',
                                    //     style: TextStyle(
                                    //         color: white, fontSize: bodymedium),
                                    //   ),
                                    // );
                                  } else {
                                    return SizedBox
                                        .shrink(); // Return an empty widget if index is out of bounds
                                  }
                                },
                              )
                              ,
                            );
                          }
                          ),

                          Obx
                            (() {

                            if (socketController.botUpdate.isEmpty) {
                              return Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 20.0),
                                child: Text(
                                  'No coins available.',
                                  style: TextStyle(color: white),
                                ),
                              );
                            }
                            // if (socketController.biggestDumpSymbolController
                            //     .value.text.isNotEmpty) {
                            //   Padding(
                            //     padding: const EdgeInsets.symmetric(
                            //         vertical: 10.0),
                            //     child: Text(
                            //       'Dump Symbol coin received:\n${socketController
                            //           .biggestDumpSymbolController.value
                            //           .text}',
                            //       style: TextStyle(
                            //           color: white, fontSize: bodymedium),
                            //     ),
                            //   );
                            // }

                            if (kDebugMode) {
                              print("BOT UPDATE COINS : ${socketController
                                  .botUpdate.length}");
                            }

                            return SizedBox(
                              width: 150,
                              child: ListView.builder(
                                padding:
                                const EdgeInsets.symmetric(vertical: 10),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: displayedItemsCount <
                                    socketController.botUpdate.length
                                    ? displayedItemsCount + 1
                                    : socketController.botUpdate.length + 1,
                                itemBuilder: (context, index) {
                                  if (index == displayedItemsCount) {
                                    // Show More button
                                    return SizedBox(
                                      height: 45,
                                      width: 100,
                                    );
                                  } else if (index <
                                      socketController.botUpdate.length) {
                                    List<String> fieldsToDisplay = [
                                      "listedCoins",
                                      "message",
                                      "messages",
                                    ]; // Specify fields to display
                                    List<Widget> items = _buildList(
                                        socketController.botUpdate,
                                        fieldsToDisplay);
                                    return Column(
                                      children: items,
                                    );

                                  } else {
                                    return SizedBox
                                        .shrink(); // Return an empty widget if index is out of bounds
                                  }
                                },
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

Widget botButton({required VoidCallback ontap,
  required String text,
  required bool gradient,
  required bool iscolor}) {
  return Container(
    height: 51,
    padding: const EdgeInsets.symmetric(horizontal: 30),
    decoration: BoxDecoration(
        color: iscolor ? red : null,
        gradient: gradient ? buttonlineargradient() : null,
        borderRadius: const BorderRadiusDirectional.all(Radius.circular(10))),
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

List<Widget> _buildList(dynamic data, List<String> fieldsToDisplay) {
  List<Widget> widgets = [];

  if (data is Map<String, dynamic>) {
    data.forEach((key, value) {
      if (fieldsToDisplay.contains(key)) {
        if (value is Map) {
          value.forEach((subKey, subValue) {
            widgets.add(
                Text('$subKey: $subValue', style: TextStyle(color: white)),
            );
          });
        } else if (value is List) {
          for (var element in value) {
            if (element is Map) {
              element.forEach((subKey, subValue) {
                widgets.add(
                  Text('$subKey: $subValue', style: TextStyle(color: white),),
                );
              });
            } else {
              widgets.add(
                Text('$element', style: TextStyle(color: white),),
              );
            }
          }
        } else {
          widgets.add(
            Text('$value', style: TextStyle(color: white),),
          );
        }
      } else {
        // Continue searching in nested structures
        widgets.addAll(_buildList(value, fieldsToDisplay));
      }
    });
  } else if (data is List) {
    for (var element in data) {
      widgets.addAll(_buildList(element, fieldsToDisplay));
    }
  }
  return widgets;
}

