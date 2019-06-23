import 'package:flutter/material.dart';

class MyTheme {
  MaterialColor _renk;
  ThemeData _tema;

  MaterialColor get renk => _renk;

  set renk(MaterialColor value) {
    _renk = value;
  }

  ThemeData get tema => _tema;

  set tema(ThemeData value) {
    _tema = value;
  }

  MyTheme(this._renk, this._tema);
}
