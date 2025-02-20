import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:flutter/services.dart';

import '../../application/bloc/parkdata_bloc.dart';
import '../mainpage.dart';
import 'gmap.dart';

class ReceiptScreen extends StatelessWidget {
  final String parkingName;
  final String vehicleNumber;
  final int duration;
  final double amount;
  final String transactionId;
  final String location;
  final int index;

  const ReceiptScreen({
    super.key,
    required this.parkingName,
    required this.vehicleNumber,
    required this.duration,
    required this.amount,
    required this.transactionId,
    required this.location,
    required this.index,
  });

  Future<void> _printReceipt(BuildContext context) async {
    try {
      final doc = pw.Document();

      // Load and process the logo
      final ByteData logoData = await rootBundle.load('assets/logo1.png');
      final Uint8List logoBytes = logoData.buffer.asUint8List();
      final logoImage = pw.MemoryImage(logoBytes);

      // Add custom font
      final font = await PdfGoogleFonts.nunitoRegular();
      final boldFont = await PdfGoogleFonts.nunitoBold();

      doc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Padding(
              padding: const pw.EdgeInsets.all(20),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Add logo at the top
                  pw.Center(
                    child: pw.Image(logoImage, width: 120, height: 120),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Center(
                    child: pw.Text(
                      'ParkAvail Receipt',
                      style: pw.TextStyle(font: boldFont, fontSize: 24),
                    ),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Divider(),
                  pw.SizedBox(height: 20),
                  _buildPdfRow('Transaction ID', transactionId, font),
                  _buildPdfRow('Parking', parkingName, font),
                  _buildPdfRow('Vehicle Number', vehicleNumber, font),
                  _buildPdfRow('Duration', '$duration hours', font),
                  _buildPdfRow('Amount Paid', '₹$amount', font),
                  _buildPdfRow('Location', location, font),
                  pw.SizedBox(height: 20),
                  pw.Divider(),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    'Thank you for using ParkAvail',
                    style: pw.TextStyle(
                      font: font,
                      fontSize: 12,
                      color: PdfColors.grey700,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );

      await Printing.layoutPdf(
        onLayout: (format) async => doc.save(),
        name: 'ParkAvail_Receipt_$transactionId',
      );
    } catch (e) {
      debugPrint('Error generating PDF: $e');
      // Show error message to user
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to generate receipt. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  pw.Widget _buildPdfRow(String label, String value, pw.Font font) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 120,
            child: pw.Text(
              label,
              style: pw.TextStyle(font: font, color: PdfColors.grey700),
            ),
          ),
          pw.SizedBox(width: 16),
          pw.Expanded(
            child: pw.Text(
              value,
              style: pw.TextStyle(font: font, color: PdfColors.black),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParkdataBloc, ParkdataState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 23, 31, 43),
          appBar: AppBar(
            title: Text(
              'Booking Receipt',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Card(
                    color: const Color.fromARGB(255, 32, 41, 56),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 64,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Payment Successful',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          _buildReceiptDetail('Transaction ID', transactionId),
                          _buildReceiptDetail('Parking', parkingName),
                          _buildReceiptDetail('Vehicle Number', vehicleNumber),
                          _buildReceiptDetail('Duration', '$duration hours'),
                          _buildReceiptDetail('Amount Paid', '₹$amount'),
                          _buildReceiptDetail('Location', location),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _printReceipt(context),
                          icon: const Icon(Icons.print),
                          label: const Text('Print Receipt'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed:
                              () => launchGoogleMaps(
                                state.parkdata[index].latitude!,
                                state.parkdata[index].longitude!,
                              ),
                          icon: const Icon(Icons.directions),
                          label: const Text('Get Directions'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => MainPage()),
                        );
                      },
                      icon: const Icon(Icons.home),
                      label: const Text('Back to Home'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildReceiptDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120, // Fixed width for labels
            child: Text(
              label,
              style: GoogleFonts.poppins(color: Colors.white70, fontSize: 16),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
