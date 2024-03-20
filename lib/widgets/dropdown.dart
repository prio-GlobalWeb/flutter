import "package:dropdown_button2/dropdown_button2.dart";
import "package:flutter/material.dart";
import 'package:prio_web/services/providers/provider.dart';
import "package:prio_web/widgets/main-txt.dart";
import "package:provider/provider.dart";

Widget locationDrop(
    BuildContext context,
    ){
  return Consumer<StateProvider>(
    builder: (context, stateProvider, _){
      final List<String> locations = ['Lab', 'Office', 'Storage'];
      return DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text(
            'Location (All)',
            style: TextStyle(
              fontFamily: 'shsR',
              fontSize: 15,
            ),
          ),
          items: locations
              .map((String item) => DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: textStyle(),
            ),
          )).toList(),
          value: Provider.of<StateProvider>(context, listen: false).selectedValue,
          onChanged: (String? value) {
            Provider.of<StateProvider>(context, listen: false).selectValue(value!);
          },
          buttonStyleData: ButtonStyleData(
            padding: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Color(0xffaab1b7),
                width: 1,
              ),
              color: Colors.white,
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 50,
          ),
        ),
      );
    },
  );
}

Widget statusDrop(
    BuildContext context,
    ){
  return Consumer<StateProvider>(
    builder: (context, stateProvider, _){
      final List<String> status = ['Good', 'Normal','Bad'];
      return DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text(
            'Status (All)',
            style: TextStyle(
              fontFamily: 'shsR',
              fontSize: 15,
            ),
          ),
          items: status
              .map((String item) => DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: textStyle(),
            ),
          )).toList(),
          value: Provider.of<StateProvider>(context, listen: false).selectedValue2,
          onChanged: (String? value) {
            Provider.of<StateProvider>(context, listen: false).selectValue2(value!);
          },
          buttonStyleData: ButtonStyleData(
            padding: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Color(0xffaab1b7),
                width: 1,
              ),
              color: Colors.white,
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 50,
          ),
        ),
      );
    },
  );
}