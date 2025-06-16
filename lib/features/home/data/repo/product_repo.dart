import '../model/product_model.dart';

abstract class ProductRepo {
  Future<List<ProductModel>> getProductsByCategory(String categorySlug);
}