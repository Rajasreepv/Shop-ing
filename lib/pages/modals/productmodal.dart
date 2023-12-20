class product {
  final String image;
  final String name;
  final double price;

  final String? Description;
  product(
      {required this.name,
      required this.image,
      required this.price,
      this.Description});
}
