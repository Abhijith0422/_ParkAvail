<<<<<<< HEAD
// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../application/bloc/parkdata_bloc.dart';
import '../../domain/api/apiendpoints.dart';
import 'receipt_screen.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

final ValueNotifier<bool> paymentSuccessNotifier = ValueNotifier<bool>(false);
final ValueNotifier<double> _sliderValueNotifier = ValueNotifier<double>(0);
final TextEditingController _durationtextController = TextEditingController();
final TextEditingController _vehicletextController = TextEditingController();
final ValueNotifier<bool> _filledNotifier = ValueNotifier<bool>(false);

class BookingPage extends StatefulWidget {
=======
// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:book_my_park/application/bloc/parkdata_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upi_india/upi_india.dart';

final ValueNotifier<bool> paymentSuccessNotifier = ValueNotifier<bool>(false);
final ValueNotifier<UpiApp?> selectedAppNotifier = ValueNotifier<UpiApp?>(null);

class BookingPage extends StatelessWidget {
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c
  final int index;
  final String districtName;
  const BookingPage({
    super.key,
    required this.index,
    required this.districtName,
  });

  @override
<<<<<<< HEAD
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    paymentSuccessNotifier.value = true;
    final state = context.read<ParkdataBloc>().state;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (context) => ReceiptScreen(
              index: widget.index,
              parkingName: state.parkdata[widget.index].name!,
              vehicleNumber: _vehicletextController.text,
              duration: _sliderValueNotifier.value.round(),
              amount:
                  state.parkdata[widget.index].price! *
                      _sliderValueNotifier.value +
                  10,
              transactionId: response.paymentId ?? 'Unknown',
              location: state.parkdata[widget.index].location!,
            ),
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment Failed: ${response.message}'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('External Wallet Selected: ${response.walletName}'),
      ),
    );
  }

  void openCheckout(double amount) {
    var options = {
      'key': razorpay, // Replace with your actual Razorpay key
      'amount': (amount).toInt(), // Amount in smallest currency unit
      'name': 'ParkAvail',
      'description': 'Parking Booking',
      'prefill': {
        'contact': '9188810679', // Optional: Pre-fill user's phone
        'email': 'abhijith0422@gmail.com', // Optional: Pre-fill user's email
      },
      'external': {
        'wallets': ['paytm'], // Optional: Enable specific wallets
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          'Complete Booking',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<ParkdataBloc, ParkdataState>(
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBookingSummaryCard(state, context),
                  const SizedBox(height: 24),
                  _buildVehicleDetailsCard(context),
                  const SizedBox(height: 24),
                  _buildPaymentSummaryCard(state, context),
                  const SizedBox(height: 32),
                  _buildPaymentButton(context, state),
                ],
              ),
            ),
=======
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ParkdataBloc>(context)
          .add(ParkdataEvent.getdata(districtName));
    });
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'ParkAvail',
            style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: BlocBuilder<ParkdataBloc, ParkdataState>(
        builder: (context, state) {
          return Column(
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Review Booking",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey),
                        color: Colors.transparent),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "${state.parkdata[index].image}"),
                                    fit: BoxFit.fill)),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
                            child: Column(
                              children: [
                                AutoSizeText(
                                  "${state.parkdata[index].name}",
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 3,
                                  minFontSize: 16,
                                ),
                                const SizedBox(height: 10),
                                Text("Price: ${state.parkdata[index].price}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    )),
                                const SizedBox(height: 10),
                                const Text("Duration: 1 hour",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    )),
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Amount Payable",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey),
                      color: Colors.transparent),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Text("Amount : ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Text("${state.parkdata[index].price}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Text("Convenience Fee : ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Text(" 10",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Text("Total : ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Text("${state.parkdata[index].price! + 10}",
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      ValueListenableBuilder<UpiApp?>(
                        valueListenable: selectedAppNotifier,
                        builder: (context, selectedApp, child) {
                          if (selectedApp != null) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.memory(
                                    selectedApp.icon,
                                    width: 24,
                                    height: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    selectedApp.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Container(
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                        color: Colors.green),
                    child: TextButton(
                        onPressed: () async {
                          // Fetch the list of UPI apps before showing the dialog
                          List<UpiApp> apps = await UpiIndia().getAllUpiApps();

                          UpiApp? selectedApp = await showDialog<UpiApp>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Select UPI App'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: apps.map((UpiApp app) {
                                      return ListTile(
                                        leading: Image.memory(
                                          app.icon,
                                          width: 24,
                                          height: 24,
                                        ),
                                        title: Text(app.name),
                                        onTap: () {
                                          Navigator.pop(context, app);
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            },
                          );

                          if (selectedApp != null) {
                            bool transactionSuccess = await initiateUpiPayment(
                                selectedApp,
                                state.parkdata[index].price!.toDouble() + 10);
                            if (transactionSuccess) {
                              paymentSuccessNotifier.value = true;
                            }
                            if (context.mounted) {
                              selectedAppNotifier.value = selectedApp;
                            }
                          }
                        },
                        child: const Text(
                          "Proceed to Payment",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ))),
              )
            ],
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c
          );
        },
      ),
      backgroundColor: const Color.fromARGB(255, 23, 31, 43),
    );
  }
<<<<<<< HEAD

  Widget _buildBookingSummaryCard(ParkdataState state, BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: const Color.fromARGB(255, 32, 41, 56),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              "${state.parkdata[widget.index].image}",
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) => Image.asset(
                    "assets/noimage.jpg",
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${state.parkdata[widget.index].name}",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.money, color: Colors.green, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      "₹${state.parkdata[widget.index].price}/hour",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleDetailsCard(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: const Color.fromARGB(255, 32, 41, 56),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.directions_car,
                  color: Colors.white.withOpacity(0.7),
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  "Vehicle Details",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF1A1A1A), // Darker charcoal
                    Color(0xFF2D2D2D), // Lighter charcoal
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF3D3D3D), // Medium gray
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.1),
                    blurRadius: 12,
                    spreadRadius: -2,
                  ),
                  BoxShadow(
                    color: const Color(0xFF121212).withOpacity(0.5),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Vehicle Number",
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 55,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF1A1A1A), // Darker charcoal
                                Color(0xFF2D2D2D), // Lighter charcoal
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFF3D3D3D), // Medium gray
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.withOpacity(0.1),
                                blurRadius: 12,
                                spreadRadius: -2,
                              ),
                              BoxShadow(
                                color: const Color(0xFF121212).withOpacity(0.5),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: Colors.white.withOpacity(0.1),
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "KL",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _vehicletextController,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 2,
                                  ),
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    fillColor: Colors.transparent,
                                    hintText: "28 AB 4258",
                                    hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.3),
                                      fontSize: 18,
                                      letterSpacing: 2,
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    counter:
                                        const SizedBox(), // Hides character counter
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9A-Z ]'),
                                    ),
                                    UpperCaseTextFormatter(),
                                    LengthLimitingTextInputFormatter(10),
                                    TextInputFormatter.withFunction((
                                      oldValue,
                                      newValue,
                                    ) {
                                      final text = newValue.text;
                                      if (text.isEmpty) return newValue;

                                      // Format: KL 28 AB 4258 or KL 28 A 4678
                                      String formatted = text.replaceAll(
                                        ' ',
                                        '',
                                      ); // Remove existing spaces

                                      if (formatted.length <= 2) {
                                        // First 2 digits
                                        return TextEditingValue(
                                          text: formatted,
                                          selection: TextSelection.collapsed(
                                            offset: formatted.length,
                                          ),
                                        );
                                      }

                                      if (formatted.length <= 3) {
                                        // Add space after first 2 digits
                                        formatted =
                                            '${formatted.substring(0, 2)} ${formatted.substring(2)}';
                                      } else if (formatted.length <= 4) {
                                        // Format: "28 A" or "28 AB"
                                        formatted =
                                            '${formatted.substring(0, 2)} ${formatted.substring(2)}';
                                      } else {
                                        // Format full number
                                        final bool isSingleLetter =
                                            formatted.length <=
                                            7; // KL 28 A 4678
                                        if (isSingleLetter) {
                                          formatted =
                                              '${formatted.substring(0, 2)} ${formatted.substring(2, 3)} ${formatted.substring(3)}';
                                        } else {
                                          formatted =
                                              '${formatted.substring(0, 2)} ${formatted.substring(2, 4)} ${formatted.substring(4)}';
                                        }
                                      }

                                      return TextEditingValue(
                                        text: formatted.toUpperCase(),
                                        selection: TextSelection.collapsed(
                                          offset: formatted.length,
                                        ),
                                      );
                                    }),
                                  ],
                                  onChanged: (value) {
                                    // Validate the format
                                    final cleanValue = value.replaceAll(
                                      ' ',
                                      '',
                                    );
                                    final bool isValid = RegExp(
                                      r'^[0-9]{2}[A-Z]{1,2}[0-9]{4}$',
                                    ).hasMatch(cleanValue);
                                    _filledNotifier.value = isValid;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: Colors.white10),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Duration",
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Container(
                              width: 90,
                              height: 55,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF1A1A1A), // Darker charcoal
                                    Color(0xFF2D2D2D), // Lighter charcoal
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFF3D3D3D), // Medium gray
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.green.withOpacity(0.1),
                                    blurRadius: 12,
                                    spreadRadius: -2,
                                  ),
                                  BoxShadow(
                                    color: const Color(
                                      0xFF121212,
                                    ).withOpacity(0.5),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: _durationtextController,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  fillColor: Colors.transparent,
                                  hintText: "0",
                                  hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.3),
                                    fontSize: 18,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  suffixText: "hrs",
                                  suffixStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 14,
                                  ),
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(2),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ValueListenableBuilder<double>(
                                valueListenable: _sliderValueNotifier,
                                builder: (context, value, child) {
                                  return Column(
                                    children: [
                                      SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                          activeTrackColor: Colors.green,
                                          inactiveTrackColor: Colors.white
                                              .withOpacity(0.2),
                                          thumbColor: Colors.white,
                                          overlayColor: Colors.green
                                              .withOpacity(0.2),
                                        ),
                                        child: Slider(
                                          value: value,
                                          min: 0,
                                          max: 24,
                                          divisions: 24,
                                          label: "${value.round()} hrs",
                                          onChanged: (double newValue) {
                                            _sliderValueNotifier.value =
                                                newValue;
                                            _durationtextController.text =
                                                newValue.round().toString();
                                          },
                                        ),
                                      ),
                                      Text(
                                        "Max 24 hours",
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentSummaryCard(ParkdataState state, BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: const Color.fromARGB(255, 32, 41, 56),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ValueListenableBuilder(
          valueListenable: _sliderValueNotifier,
          builder: (context, value, _) {
            final double baseAmount =
                state.parkdata[widget.index].price! * value;
            final double convenienceFee = 10;
            final double total = baseAmount + convenienceFee;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Payment Summary",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                _buildPriceRow("Base Amount", "₹$baseAmount"),
                _buildPriceRow("Convenience Fee", "₹$convenienceFee"),
                const Divider(color: Colors.white24, height: 32),
                _buildPriceRow("Total Amount", "₹$total", isTotal: true),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isTotal ? Colors.white : Colors.white70,
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              color: isTotal ? Colors.green : Colors.white,
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentButton(BuildContext context, ParkdataState state) {
    return ValueListenableBuilder<bool>(
      valueListenable: _filledNotifier,
      builder: (context, isValid, _) {
        return ValueListenableBuilder(
          valueListenable: _sliderValueNotifier,
          builder: (context, sliderValue, _) {
            final double baseAmount =
                state.parkdata[widget.index].price! * sliderValue;
            final double convenienceFee = 10;
            final double total = baseAmount + convenienceFee;

            return SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: isValid ? () => openCheckout(total) : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isValid ? Colors.green : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: isValid ? 8 : 0,
                ),
                child: Text(
                  "Proceed to Payment",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
=======
}

Future<bool> initiateUpiPayment(UpiApp selectedApp, double amount) async {
  UpiIndia upiIndia = UpiIndia();
  String transactionRef = DateTime.now().millisecondsSinceEpoch.toString();

  UpiResponse response = await upiIndia.startTransaction(
    app: selectedApp,
    receiverUpiId: '9188810679@apl', // Replace with actual UPI ID
    receiverName: 'ParkAvail',
    transactionRefId: transactionRef,
    transactionNote: 'Payment for parking slot',
    amount: amount,
  );

  switch (response.status) {
    case UpiPaymentStatus.SUCCESS:
      print('Transaction successful');
      return true;

    case UpiPaymentStatus.SUBMITTED:
      print('Transaction submitted');
      return false;

    case UpiPaymentStatus.FAILURE:
      print('Transaction failed');
      return false;

    default:
      print('Unknown status: ${response.status}');
      return false;
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c
  }
}
