import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy policy'),
      ),
      body: const SafeArea(
          child: Expanded(
              child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
            "Information we collect:\nPersonal Information: When you create an account on our platform, we collect your name, email address, shipping address, and payment information.Usage Information: We may collect information about your use of our platform, including the pages you visit, the products you view, and the searches you conduct.Device Information: We may collect information abou the device you are using to access our platform, such as your IP address, browser type, and operating system.\nHow we use your information:\nPersonal Information: We use your personal information to process your orders and to communicate with you about your purchases. We may also use your information to send you marketing communications about our products and services.Usage Information: We use usage information to improve our platform and to personalize your experience on our platform.Device Information: We use device information to prevent fraud and to ensure that our platform is functioning properly.\nHow we protect your information:\nWe take the security of your information seriously and have implemented industry-standard security measures to protect your information from unauthorized access, disclosure, or destruction. We regularly review our security measures to ensure that they are up-to-date and effective.\nThird-Party Services:\nWe may use third-party services, such as payment processors and shipping providers, to fulfill your orders. These third-party services have their own privacy policies, and we encourage you to review them before using their services.\nChanges to our Privacy Policy:\nWe may update our privacy policy from time to time to reflect changes in our platform or our practices. We will notify you of any material changes to our privacy policy by email or by posting a notice on our platform.\nIf you have any questions or concerns about our privacy policy, please don't hesitate to contact us."),
      ))),
    );
  }
}
