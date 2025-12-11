class CustomException implements Exception {
  final String message;

  CustomException(this.message);

  @override
  String toString() => message;
}

enum CustomExceptionType {
  productAlreadyOnOrder(message: "Product already on order.", errorCode: 1),
  sandwichAlreadyOnOrder(
    message: "Only one sandwich can be added on order.",
    errorCode: 2,
  ),
  readFromFile(message: "Failed to read from file.", errorCode: 3),
  writeToFile(message: "Failed to write to file.", errorCode: 3);

  const CustomExceptionType({required this.message, required this.errorCode});

  final String message;
  final int errorCode;
}
