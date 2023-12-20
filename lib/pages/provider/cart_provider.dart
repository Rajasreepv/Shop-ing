import 'package:flutter/material.dart';
import 'package:weatherapp/pages/modals/cartModel.dart';

class CartProvider extends ChangeNotifier {
  List<cartmodel> _cartItems = [];

  List<cartmodel> get cartItems => _cartItems;
  void clearCart() {
    _cartItems.clear();
    getCartCount();
    notifyListeners(); // Notify listeners of the change
  }

  void addToCart(cartmodel newItem) {
    _cartItems.add(newItem);
    getCartCount();
    notifyListeners(); // Notify listeners of the change
  }
  // List<cartmodel> get cartItems => _cartItems;
  // getcartcount() {
  //   return _cartItems.length;
  //   notifyListeners();
  // }

  double calculateProductPrice() {
    double productPrice = 0;
    for (var item in _cartItems) {
      productPrice += item.itemprice * item.quantity;
    }
    return productPrice;
  }

  double calculateFinalPrice() {
    double productPrice = calculateProductPrice();
    if (productPrice == 0) {
      double totalPrice = 0;
      return totalPrice;
    }
    double totalPrice =
        productPrice - 10 + 5; // Adjustments (discount and shipping)
    return totalPrice;
  }

  void increaseQuantity(int index) {
    _cartItems[index].quantity++;
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (_cartItems[index].quantity > 0) {
      _cartItems[index].quantity--;
      notifyListeners();
    }
  }
  void getCartCount() {
    notifyListeners(); // Notify listeners to update the count
  }
}
