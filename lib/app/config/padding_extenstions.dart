import 'package:flutter/material.dart';

extension PaddingExtension on Widget {
  // Padding from all sides
  Widget paddingFromAll(double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }

  // Padding only horizontally
  Widget paddingHorizontal(double padding) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: this,
    );
  }

  // Padding only vertically
  Widget paddingVertical(double padding) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: this,
    );
  }

  // Padding on the right
  Widget paddingRight(double padding) {
    return Padding(
      padding: EdgeInsets.only(right: padding),
      child: this,
    );
  }

  // Padding on the left
  Widget paddingLeft(double padding) {
    return Padding(
      padding: EdgeInsets.only(left: padding),
      child: this,
    );
  }

  // Padding on the top
  Widget paddingTop(double padding) {
    return Padding(
      padding: EdgeInsets.only(top: padding),
      child: this,
    );
  }

  // Padding on the bottom
  Widget paddingBottom(double padding) {
    return Padding(
      padding: EdgeInsets.only(bottom: padding),
      child: this,
    );
  }

  // Symmetric padding for horizontal and vertical
  Widget paddingSymmetrics({required double horizontal, required double vertical}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  // Symmetric padding for top and bottom
  Widget paddingTopBottom(double padding) {
    return Padding(
      padding: EdgeInsets.only(top: padding, bottom: padding),
      child: this,
    );
  }

  // Symmetric padding for left and right
  Widget paddingLeftRight(double padding) {
    return Padding(
      padding: EdgeInsets.only(left: padding, right: padding),
      child: this,
    );
  }
}


extension emptySpace on num
{

  SizedBox get height => SizedBox(height:toDouble());

  SizedBox get width => SizedBox(width:toDouble());

}