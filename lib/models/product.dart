class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating});
    

  factory Product.fromJson(dynamic json){
    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      price: json['price'].toDouble(),
      description: json['description'] as String,
      category: json['category'] as String,
      image: json['image'] as String,
      rating: json['rating']['rate'].toDouble()
    );
  }

  static List<Product> productsFromSnapshot(List snapshot){
    return snapshot.map((data) => Product.fromJson(data)).toList();
  }//asdasdasd

   @override
  String toString() {
    return 'Product{id: $id, title: $title, price: $price, description: $description, category: $category, image: $image, rating: $rating}';
  }
}
