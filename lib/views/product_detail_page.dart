import 'package:flutter/material.dart';
import 'package:fluttercart/models/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen del producto
              Center(
                child: Image.network(
                  product.image,
                  height: 250,
                ),
              ),
              const SizedBox(height: 16.0),
              // Título del producto
              Text(
                product.title,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 27, 27, 27)),
              ),
              const SizedBox(height: 8.0),
              // Categoría del producto
              Text(
                'Category: ${product.category}',
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 8.0),
              // Precio del producto
              Text(
                '\$${product.price.toString()}',
                style: const TextStyle(
                    fontSize: 22,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              // Descripción del producto
              Text(
                product.description,
                style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 3, 17, 4),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              // Rating del producto
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow),
                  const SizedBox(width: 4.0),
                  Text(
                    product.rating.toString(),
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
