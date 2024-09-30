import 'package:flutter/material.dart';
import 'package:fluttercart/models/product.dart';
import 'package:fluttercart/views/widgets/product_card_cart.dart';

class CartPage extends StatefulWidget {
  final List<Product> cartItems;

  const CartPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<Product> _cartItems;
  late Map<String, int> _quantityMap;

  @override
  void initState() {
    super.initState();
    _cartItems = widget.cartItems;
    _calculateQuantities();
  }

  void _calculateQuantities() {
    _quantityMap = {};
    for (var item in _cartItems) {
      _quantityMap[item.title] = (_quantityMap[item.title] ?? 0) + 1;
    }
  }

  void _removeItemFromCart(String title) {
    setState(() {
      _cartItems.removeWhere((item) => item.title == title);
      _calculateQuantities();
    });
  }

  double _calculateTotalPrice() {
    return _cartItems.fold(0.0, (sum, item) => sum + item.price);
  }

  @override
  Widget build(BuildContext context) {
    // Crear una lista única de productos
    final uniqueProducts = _quantityMap.keys.map((title) {
      final item = _cartItems.firstWhere((product) => product.title == title);
      return ProductCardCart(
        title: item.title,
        thumbnailUrl: item.image,
        price: item.price,
        quantity: _quantityMap[title] ?? 0,
        onRemove: () => _removeItemFromCart(title),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: uniqueProducts.isEmpty
                ? const Center(
                    child: Text(
                      'Your cart is empty!',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  )
                : ListView(children: uniqueProducts),
          ),
          // Sección inferior con el precio total y botón de compra
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Texto del precio total
                Text(
                  "Total: \$${_calculateTotalPrice().toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                // Botón de compra
                ElevatedButton(
                  onPressed: () => _verifyTotalPrice(context),
                  child: const Text(
                    'Comprar',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _verifyTotalPrice(BuildContext context) {
    double displayedTotal = _calculateTotalPrice();
    double actualTotal = _calculateTotalPrice();

    if (displayedTotal == actualTotal) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("¡El precio coincide! Compra realizada con éxito."),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("El precio no coincide. Por favor, revisa tu carrito."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
