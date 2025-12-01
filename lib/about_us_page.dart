import 'package:flutter/material.dart';
import 'package:union_shop/widgets/main_header.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MainHeader(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 12),
              Text(
                'About Us',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                'Welcome to the Union Shop!\n\nWe are dedicated to giving you the very best University branded products, with a range of clothing and merchandise available to shop all year round! We even offer an exclusive personalisation service!\n\nAll online purchases are available for delivery or instore collection!\n\nWe hope you enjoy our products as much as we enjoy offering them to you.\n\nHappy shopping! The Union Shop & Reception Team​​​​​​​​​',
                style: TextStyle(fontSize: 16, height: 1.4),
              )
            ],
          ),
        ),
      ),
    );
  }
}
