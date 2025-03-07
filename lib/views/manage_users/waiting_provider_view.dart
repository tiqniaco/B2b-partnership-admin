import 'package:b2b_partnership_admin/core/theme/app_color.dart';
import 'package:b2b_partnership_admin/widgets/manage_users/waiting_provider_widget.dart';
import 'package:flutter/material.dart';

class WaitingProviderView extends StatelessWidget {
  const WaitingProviderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: whiteColor, title: Text("Waiting providers")),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: WaitingProviderWidget(),
      ),
    );
  }
}
