import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:clipboard/clipboard.dart';
import 'package:share_plus/share_plus.dart';

class GenerateQRScreen extends StatefulWidget {
  @override
  _GenerateQRScreenState createState() => _GenerateQRScreenState();
}

class _GenerateQRScreenState extends State<GenerateQRScreen> {
  final TextEditingController _upiIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  String? _qrData;

  void _generateQR() {
    final upiId = _upiIdController.text.trim();
    final name = _nameController.text.trim();
    final amount = _amountController.text.trim();

    if (upiId.isEmpty || name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both UPI ID and Name')),
      );
      return;
    }

    String data = 'upi://pay?pa=$upiId&pn=$name&tn=Payment';
    if (amount.isNotEmpty) {
      data += '&am=$amount';
    }

    setState(() {
      _qrData = data;
    });
  }

  void _copyToClipboard() {
    if (_qrData != null) {
      FlutterClipboard.copy(_qrData!).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Copied to clipboard')),
        );
      });
    }
  }

  void _shareQR() {
    if (_qrData != null) {
      Share.share(_qrData!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate QR'),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _upiIdController,
                decoration: InputDecoration(labelText: 'UPI ID'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Amount (optional)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _generateQR,
                child: Text('Generate QR Code'),
              ),
              SizedBox(height: 24),
              if (_qrData != null)
                Column(
                  children: [
                    QrImageView(
  data: _qrData!,
  size: 200,
  backgroundColor: Colors.white,
),

                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          icon: Icon(Icons.copy),
                          label: Text('Copy'),
                          onPressed: _copyToClipboard,
                        ),
                        SizedBox(width: 16),
                        ElevatedButton.icon(
                          icon: Icon(Icons.share),
                          label: Text('Share'),
                          onPressed: _shareQR,
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
