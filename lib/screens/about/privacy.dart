import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../materials/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: sendory,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    FontAwesomeIcons.chevronLeft,
                    color: primary,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1.5,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                        inset: true,
                      ),
                    ],
                    color: primary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                  height: height * 0.05,
                  width: width * 0.8,
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'About Us',
                      style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 1.5,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                          inset: true,
                        ),
                      ],
                      color: primary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(60),
                      ),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 25, left: 25, right: 10),
                      child: ListView(children: [
                        Text(
                          privacy,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        )
                      ]),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const privacy = '''Privacy Policy for MeloMix Android App

Effective Date: [16/05/2023]

This Privacy Policy outlines the practices and procedures followed by MeloMix, an offline music player app (referred to as "MeloMix," "we," "us," or "our") regarding the collection, use, and disclosure of personal information when you use the MeloMix mobile application (the "App"). By downloading, installing, and using the App, you agree to the terms and conditions of this Privacy Policy.

1. Information We Collect:

1.1. Personal Information:
We may collect certain personal information from you when you use the App. This includes:

a) Device Information: We may collect information about the device you use to access the App, such as the device model, operating system version, unique device identifiers, and mobile network information.

b) Storage Access: MeloMix requires permission to read and write storage in order to access and play music files stored on your device.

c) Microphone Access: MeloMix requires microphone access to enable music identification and song searching features. This access is used solely for the purpose of identifying and matching audio signatures and is not stored or transmitted.

1.2. Non-Personal Information:
In addition to personal information, we may also collect non-personal information that does not directly identify you. This may include aggregated usage data, analytics information, and technical information about your device and interactions with the App. Such information is used to analyze trends, improve the App, and enhance user experience.

2. Use of Information:

2.1. Personal Information:
We may use the personal information collected from you for the following purposes:

a) To provide and improve the App's functionality and features.

b) To personalize your experience with the App and recommend songs or features based on your preferences.

c) To fulfill your specific requests and respond to your inquiries or feedback.

d) To detect and prevent fraudulent or unauthorized activities.

2.2. Non-Personal Information:
Non-personal information may be used for statistical analysis, research, and to improve the App's performance, functionality, and content.

3. Data Sharing and Disclosure:

3.1. Service Providers:
We may engage third-party service providers who assist us in providing and improving the App. These service providers may have access to your personal information only to perform tasks on our behalf and are obligated to maintain the confidentiality and security of your information.

3.2. Legal Requirements:
We may disclose your personal information if required by law or if we believe that such disclosure is necessary to comply with legal obligations, protect our rights or the rights of others, investigate fraud, or respond to a government request.

3.3. Business Transfers:
In the event of a merger, acquisition, or sale of all or a portion of our assets, your personal information may be transferred or disclosed to the acquiring entity or parties involved.

4. Data Security:

We take reasonable measures to protect the security of your personal information. However, no data transmission or storage method is completely secure. Therefore, while we strive to protect your personal information, we cannot guarantee its absolute security.

5. Children's Privacy:

The App is not intended for use by individuals under the age of 13. We do not knowingly collect personal information from children under 13. If we become aware that we have collected personal information from a child under 13 without parental consent, we will take steps to remove such information from our systems.

6. Changes to this Privacy Policy:

We reserve the right to update or modify this Privacy Policy at any time. Any changes will be effective upon posting the revised policy on this page. We encourage you to review this Privacy Policy periodically for any updates.

7. Contact Us:

If you have any questions, concerns, or requests
regarding this Privacy Policy or our privacy practices, please contact us at [Insert Contact Information].

By using the MeloMix App, you acknowledge that you have read and understood this Privacy Policy and agree to the collection, use, and disclosure of your information as described herein.''';
