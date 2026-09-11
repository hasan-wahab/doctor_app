import 'package:doctor_app/widgets/app_app_bar.dart';
import 'package:flutter/material.dart';

class VisitDetails2 extends StatelessWidget {
  const VisitDetails2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(
        title: 'Visit History',
        showBack: true,
      ),
      body: ListView(children: []),
    );
  }
}
