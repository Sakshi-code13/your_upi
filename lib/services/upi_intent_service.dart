import 'package:url_launcher/url_launcher.dart';

class UpiIntentService {
  static Future<void> launchUpiPayment(String upiId) async {
    final uri = Uri.parse('upi://pay?pa=$upiId&pn=&tn=Payment');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch UPI app';
    }
  }
}
