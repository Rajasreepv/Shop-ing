import 'package:flutter/material.dart';

class CouponsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coupons'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            CouponCard(
              couponCode: 'WINTER25',
              discount: '25%',
              description: 'WINTER Sale! Get 25% off on all items.',
            ),
            SizedBox(height: 20),
            CouponCard(
              couponCode: 'FREESHIP',
              discount: 'Free Shipping',
              description: 'Enjoy free shipping on your next purchase.',
            ),
            // Add more CouponCards as needed
          ],
        ),
      ),
    );
  }
}

class CouponCard extends StatelessWidget {
  final String couponCode;
  final String discount;
  final String description;

  const CouponCard({
    required this.couponCode,
    required this.discount,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Coupon Code: $couponCode',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Discount: $discount',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Description: $description',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
