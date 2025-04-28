import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:share_plus/share_plus.dart';
import '../models/scan_data.dart';
import '../services/local_storage_service.dart';
import '../services/upi_intent_service.dart';

class ScanResultScreen extends StatefulWidget {
  final String rawData;

  const ScanResultScreen({Key? key, required this.rawData}) : super(key: key);

  @override
  _ScanResultScreenState createState() => _ScanResultScreenState();
}

class _ScanResultScreenState extends State<ScanResultScreen> {
  late ScanData scanData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    parseAndSave();
  }

  void parseAndSave() async {
    scanData = ScanData.fromUpiString(widget.rawData);
    await LocalStorageService.instance.insertScan(scanData);
    setState(() {
      isLoading = false;
    });
  }

  void copyToClipboard(String text) {
    FlutterClipboard.copy(text).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Copied to clipboard')),
      );
    });
  }

  void shareText(String text) {
    Share.share(text);
  }

  void proceedToPay() {
    UpiIntentService.launchUpiPayment(scanData.upiId);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Scan Result')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Result'),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Payee Name:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text(scanData.payeeName),
            SizedBox(height: 16),
            Text('UPI ID:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text(scanData.upiId),
            SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.copy),
                  label: Text('Copy UPI ID'),
                  onPressed: () => copyToClipboard(scanData.upiId),
                ),
                SizedBox(width: 16),
                ElevatedButton.icon(
                  icon: Icon(Icons.share),
                  label: Text('Share'),
                  onPressed: () => shareText(widget.rawData),
                ),
              ],
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: proceedToPay,
                child: Text('Proceed to Pay'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
