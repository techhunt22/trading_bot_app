import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tradingapp_bot/constants/color_constants.dart';
import 'package:tradingapp_bot/src/screens/dashboard_screen.dart';
import '../../../../Constants/font_size.dart';
import '../../../../utils/CustomWidgets/appbar.dart';
import 'components/step1.dart';
import 'components/step2.dart';
import 'components/step3.dart';
import 'components/step4.dart';
import 'components/step5.dart';



class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();

}


class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  List<String> text = [
    "Global Settings",
    "Market-Neutral Strategy",
    "DCA Strategy",
    "Dip Strategy",
    "Spike Strategy"
  ];

  List<bool> vertical = [
    false,
    false,
    false,
    false,
    true,
  ];

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void nextContent() {
    setState(() {
      if (currentIndex < 4) {
        currentIndex++;
        // Reset scroll position to the top
        _scrollController.jumpTo(0);
      }
    });
  }

  void previousContent() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
        // Reset scroll position to the top
        _scrollController.jumpTo(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<bool> indexCheck = [
      currentIndex == 0,
      currentIndex == 0 || currentIndex == 1,
      currentIndex == 0 || currentIndex == 1 || currentIndex == 2,
      currentIndex == 0 ||
          currentIndex == 1 ||
          currentIndex == 2 ||
          currentIndex == 3,
      currentIndex == 0 ||
          currentIndex == 1 ||
          currentIndex == 2 ||
          currentIndex == 3 ||
          currentIndex == 4,
    ];
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
          controller: _scrollController, // Attach the scroll controller

          slivers: [
            const CustomSliverAppBar(
              name: "Main",
              icon: "assets/icons/main.svg",
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 30),
                    child: buildRichText(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  buildSingleChildScrollView(indexCheck),
                  const SizedBox(
                    height: 20,
                  ),
                  buildIndexedStack(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  RichText buildRichText() {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: "Step ${currentIndex + 1}",
          style: const TextStyle(color: white, fontSize: headlinelarge)),
      const TextSpan(
          text: "/5",
          style: TextStyle(
            color: white,
            fontSize: bodylarge,
          )),
    ]));
  }

  Widget buildSingleChildScrollView(List<bool> indexCheck) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 15),
        padding: const EdgeInsets.only(left: 15, right: 15),
        height: 60,
        decoration: const BoxDecoration(
            color: darkbackground,
            borderRadius: BorderRadiusDirectional.all(Radius.circular(30))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ...List.generate(5, (index) {
                // Using buildRow to construct each item
                return buildRow(
                  img: indexCheck[index]
                      ? const SizedBox.shrink()
                      : SvgPicture.asset("assets/icons/check.svg"),
                  isVertical: vertical[index],
                  text: text[index],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }


  Widget buildIndexedStack() {
    switch (currentIndex) {
      case 0:
        return ContentWidget1(onNext: nextContent, onPrevious: previousContent);
      case 1:
        return ContentWidget2(onNext: nextContent, onPrevious: previousContent);
      case 2:
        return ContentWidget3(onNext: nextContent, onPrevious: previousContent);
      case 3:
        return ContentWidget4(onNext: nextContent, onPrevious: previousContent);
      case 4:
        return ContentWidget5(onNext: nextContent, onPrevious: previousContent);
      default:
        return const SizedBox.shrink();
    }
  }

  // Widget buildIndexedStack() {
  //   return Column(
  //     children: [
  //       Offstage(
  //         offstage: currentIndex == 0 ? false : true,
  //         child:
  //             ContentWidget1(onNext: nextContent, onPrevious: previousContent),
  //       ),
  //       Offstage(
  //         offstage: currentIndex == 1 ? false : true,
  //         child:
  //             ContentWidget2(onNext: nextContent, onPrevious: previousContent),
  //       ),
  //       Offstage(
  //         offstage: currentIndex == 2 ? false : true,
  //         child:
  //             ContentWidget3(onNext: nextContent, onPrevious: previousContent),
  //       ),
  //       Offstage(
  //         offstage: currentIndex == 3 ? false : true,
  //         child:
  //             ContentWidget4(onNext: nextContent, onPrevious: previousContent),
  //       ),
  //       Offstage(
  //         offstage: currentIndex == 4 ? false : true,
  //         child:
  //             ContentWidget5(onNext: nextContent, onPrevious: previousContent),
  //       ),
  //
  //       // ContentWidget1(onNext: nextContent, onPrevious: previousContent),
  //       // ContentWidget2(onNext: nextContent, onPrevious: previousContent),
  //       // ContentWidget3(onNext: nextContent, onPrevious: previousContent),
  //       // ContentWidget4(onNext: nextContent, onPrevious: previousContent),
  //       // ContentWidget5(onNext: nextContent, onPrevious: previousContent),
  //     ],
  //   );
  // }

  Widget buildRow(
      {required dynamic img, required String text, required bool isVertical}) {
    return Row(
      children: [
        img,
        const SizedBox(
          width: 10,
        ),
        Text(text),
        const SizedBox(
          width: 10,
        ),
        isVertical
            ? const SizedBox.shrink()
            : VerticalDivider(
                color: purple.withOpacity(0.6),
                thickness: 2,
                endIndent: 10,
                indent: 10,
              ),
      ],
    );
  }
}
