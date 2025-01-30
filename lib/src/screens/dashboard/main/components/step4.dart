import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tradingapp_bot/Constants/font_size.dart';

import '../../../../../constants/color_constants.dart';
import '../../../../../utils/CustomWidgets/customdropdown.dart';

class ContentWidget4 extends StatefulWidget {
  final Function onNext;
  final Function onPrevious;

  const ContentWidget4(
      {super.key, required this.onNext, required this.onPrevious});

  @override
  State<ContentWidget4> createState() => _ContentWidget4State();
}

class _ContentWidget4State extends State<ContentWidget4> {
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
          color: purple.withValues(alpha: 0.6),
          thickness: 2.5,
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 15, top: 20, right: 15, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "DIP Strategy",
                style: TextStyle(
                    fontSize: headlinesmall, fontWeight: FontWeight.w600),
              ),
              buildSizedBox(),
              const Text(
                "All exchanges (Spot market), suitable to an uptrend/sideway market (Kinda risky)",
                style: TextStyle(
                    fontSize: bodymedium, fontWeight: FontWeight.w400),
              ),
              buildSizedBox(),
              buildcheckbox(),
              buildSizedBox(),
              buildCustomDropdown(
                title: "Market Place",
                hinttext: '25',
              ),
              buildSizedBox(),
              buildCustomDropdown(
                title: "Use Fund %",
                hinttext: '15 %',
              ),
              buildSizedBox(),
              buildCustomDropdown(title: "Stop Loss %", hinttext: '15 %'),
              buildSizedBox(),
              buildCustomDropdown(title: "Stable Market", hinttext: 'USDT'),
              buildSizedBox(),
              Row(
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
                    'Use Stable Market',
                    style: TextStyle(fontSize: bodymedium, color: white),
                  ),
                ],
              ),
              buildSizedBox(),
              buildCustomDropdown(
                  title: "Maximum open orders", hinttext: '2'),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: buildContainer(
                        ontap: () => widget.onPrevious(),
                        text: "Previous",
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadiusDirectional.all(
                                Radius.circular(10)),
                            border: Border.all(color: purple)),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: buildContainer(
                        ontap: () => widget.onNext(),
                        text: "Next",
                        decoration: BoxDecoration(
                            gradient: buttonlineargradient(),
                            borderRadius: const BorderRadiusDirectional.all(
                                Radius.circular(10))),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  CustomDropdown buildCustomDropdown(
      {required String title, required String hinttext}) {
    return CustomDropdown(
      title: title,
      hintText: hinttext,
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
    );
  }

  SizedBox buildSizedBox() {
    return const SizedBox(
      height: 20,
    );
  }

  Container buildContainer(
      {required VoidCallback ontap,
      required String text,
      required BoxDecoration decoration}) {
    return Container(
      height: 51,
      decoration: decoration,
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
            style: const TextStyle(
                color: white, fontSize: bodylarge, fontWeight: FontWeight.w500),
          )),
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
          'Use Dip Strategy',
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
          'Check Volatile market',
          style: TextStyle(fontSize: bodymedium, color: white),
        ),
      ],
    );
  }
}
