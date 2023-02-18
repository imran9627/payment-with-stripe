import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/stripe/domain/repositories/payment_features.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PaymentFeatures _paymentFeatures;

  @override
  void initState() {
    super.initState();
    _paymentFeatures = Provider.of<PaymentFeatures>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stripe Payment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: const Text('Make Payment'),
              onPressed: () async {
                await _paymentFeatures.makePayment(context: context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
