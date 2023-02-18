import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiUrls {
  static const paymentIntent = 'https://api.stripe.com/v1/payment_intents';
  static Map<String, String> header = {
    'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
}
