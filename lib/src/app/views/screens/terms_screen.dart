import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  static const String routeName = '/terms';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final large = TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: theme.colorScheme.primary,
    );

    const medium = TextStyle(fontSize: 18.0);

    const small = TextStyle(
      fontSize: 12.0,
      fontStyle: FontStyle.italic,
    );

    final divider = Divider(
      indent: 36.0,
      endIndent: 36.0,
      color: theme.colorScheme.primary,
      thickness: 0.5,
      height: 24.0,
    );

    const contactEmail = 'yahyasaadi1998@gmail.com';
    const appName = 'Key Keeper';

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16.0,
              children: [
                Text(
                  'Terms and Conditions for $appName',
                  style: large.copyWith(fontSize: 32.0),
                ),
                Text(
                  'Effective Date: ${Jiffy.parseFromDateTime(DateTime.now()).yMMMEd}',
                  style: small,
                ),
                const Text(
                  'Welcome to $appName. By using the App, you agree to the following Terms and Conditions. Please read them carefully before using the App.',
                  style: medium,
                ),
                divider,
                Text(
                  '1. Use of the App',
                  style: large,
                ),
                const Text(
                  '- The App is designed to store passwords, secure notes, and other sensitive data in an encrypted format.\n\n- You are responsible for maintaining the confidentiality of your master password and other credentials used to access the App.\n\n- The App\'s password generator is provided for your convenience. We cannot guarantee the absolute security of any generated passwords if shared or used improperly.',
                  style: medium,
                ),
                divider,
                Text(
                  '2. Data Security',
                  style: large,
                ),
                const Text(
                  '- All stored data is encrypted end-to-end and can only be accessed with your master password. We do not have access to your master password or decrypted data.\n\n- While we strive to provide a secure environment, no system is completely immune to breaches. By using the App, you acknowledge this risk.',
                  style: medium,
                ),
                divider,
                Text(
                  '3. User Responsibilities',
                  style: large,
                ),
                const Text(
                  '- You agree not to misuse the App for illegal activities or to store prohibited content.\n\n- It is your responsibility to back up your master password. Losing your master password will result in permanent loss of access to your data, as we cannot retrieve it.',
                  style: medium,
                ),
                divider,
                Text(
                  '4. Limitations of Liability',
                  style: large,
                ),
                const Text(
                  '- The App is provided "as is" without warranties of any kind.\n\n- $appName is not responsible for any data loss, unauthorized access, or other damages arising from your use of the App.',
                  style: medium,
                ),
                divider,
                Text(
                  '5. Updates and Changes',
                  style: large,
                ),
                const Text(
                  '- We reserve the right to update these Terms and Conditions at any time. Changes will be effective immediately upon posting.',
                  style: medium,
                ),
                divider,
                const Text(
                  '- If you have questions or concerns about these Terms and Conditions, please contact us at [$contactEmail].',
                  style: small,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
