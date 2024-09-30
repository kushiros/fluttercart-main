import 'package:flutter/material.dart';
import 'package:fluttercart/models/product.api.dart';
import 'package:fluttercart/models/product.dart';
import 'package:fluttercart/views/cart_page.dart';
import 'package:fluttercart/views/widgets/products_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late List<Product> _products;
  List<Product> _cart = []; // Lista para almacenar los productos seleccionados
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  Future<void> getProducts() async {
    _products = await ProductApi.getProduct();
    setState(() {
      _isLoading = false;
    });
  }

  // Método para agregar un producto al carrito
  void addToCart(Product product) {
    setState(() {
      _cart.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.restaurant_menu),
            const SizedBox(width: 10),
            const Text('Description'),
            const Spacer(), // Empuja el carrito hacia la derecha
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(cartItems: _cart),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                return ProductsCard(
                  product: _products[index],
                  addToCart: addToCart, // Pasar la función de agregar al carrito
                );
              },
            ),
    );
  }
}
