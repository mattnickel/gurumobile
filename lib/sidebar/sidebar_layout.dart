import 'package:flutter/material.dart';

import './sidebar_two.dart';
import '../pages/home.dart';

class SideBarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            HomePage(),
            SideBarSimple(),
          ],
        ),
    );
  }
}
