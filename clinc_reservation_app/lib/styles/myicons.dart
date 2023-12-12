import '/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'images_path.dart';

class MyIcons {
  static Widget arrowBack({color = Colors.grey, double size = 22}) {
    return SvgPicture.asset(
      arrow_back_white_svg,
      color: color,
      height: size,
    );
  }

  static Widget menuButton({color = primaryblue, double size = 22}) {
    return SvgPicture.asset(
      menulogoblue_svg,
      color: color,
      height: size,
    );
  }
}
