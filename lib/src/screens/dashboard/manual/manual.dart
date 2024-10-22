import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tradingapp_bot/constants/color_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../constants/font_size.dart';
import '../../../../constants/padding.dart';
import '../../../../utils/CustomWidgets/appbar.dart';
import '../../../../utils/CustomWidgets/custom_textfields.dart';
import '../../../../utils/CustomWidgets/customdropdown.dart';
import '../../dashboard_screen.dart';

class Manual extends StatefulWidget {
  const Manual({super.key});

  @override
  State<Manual> createState() => _ManualState();
}

class _ManualState extends State<Manual> with TickerProviderStateMixin{
  final List<Map<String, dynamic>> _exhangeid = [
    {'value': 'Binance', 'icon': "assets/icons/binance.png"},
    {'value': 'Coinbase', 'icon': "assets/icons/binanceus.png"},
    {'value': 'KuCoin', 'icon': "assets/icons/bittrex.png"},
    {'value': 'Crypto', 'icon': "assets/icons/button.png"},
    {'value': 'OKX', 'icon': "assets/icons/huobi.png"},
    {'value': 'Karakin', 'icon': "assets/icons/kucoin.png"},
  ];
  String? _selectedValue;
  final accountname = TextEditingController();

  bool _isplay = false;

  late AnimationController _controller;


  @override
  void dispose() {
    _controller.dispose;
    super.dispose();
  }

  late final WebViewController controller;
  String htmlContent = '''
<!-- TradingView Widget BEGIN -->
<div class="tradingview-widget-container">
  <div class="tradingview-widget-container__widget"></div>
  <div class="tradingview-widget-copyright"><a href="https://www.tradingview.com/" rel="noopener nofollow" target="_blank"><span class="blue-text">Track all markets on TradingView</span></a></div>
  <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-advanced-chart.js" async>
  {
  "width": "1000",
  "height": "1200",
  "symbol": "NASDAQ:AAPL",
  "interval": "D",
  "timezone": "Etc/UTC",
  "theme": "dark",
  "style": "1",
  "locale": "en",
  "hide_top_toolbar": true,
  "allow_symbol_change": true,
  "calendar": false,
  "support_host": "https://www.tradingview.com"
}
  </script>
</div>
<!-- TradingView Widget END -->
''';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this
    );
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('progress');
          },
          onPageStarted: (String url) {
            debugPrint('started');
          },
          onPageFinished: (String url) {
            debugPrint('finished');
          },
        ),
      )
      ..enableZoom(false)

      ..loadHtmlString(htmlContent);
  }
  final TransformationController _transformationController = TransformationController();
  double _currentScale = 1.0; // Track the current scale for zoom

  void _zoomIn() {
    setState(() {
      _currentScale += 0.2; // Increase the zoom level
      _transformationController.value = Matrix4.identity()..scale(_currentScale);
    });
  }

  void _zoomOut() {
    setState(() {
      if (_currentScale > 1.0) {
        _currentScale -= 0.2; // Decrease the zoom level
        _transformationController.value = Matrix4.identity()..scale(_currentScale);
      }
    });
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
                name: "Manual",
                icon: "assets/icons/manual.svg",
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: globalPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const SizedBox(
                        height: 20,
                      ),

                      SizedBox(
                        height: 500,
                        child: InteractiveViewer(
                          scaleEnabled: true,
                          transformationController: _transformationController,

                          child: Center(
                            child: WebViewWidget(controller: controller),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: _zoomIn,
                              icon: const Icon(Icons.zoom_in_rounded,color: white,size: 60,),
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                              onPressed: _zoomOut,
                              icon: const Icon(Icons.zoom_out_rounded,color: white,size: 60,),
                            ),
                          ],
                        ),
                      ),


                      const Text(
                        "Market",
                        style: TextStyle(
                            fontSize: headlinesmall,
                            fontWeight: FontWeight.w600),
                      ),
                      CustomDropdown(
                        hintText: 'USDT',
                        titleon: false,
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
                      const Text(
                        "Buy / Sell",
                        style: TextStyle(
                            fontSize: headlinesmall,
                            fontWeight: FontWeight.w600),
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      CustomDropdown(
                        title: "Entry Price",
                        hintText: 'Market',
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
                      CustomTextField(
                        fillColor: background,
                        controller: accountname,
                        titleon: false,
                        hinttext: "0",
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
                        height: 30,
                      ),
                      CustomDropdown(
                        title: "Amount",
                        hintText: 'Percentage',
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
                      CustomTextField(
                        fillColor: background,
                        controller: accountname,
                        titleon: false,
                        hinttext: "5",
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
                        height: 30,
                      ),
                      CustomDropdown(
                        title: "Take Profit in Percent%",
                        hintText: '10%',
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
                        title: "Stop Loss in Percent%",
                        hintText: '0.5%',
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


                      Container(
                        height: 60,
                        margin: const EdgeInsets.symmetric(horizontal: 100),
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
                              setState(() { // Ensure the widget rebuilds
                                if (_isplay == false) {
                                  _controller.forward();
                                  _isplay = true;
                                } else {
                                  _controller.reverse();
                                  _isplay = false;
                                }
                                if (kDebugMode) {
                                  print(_isplay);
                                }
                              });

                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Text(
                                  _isplay ? "Pause" : "Execute", // Change text based on _isplay
                                  style: const TextStyle(
                                    color: white,
                                    fontSize: bodylarge,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                                AnimatedIcon(
                                    icon: AnimatedIcons.play_pause,
                                  progress: _controller,
                                  size: 24,
                                  color: white,
                                    )

                              ],
                            )),
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
