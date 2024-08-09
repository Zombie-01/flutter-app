import 'package:get/get.dart';
import 'package:timberr/constants.dart';
import 'package:timberr/dummyData.dart';
import 'package:timberr/models/address.dart';

class AddressController extends GetxController {
  List<Address> addressList = [];
  int selectedIndex = 0;

  String name = "", address = "", country = "", city = "", district = "";
  int pincode = 0;

  String token;

  AddressController({required this.token});

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
    getDefaultShippingAddress();
  }

  Future<void> fetchAddresses() async {
    // Get address list from dummy data
    addressList = List.from(dummyAddresses);
    update();
  }

  Future<void> getDefaultShippingAddress() async {
    int? responseId = 1;
    for (int i = 0; i < addressList.length; i++) {
      if (addressList[i].id == responseId) {
        selectedIndex = i;
        update();
        break;
      }
    }
  }

  Future<void> setDefaultShippingAddress(int index) async {
    if (selectedIndex == index) {
      return;
    }
    selectedIndex = index;
    update();
    // Update the default shipping address in dummy data (if needed)
  }

  Future<void> uploadAddress() async {
    int newId = addressList.isEmpty ? 1 : addressList.last.id + 1;
    Address newAddress = Address(
      id: newId,
      name: name,
      address: address,
      pincode: pincode,
      country: country,
      city: city,
      district: district,
    );
    if (addressList.isEmpty) {
      selectedIndex = 0;
    }
    // Add to shipping address list
    addressList.add(newAddress);
    update();
    Get.back();
  }

  Future<void> editAddress(int index, int addressId) async {
    Address newAddress = Address(
      id: addressId,
      name: name,
      address: address,
      pincode: pincode,
      country: country,
      city: city,
      district: district,
    );
    // Update the value locally
    addressList[index] = newAddress;
    update();
    Get.back();
  }

  Future<void> deleteAddress(int index) async {
    // Check if it is the selected index
    if (index == selectedIndex) {
      if (addressList.length == 1) {
        await kDefaultDialog(
            "Error", "Add a different address before removing this one");
        return;
      } else {
        selectedIndex = 0;
        await setDefaultShippingAddress((index == 0) ? 1 : 0);
      }
    }
    // Remove from local list
    addressList.removeAt(index);
    update();
    Get.back();
  }
}
