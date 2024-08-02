// lib/screens/home_content.dart

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool isScanning = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gym Attendance')),
      body: Column(
        children: <Widget>[
          if (!isScanning) ...[
            Expanded(
              child: Center(
                child: GestureDetector(
                  onTap: () => _showScanner(context),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.qr_code_scanner,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
              ),
            ),
          ] else ...[
            Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: (result != null)
                    ? Text('Barcode Type: ${result!.format}   Data: ${result!.code}')
                    : Text('Scan a code'),
              ),
            )
          ],
        ],
      ),
    );
  }

  void _showScanner(BuildContext context) {
    setState(() {
      isScanning = true;
    });
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      if (result?.code != null) {
        _markAttendance(result!.code!);
        setState(() {
          isScanning = false;
        });
      }
    });
  }


  void _markAttendance(String qrData) async {
    final CollectionReference gymAttendance = FirebaseFirestore.instance.collection('gymattendance');

    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User not logged in')));
        return;
      }

      final uid = user.uid;
      // Fetch the username from Firestore
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final username = userDoc.data()?['username'] ?? 'unknown_user';

      final gymName = qrData;
      final now = DateTime.now();
      final dateStr = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
      final timeStr = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';

      await gymAttendance
          .doc(gymName)
          .collection('dates')
          .doc(dateStr)
          .collection('attendance')
          .add({
        'username': username,
        'date': dateStr,
        'time': timeStr,
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Attendance marked for $gymName on $dateStr')));
    } catch (e) {
      print('Error marking attendance: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to mark attendance: $e')));
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
