import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tradingapp_bot/Constants/font_size.dart';

import '../../../../../constants/color_constants.dart';
import '../../../../../utils/CustomWidgets/customdropdown.dart';

class ContentWidget2 extends StatefulWidget {
  final Function onNext;
  final Function onPrevious;

  const ContentWidget2(
      {super.key, required this.onNext, required this.onPrevious});

  @override
  State<ContentWidget2> createState() => _ContentWidget2State();
}

class _ContentWidget2State extends State<ContentWidget2> {
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
                "Market-Neutral Strategy",
                style: TextStyle(
                    fontSize: headlinesmall, fontWeight: FontWeight.w600),
              ),
              buildSizedBox(),

              buildRichText(),

              buildSizedBox(),

              buildCheckbox(),

              buildSizedBox(),


              buildCustomDropdown(
                title: "Maximum open positions",
                hinttext: '2',
              ),

              buildSizedBox(),
              buildCustomDropdown(
                  title: "Use Amount \$",
                  hinttext: '20',
              ),


              buildSizedBox(),

              buildCustomDropdown(
                title: "Funding Fee Threshold",
                hinttext: '0.1'
              ),
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
                            borderRadius:
                            const BorderRadiusDirectional.all(Radius.circular(10)),
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

  CustomDropdown buildCustomDropdown({required String title, required String hinttext}) {
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

  Container buildContainer({required VoidCallback ontap, required String text, required BoxDecoration decoration}) {
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

  RichText buildRichText() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black), // Base style
        children: [
          const TextSpan(
            text:
                'Binance Global (Spot and Future market). Basically, you buy on the spot '
                'market and short on the future market at the same time to earn '
                'funding fee – need USDT to operate (you can check it ',
            style: TextStyle(fontSize: bodymedium, color: white),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: GestureDetector(
              onTap: () {},
              child: const Text(
                'HERE ',
                style: TextStyle(
                  fontSize: bodymedium,
                  color: purple,
                ),
              ),
            ),
          ),
          const TextSpan(
            text: '). (Pretty safe, almost no risk)',
            style: TextStyle(fontSize: bodymedium, color: white),
          ),
        ],
      ),
    );
  }

  Widget buildCheckbox() {
    return
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
            'Use Market-Neutral strategy',
            style: TextStyle(fontSize: bodymedium, color: white),
          ),
        ],
      );

  }
}
