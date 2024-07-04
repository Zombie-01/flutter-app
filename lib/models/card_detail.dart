class CardDetail {
  final int id;
  final String cardHolderName;
  final String cardNumber;
  final String expiryDate;
  final String cvv;

  CardDetail(
    this.id,
    this.cardHolderName,
    this.cardNumber,
    this.expiryDate,
    this.cvv,
  );

  get name => null;

  get month => null;

  get year => null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cardholder_name': cardHolderName,
      'card_number': cardNumber,
      'expiry_date': expiryDate,
      'cvv': cvv,
    };
  }
}
