import 'package:flutter/material.dart';
import 'package:test/presentation/widgets/success_alert.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({
    super.key,
    required this.amount,
    required this.isCartScreen,
  });
  final double amount;
  final bool isCartScreen;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        backgroundColor: Colors.orange.shade600,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------- ADDRESS CARD ----------------
            _buildTitle("Delivery Address"),
            _addressCard(),

            const SizedBox(height: 20),

            // ---------------- ORDER SUMMARY ----------------
            _buildTitle("Order Summary"),
            _orderSummaryCard(amount),

            const SizedBox(height: 20),

            // ---------------- PAYMENT SECTION ----------------
            _buildTitle("Payment"),
            _paymentCard(),

            const SizedBox(height: 30),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewPadding.bottom + 40,
        ),
        child: _checkoutButton(context),
      ),
    );
  }

  // --------------------- TITLE ---------------------
  Widget _buildTitle(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );

  // ------------------- ADDRESS CARD -------------------
  Widget _addressCard() {
    return Card(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.location_on, color: Colors.orange, size: 28),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "Rashin K\n"
                "House No. 123, Kaloor\n"
                "Kochi, Kerala - 682017\n"
                "Phone: +91 9876543210",
                style: const TextStyle(fontSize: 14, height: 1.4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------ ORDER SUMMARY -------------------
  Widget _orderSummaryCard(double amount) {
    return Card(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            PriceRow("Items Total", "₹${amount.toStringAsFixed(2)}"),
            PriceRow("Delivery Fee", "₹40"),
            PriceRow("Discount", "-₹100"),
            Divider(),
            PriceRow("Total Amount", "₹${amount - 60}", isBold: true),
          ],
        ),
      ),
    );
  }

  // ------------------ PAYMENT CARD ---------------------
  Widget _paymentCard() {
    return Card(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            ListTile(
              leading: Icon(Icons.credit_card, color: Colors.blue),
              title: Text("Credit / Debit Card"),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_balance_wallet, color: Colors.green),
              title: Text("UPI / Wallet"),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.money, color: Colors.brown),
              title: Text("Cash on Delivery"),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- BOTTOM BUTTON ----------------
  Widget _checkoutButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () async {
          showSuccessAlert(context, isCartScreen);
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.orange.shade600,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          "Place Order",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// ---------------- PRICE ROW WIDGET ----------------
class PriceRow extends StatelessWidget {
  final String title;
  final String amount;
  final bool isBold;

  const PriceRow(this.title, this.amount, {super.key, this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 15,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
