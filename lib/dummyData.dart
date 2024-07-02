import 'package:timberr/models/address.dart';
import 'package:timberr/models/card_detail.dart';
import 'package:timberr/models/cart_item.dart';
import 'package:timberr/models/product.dart';
import 'package:timberr/models/user_data.dart';

List<Product> dummyProducts = [
  Product(
    1,
    "Smartphone",
    799,
    "A high-end smartphone with advanced features.",
    1,
    ["black", "white", "blue"],
    [
      "https://example.com/images/smartphone_1.jpg",
      "https://example.com/images/smartphone_2.jpg",
      "https://example.com/images/smartphone_3.jpg",
    ],
  ),
  Product(
    2,
    "Laptop",
    1299,
    "A powerful laptop for professional use.",
    2,
    ["silver", "black"],
    [
      "https://example.com/images/laptop_1.jpg",
      "https://example.com/images/laptop_2.jpg",
      "https://example.com/images/laptop_3.jpg",
    ],
  ),
  Product(
    3,
    "Headphones",
    199,
    "Noise-cancelling headphones with great sound quality.",
    3,
    ["black", "blue", "red"],
    [
      "https://example.com/images/headphones_1.jpg",
      "https://example.com/images/headphones_2.jpg",
      "https://example.com/images/headphones_3.jpg",
    ],
  ),
];

List<CartItem> dummyCartItems = [
  CartItem(
    1,
    2,
    'black', // colorString
    {
      'product_id': 1,
      'name': 'Smartphone',
      'price': 799,
      'description': 'A high-end smartphone with advanced features.',
      'categoryId': 1,
      'colorsList': ['black', 'white', 'blue'],
      'imagesList': [
        'https://example.com/images/smartphone_1.jpg',
        'https://example.com/images/smartphone_2.jpg',
        'https://example.com/images/smartphone_3.jpg',
      ],
    },
  ),
  CartItem(
    2,
    1,
    'silver', // colorString
    {
      'product_id': 2,
      'name': 'Laptop',
      'price': 1299,
      'description': 'A powerful laptop for professional use.',
      'categoryId': 2,
      'colorsList': ['silver', 'black'],
      'imagesList': [
        'https://example.com/images/laptop_1.jpg',
        'https://example.com/images/laptop_2.jpg',
        'https://example.com/images/laptop_3.jpg',
      ],
    },
  ),
];

List<Address> dummyAddresses = [
  Address(
    id: 1,
    name: "John Doe",
    address: "123 Main St",
    pincode: 12345,
    country: "United States",
    city: "Anytown",
    district: "Sometown",
  ),
  Address(
    id: 2,
    name: "TERGEL",
    address: "1234 Main St",
    pincode: 12,
    country: "Mongolia",
    city: "Anytown",
    district: "Sometown",
  )
];

List<CardDetail> dummyCardDetails = [
  CardDetail(
      id: 1,
      name: 'Munkhtergel',
      cardNumber: 1234567890123456,
      month: 11,
      year: 2023),
  CardDetail(
      id: 2,
      name: 'Alice Smith',
      cardNumber: 1234567890123456,
      month: 11,
      year: 2023)
];

List<UserData> dummyUserData = [
  UserData(
    name: 'John Doe',
    email: 'johndoe@example.com',
    profilePictureUrl: 'https://example.com/profile.jpg',
    salesNotification: true,
    deliveryStatusNotification: false,
    newArrivalsNotification: true,
  )
];
