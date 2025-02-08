import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'verification_page.dart'; // Import your VerificationPage

class PhoneVerificationView extends GetView {
  const PhoneVerificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments as Map<String, dynamic>;
    final String emailOrPhone = args['emailOrPhone'] as String;
    final String role = args['role'] as String;

    return VerificationPage(
      emailOrPhone: emailOrPhone,
      role: role,
    );
  }
}
