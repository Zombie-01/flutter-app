import 'package:get/get.dart';
import 'package:timberr/controllers/card_details_controller.dart';
import 'package:timberr/models/card_detail.dart';
import 'package:timberr/dummyData.dart';

class AddPaymentController extends GetxController {
  int cardNumber = 0, cvv = 0, month = 0, year = 0;
  var name = "".obs;
  var dateString = "".obs;
  var lastFourDigits = "".obs;

  final CardDetailsController _cardDetailsController = Get.find();

  void addCardDetail() {
    int newId = dummyCardDetails.isEmpty ? 1 : dummyCardDetails.last.id + 1;
    String formattedCardNumber = cardNumber.toString().padLeft(16, '0');
    String expiryDate = "$month/$year";

    CardDetail newCard = CardDetail(
      newId,
      name.value,
      formattedCardNumber,
      expiryDate,
      cvv.toString().padLeft(3, '0'),
    );

    dummyCardDetails.add(newCard);

    if (_cardDetailsController.cardDetailList.isEmpty) {
      _cardDetailsController.selectedIndex.value = 0;
    }

    _cardDetailsController.cardDetailList.add(newCard);
    Get.back();
  }
}
