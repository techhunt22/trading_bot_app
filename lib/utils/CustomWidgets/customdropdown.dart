import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../Constants/color_constants.dart';
import '../../constants/font_size.dart';

class CustomDropdown extends StatelessWidget {
  final String? title;
  final String hintText;
  final List<Map<String, dynamic>> items; // Update based on your item structure
  final String? selectedValue;
  final ValueChanged<String?> onChanged;
  final bool? titleon;

  const CustomDropdown({
    super.key,
    required this.hintText,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
     this.title,
     this.titleon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align title to the left
      children: [
        titleon == true
            ? Text(
                title!,
                style: const TextStyle(
                    fontSize: titlesmall,
                    fontWeight: FontWeight.w400,
                    color: white),
              )
            : const SizedBox.shrink(),
        const SizedBox(
          height: 10,
        ),

        DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            barrierDismissible: true,
            iconStyleData: const IconStyleData(
              icon: Padding(
                padding: EdgeInsets.only(right: 15),
                child: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: white, // Use your defined color
                ),
              ),
              openMenuIcon: Padding(
                padding: EdgeInsets.only(right: 15),
                child: Icon(
                  Icons.keyboard_arrow_up_outlined,
                  color: white, // Use your defined color
                ),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 60,
            ),
            buttonStyleData: ButtonStyleData(
                decoration: BoxDecoration(
                    color: background,
                    borderRadius: BorderRadiusDirectional.circular(10))),
            hint: Text(
              hintText,
              style: const TextStyle(
                fontSize: bodymedium,
                fontWeight: FontWeight.w400,
                color: white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item['value'],
                child: Row(
                  children: [
                    if (item['icon'] != null) ...[
                      Image.asset(
                        item['icon'],
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      item['value'],
                      style: const TextStyle(
                        fontSize: bodymedium,
                        fontWeight: FontWeight.w400,
                        color: white,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            value: selectedValue,
            onChanged: onChanged,
            dropdownStyleData: DropdownStyleData(
              maxHeight: 300,
              decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(10),
              ),
              offset: const Offset(0, -15), // Moves the dropdown 5px down
            ),
          ),
        ),
      ],
    );
  }
}
