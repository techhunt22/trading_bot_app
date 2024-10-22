import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tradingapp_bot/Constants/font_size.dart';

import '../../../../../constants/color_constants.dart';
import '../../../../../utils/CustomWidgets/customdropdown.dart';





class ContentWidget1 extends StatefulWidget {
  final Function onNext;
  final Function onPrevious;

  const ContentWidget1(
      {super.key, required this.onNext, required this.onPrevious});

  @override
  State<ContentWidget1> createState() => _ContentWidget1State();
}

class _ContentWidget1State extends State<ContentWidget1> {
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;

  final List<Map<String, dynamic>> _exhangeid = [
    {'value': 'Binance', 'icon': "assets/icons/binance.png"},
    {'value': 'Coinbase', 'icon': "assets/icons/binanceus.png"},
    {'value': 'KuCoin', 'icon': "assets/icons/bittrex.png"},
    {'value': 'Crypto', 'icon': "assets/icons/button.png"},
    {'value': 'OKX', 'icon': "assets/icons/huobi.png"},
    {'value': 'Karakin', 'icon': "assets/icons/kucoin.png"},
  ];

  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: purple.withOpacity(0.6),
          thickness: 2.5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15,top: 20,right: 15,bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              const Text(
                "Global Settings",
                style: TextStyle(
                    fontSize: headlinesmall, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Select One",
                style: TextStyle(
                  fontSize: bodymedium,
                ),
              ),
              buildcheckbox(),
              const SizedBox(
                height: 20,
              ),
              CustomDropdown(
                title: "Time Order Expiration",
                hintText: 'Select Exchange ID',
                titleon: true,
                items: _exhangeid,
                selectedValue: _selectedValue,
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                  if (kDebugMode) {
                    print(_selectedValue);
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomDropdown(
                title: "Time Frame",
                hintText: '5 Minutes',
                titleon: true,

                items: _exhangeid,
                selectedValue: _selectedValue,
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                  if (kDebugMode) {
                    print(_selectedValue);
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),


              CustomDropdown(
                title: "Trading Strictness",
                hintText: 'Medium',
                items: _exhangeid,
                selectedValue: _selectedValue,
                titleon: true,

                onChanged: (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                  if (kDebugMode) {
                    print(_selectedValue);
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Skip Symbols",
                style: TextStyle(
                    fontSize: titlesmall,
                    fontWeight: FontWeight.w400,
                    color: white),
              ),
              const SizedBox(
                height: 10,
              ),

              Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.circular(10),

                ),
                child: const Center(child: Text("Skip Symbols")),


              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Checkbox(
                    value: isChecked3,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked3 = value!;
                      });
                    },
                    activeColor: purple,
                    checkColor: white,
                  ),
                  const Text(
                    'Reverse',
                    style: TextStyle(fontSize: bodymedium, color: white),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CustomDropdown(
                title: "Minimum Volume",
                hintText: '50000 USD',
                titleon: true,

                items: _exhangeid,
                selectedValue: _selectedValue,
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                  if (kDebugMode) {
                    print(_selectedValue);
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomDropdown(
                title: "Mode",
                hintText: 'Live',
                items: _exhangeid,
                selectedValue: _selectedValue,
                titleon: true,

                onChanged: (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                  if (kDebugMode) {
                    print(_selectedValue);
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomDropdown(
                title: "Scan interval",
                hintText: '10 seconds',
                titleon: true,

                items: _exhangeid,
                selectedValue: _selectedValue,
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                  if (kDebugMode) {
                    print(_selectedValue);
                  }
                },
              ),
              const SizedBox(
                height: 50,
              ),

              Center(
                child: Container(
                  height: 50,
                  width: 144,

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
                      "Next",
                      style: TextStyle(
                          color: white,
                          fontSize: bodylarge,
                          fontWeight: FontWeight.w500),
                    ),
                    onPressed: () =>widget.onNext(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row buildcheckbox() {
    return Row(
      children: [
        Checkbox(
          value: isChecked1,
          onChanged: (bool? value) {
            setState(() {
              isChecked1 = value!;
            });
          },
          activeColor: purple,
          checkColor: white,
        ),
        const Text(
          'Reinvestment',
          style: TextStyle(fontSize: bodymedium, color: white),
        ),
        const SizedBox(
          width: 20,
        ),
        Checkbox(
          value: isChecked2,
          onChanged: (bool? value) {
            setState(() {
              isChecked2 = value!;
            });
          },
          activeColor: purple,
          checkColor: white,
        ),
        const Text(
          'Break-Even Stop Loss',
          style: TextStyle(fontSize: bodymedium, color: white),
        ),
      ],
    );
  }
}
