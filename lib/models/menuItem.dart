import 'package:flutter/material.dart';

class menuItem{
  final String title;
  final Icon icon;
  final bool selected;
  final Function onTap;
  final int index;
  const menuItem(this.index, {Key key, this.title, this.icon, this.selected, this.onTap});
}
