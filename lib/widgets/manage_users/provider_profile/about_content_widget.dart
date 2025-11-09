
import 'package:b2b_partnership_admin/core/theme/app_color.dart';
import 'package:b2b_partnership_admin/core/theme/text_style.dart';
import 'package:flutter/material.dart';

Widget titleWidget(String title) {
  return Text(
    title,
    style: getRegularStyle.copyWith(
      color: Colors.black54,
    ),
  );
}

Widget valueWidget(String value) {
  return Text(
    value,
    style: getRegularStyle.copyWith(
      color: blackColor,
      fontWeight: FontWeight.w500,
    ),
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
  );
}
