import 'package:flutter/material.dart';

// 土曜・日曜の文字色設定
Color textColor(DateTime day) {
  const defaultTextColor = Colors.black87;
  //日曜は赤色
  if (day.weekday == 7) {
    return Colors.red;
  }
  //土曜は青色
  if (day.weekday == 6) {
    return Colors.blue;
  }
  return defaultTextColor;
}

// カレンダーの背景色
Color setBackgroundColor() {
  return const Color.fromARGB(255, 235, 235, 235);
}
