import 'package:flutter/material.dart';
import 'package:sidebar_animation/pages/games.dart';
import '../pages/social.dart';
import '../pages/gurus.dart';
import '../pages/home.dart';
import '../pages/library.dart';


class NavbarTabSelectedModel extends ChangeNotifier {

  int _currentTab = 0;

  List <Widget> _pages = [

    HomePage(),
    Library(),
    // Gurus(),
    Social(),
    Games()
  ];


  set currentTab(int tab) { this._currentTab = tab; notifyListeners();}
  get currentTab => this._currentTab;
  get currentScreen => this._pages[this._currentTab];
}