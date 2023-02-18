class PaymentIntentEntity {
  String? amount;
  String? currency;

//<editor-fold desc="Data Methods">

  PaymentIntentEntity({
    this.amount,
    this.currency,
  });

  Map<String, dynamic> toMap() {
    return {
      'amount': calculateAmount(amount!),
      'currency': currency,
    };
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }
}
