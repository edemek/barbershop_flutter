import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';

class MyHomeScreen extends StatelessWidget {
  const MyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final dark = THelperFunctions.isDarkMode(context);
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Edem KOFFI',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: TColors.black),
                    ),
                    const SizedBox(width: 10),
                    Image.asset(
                      'assets/icons/hand.png',
                      height: 40,
                      width: 40,
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 27,
                  backgroundImage: NetworkImage(
                      'assets/images/on_boarding_images/onboard.jpg'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
