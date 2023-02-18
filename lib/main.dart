import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/stripe/domain/repositories/payment_features.dart';
import 'package:stripe_payment/stripe/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey =
      "pk_test_51K7ZjILod0hVfNfqdjHk9KjJoogYukHQV4jOGOf1pPNZaFNDWmyhJbPX2nwfY8iKPjUwMVnurnl4S1vc1SoCBjed00bO7tsr1W";

  await dotenv.load(fileName: "assets/.env");
  print('Hello after load ${dotenv.get('STRIPE_SECRET')}');
  //var secret_key = dotenv.get('STRIPE_SECRET');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PaymentFeatures>(
      create: (context) {
        return PaymentFeatures();
      },
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
