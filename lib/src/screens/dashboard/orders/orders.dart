import 'package:flutter/material.dart';
import 'package:tradingapp_bot/constants/color_constants.dart';

import '../../../../constants/font_size.dart';
import '../../../../constants/padding.dart';
import '../../../../utils/CustomWidgets/appbar.dart';
import '../../dashboard_screen.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {


  List<List<String>> data = [
    ['USDT', '0.02212515113212131313131313', '0.02 USD'],
    ['LINK', '0.0049944', '0.01 USD'],
    ['WIN', '5214521', '4.28 USD'],
    ['BONK', '3500', '0.06'],
    ['DOGS', '0.59', '0 USD'],
  ];
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
                name: "Orders",
                icon: "assets/icons/order.svg",
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: globalPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Market",
                        style: TextStyle(
                            fontSize: headlinesmall,
                            fontWeight: FontWeight.w600),
                      ),

                      buildTable(),
                      buildTable2(),
                      // Scrollable Data

                      const SizedBox(
                        height: 50,
                      ),

                      const Center(
                        child: Text(
                          "Earned Funding Fee",
                          style: TextStyle(
                              fontSize: headlinesmall,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      Center(
                        child: Container(
                          height: 60,
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
                            onPressed: () {},
                            child: const Text(
                              "Check",
                              style: TextStyle(color: white),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 50,
                      ),

                      const Text(
                        "Active / Pending Orders",
                        style: TextStyle(
                            fontSize: headlinesmall,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                    ],
                  ),
                ),
              ),
            ],
          )),
    );

  }



  Table buildTable2() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1), // Width of the first column
        1: FlexColumnWidth(2), // Width of the second column
        2: FlexColumnWidth(1), // Width of the third column
      },
      border:  TableBorder(
        horizontalInside: BorderSide(
          color: purple.withValues(alpha: 0.2),
        ),
        verticalInside: BorderSide.none,
        top: BorderSide.none,
        bottom:  BorderSide(
          color: purple.withValues(alpha:0.2),
        ),
        left: BorderSide.none,
        right: BorderSide.none,
      ),
      children: data.map((row) {
        return TableRow(
          children: row.map((cell) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
              child: Text(cell,style: const TextStyle(
                  fontWeight: FontWeight.w500, color: white, fontSize: bodymedium),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  Table buildTable() {
    return Table(

      columnWidths: const {
        0: FlexColumnWidth(1), // Width of the first column
        1: FlexColumnWidth(2), // Width of the second column
        2: FlexColumnWidth(1), // Width of the third column
      },
      border:  TableBorder(
        horizontalInside: BorderSide.none,
        verticalInside: BorderSide.none,
        top: BorderSide.none,
        bottom:  BorderSide(
          color: purple.withValues(alpha:0.2),
        ),
        left: BorderSide.none,
        right: BorderSide.none,
      ),
      children: [
        TableRow(
          children: [
            _buildHeaderCell('Coin'),
            _buildHeaderCell('Balance'),
            _buildHeaderCell('In Usd'),
          ],
        ),
      ],
    );
  }
}

Widget _buildHeaderCell(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
    child: Text(
      text,
      style: const TextStyle(
          fontWeight: FontWeight.w500, color: white, fontSize: titlemedium),
    ),
  );
}
