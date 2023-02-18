import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payment/stripe/data/models/payment_intent.dart';
import 'package:stripe_payment/stripe/domain/urls.dart';

class PaymentFeatures extends ChangeNotifier {
  Map<String, dynamic>? stripeIntent = {};

  Future<void> makePayment({required BuildContext context}) async {
    stripeIntent = await postPaymentIntent(amount: '100', currency: 'USD');
    try {
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  style: ThemeMode.light,
                  merchantDisplayName: 'Ikay',
                  paymentIntentClientSecret: stripeIntent?['client_secret']))
          .then((value) => displayPaymentSheet(context));
    } catch (e) {
      print('.............Error.......${e.toString()}');
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  postPaymentIntent({required String amount, required String currency}) async {
    var url = ApiUrls.paymentIntent;
    PaymentIntentEntity paymentIntentEntity =
        PaymentIntentEntity(amount: amount, currency: currency);

    var jsonBody = paymentIntentEntity.toMap();
    print('response://///......jsonBody...........${jsonBody}');
    try {
      http.Response response = await http.post(Uri.parse(url),
          body: jsonBody, headers: ApiUrls.header);
      print('response://///.................${response.statusCode}');
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } on HttpException {
      if (kDebugMode) {
        print('Http Error');
      }
    } catch (e) {
      print('catch error: ${e.toString()}');
    }
    notifyListeners();
  }

  displayPaymentSheet(BuildContext context) async {
    try {
      print('............Helloe Bab...........');
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 100.0,
                      ),
                      SizedBox(height: 10.0),
                      Text("Payment Successful!"),
                    ],
                  ),
                ));

        stripeIntent = null;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      print('$e');
    }
  }
}
