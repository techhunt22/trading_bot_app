import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tradingapp_bot/Constants/font_size.dart';

import '../../../../../constants/color_constants.dart';
import '../../../../../utils/CustomWidgets/customdropdown.dart';

class ContentWidget5 extends StatefulWidget {
  final Function onNext;
  final Function onPrevious;

  const ContentWidget5(
      {super.key, required this.onNext, required this.onPrevious});

  @override
  State<ContentWidget5> createState() => _ContentWidget5State();
}

class _ContentWidget5State extends State<ContentWidget5> {
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
          padding:
              const EdgeInsets.only(left: 15, top: 20, right: 15, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "SPIKE Strategy",
                style: TextStyle(
                    fontSize: headlinesmall, fontWeight: FontWeight.w600),
              ),
              buildSizedBox(),
              buildRichText(),
              buildSizedBox(),
              buildcheckbox(),
              buildSizedBox(),
              buildCustomDropdown(
                title: "Use Fund %",
                hinttext: '25',
              ),
              buildSizedBox(),
              buildCustomDropdown(
                title: "Take Profit %",
                hinttext: '0.5',
              ),
              buildSizedBox(),
              buildCustomDropdown(title: "Stop Loss %", hinttext: '0.5'),
              buildSizedBox(),
              buildCustomDropdown(title: "Maximum open positions %", hinttext: '1'),


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
                        ontap: () {},
                        text: "Start",
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
          'Use Spike Strategy',
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

  RichText buildRichText() {
    return RichText(
      text: const TextSpan(
        style: TextStyle(color: Colors.black), // Base style
        children: [
          TextSpan(
            text:
                'Binance Global (Future market - Short only), suitable to a downtrend market (This strategy only uses 1x leverage).'
                ' For more info, please read THIS article.\n\n',
            style: TextStyle(fontSize: bodymedium, color: white),
          ),
          TextSpan(
            text: 'Note:\n',
            style: TextStyle(
                fontSize: bodymedium,
                color: white,
                fontWeight: FontWeight.w600),
          ),
          TextSpan(
            text:
                'When creating an API Key, you need to enable “Future” option (Very Risky)',
            style: TextStyle(fontSize: bodymedium, color: white),
          ),
        ],
      ),
    );
  }
}
