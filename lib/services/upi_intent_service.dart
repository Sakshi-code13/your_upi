import 'package:url_launcher/url_launcher_string.dart';

class UpiIntentService {
  static Future<void> launchUpiPayment(String upiId) async {
    final uri = 'upi://pay?pa=$upiId&pn=&tn=Payment';
    if (await canLaunchUrlString(uri)) {
      await launchUrlString(uri);
    } else {
      throw 'Could not launch UPI app';
    }
  }
}
