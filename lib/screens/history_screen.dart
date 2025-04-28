import 'package:flutter/material.dart';
import '../models/scan_data.dart';
import '../services/local_storage_service.dart';
import 'scan_result_screen.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<ScanData> scans = [];
  List<ScanData> filteredScans = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadScans();
    searchController.addListener(() {
      filterScans();
    });
  }

  void loadScans() async {
    final data = await LocalStorageService.instance.getAllScans();
    setState(() {
      scans = data;
      filteredScans = data;
      isLoading = false;
    });
  }

  void filterScans() {
    final query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      setState(() {
        filteredScans = scans;
      });
    } else {
      setState(() {
        filteredScans = scans.where((scan) {
          return scan.payeeName.toLowerCase().contains(query) ||
              scan.upiId.toLowerCase().contains(query);
        }).toList();
      });
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Widget _buildScanItem(ScanData scan) {
    return ListTile(
      title: Text(scan.payeeName),
      subtitle: Text(scan.upiId),
      trailing: Text(
        scan.scanDate.toLocal().toString().split('.')[0],
        style: TextStyle(fontSize: 12, color: Colors.grey),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScanResultScreen(
              rawData: _buildUpiString(scan),
            ),
          ),
        );
      },
    );
  }

  String _buildUpiString(ScanData scan) {
    final params = [
      'pa=${scan.upiId}',
      'pn=${scan.payeeName}',
      if (scan.merchantCode.isNotEmpty) 'mc=${scan.merchantCode}',
      if (scan.transactionId.isNotEmpty) 'tid=${scan.transactionId}',
      if (scan.transactionRefId.isNotEmpty) 'tr=${scan.transactionRefId}',
      if (scan.transactionNote.isNotEmpty) 'tn=${scan.transactionNote}',
      if (scan.amount.isNotEmpty) 'am=${scan.amount}',
    ];
    return 'upi://pay?' + params.join('&');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan History'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Search by name or UPI ID',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: filteredScans.isEmpty
                      ? Center(child: Text('No scans found'))
                      : ListView.builder(
                          itemCount: filteredScans.length,
                          itemBuilder: (context, index) {
                            return _buildScanItem(filteredScans[index]);
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
