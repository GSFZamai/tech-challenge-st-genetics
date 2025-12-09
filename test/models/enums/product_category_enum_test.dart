import 'package:flutter_test/flutter_test.dart';
import 'package:good_hamburger/models/enums/product_category_enum.dart';

void main() {
  group("ProductCategoryEnum", () {
    test("If enum has 2 categories", () {
      expect(ProductCategoryEnum.values.length, 2);
    });

    test("If enum sandwich category", () {
      expect(ProductCategoryEnum.sandwich, isNotNull);
    });

    test("If enum extra category", () {
      expect(ProductCategoryEnum.extras, isNotNull);
    });
  });
}
