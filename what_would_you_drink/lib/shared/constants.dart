import 'package:flutter/material.dart';
import 'package:what_would_you_drink/displayData/data_colors.dart' as dc;

var textInputDecoration = InputDecoration(
  fillColor : dc.colorBg,
  filled: true,
  enabledBorder: const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide.none
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(
      color: dc.colorPrimary!,
      width: 2
    ),
  ),
);

Container textForm({required String text}){
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10.0),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold
      ),
    ),
  );
}