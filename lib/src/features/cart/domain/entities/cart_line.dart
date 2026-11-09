class CartLine {
  final String productId;
  final String name;
  final int unitPriceMmk;
  final String imageUrl;
  final int quantity;

  const CartLine({
    required this.productId,
    required this.name,
    required this.unitPriceMmk,
    required this.imageUrl,
    required this.quantity,
  });

  int get totalMmk => unitPriceMmk * quantity;

  CartLine withQuantity(int value) => CartLine(
    productId: productId,
    name: name,
    unitPriceMmk: unitPriceMmk,
    imageUrl: imageUrl,
    quantity: value,
  );
}
