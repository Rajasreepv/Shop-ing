import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class payment extends StatefulWidget {
  final double totalPrice;
  const payment({
    super.key,
    required this.totalPrice,
  });

  @override
  State<payment> createState() => _paymentState();
}

class _paymentState extends State<payment> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Payment Done");
    Navigator.pop(context, true);
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Failure");
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Failure");
    // Do something when an external wallet is selected
  }

  Razorpay _razorpay = Razorpay();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 90.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Amount to Pay "), Text(widget.totalPrice.toString(),style:TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 15,
            ),
            CupertinoButton(
              child: Text("Pay Amount"),
              onPressed: () {
                var options = {
                  'key': 'rzp_test_lZiqaGhex0B561',
                  'amount': (widget.totalPrice * 100).toString(),
                  'name': 'Shop-ing',

                  'timeout': 300, // in seconds
                  'prefill': {
                    'contact': '998877665',
                    'email': 'support@shopping.com'
                  }
                };
                _razorpay.open(options);
              },
              color: Colors.green,
            ),SizedBox(
              height: 10,
            ),Text("COD NOT AVAILABLE"),
            // ElevatedButton(onPressed: () {}, child: Text("Pay Amount"))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear(); // Removes all listeners
  }
}
