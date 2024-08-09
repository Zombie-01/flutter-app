import 'package:get/get.dart';
import 'package:timberr/dummyData.dart';
import 'package:timberr/models/card_detail.dart';

class CardDetailsController extends GetxController {
  var cardDetailList = <CardDetail>[].obs;
  var selectedIndex = 0.obs;
  String token;

  CardDetailsController({required this.token});

  String getLastFourDigits() {
    if (cardDetailList.isNotEmpty) {
      return cardDetailList
          .elementAt(selectedIndex.value)
          .cardNumber
          .toString()
          .substring(12);
    }
    return "XXXX";
  }

  Future<void> fetchCardDetails() async {
    // Fetch Card Details from dummy data
    cardDetailList.addAll(dummyCardDetails);
  }

  Future<void> getDefaultCardDetail() async {
    // Get default card detail
    int responseId = 1;
    await fetchCardDetails();
    for (int i = 0; i < cardDetailList.length; i++) {
      if (cardDetailList.elementAt(i).id == responseId) {
        selectedIndex.value = i;
        break;
      }
    }
  }

  void setDefaultCardDetail(int index) {
    if (selectedIndex.value == index) {
      return;
    }
    selectedIndex.value = index;
  }
}
