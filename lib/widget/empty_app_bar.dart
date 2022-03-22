
import 'package:flutter/material.dart';

import '../res/color.dart';

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.themeColor,
    );
  }

  @override
  Size get preferredSize => Size(0.0, 0.0);
}
