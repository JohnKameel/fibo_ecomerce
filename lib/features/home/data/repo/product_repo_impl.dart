import 'package:fido_e/features/home/data/model/product_model.dart';
import 'package:fido_e/features/home/data/repo/product_repo.dart';

import '../../../../core/network/api_consumer.dart';

class ProductRepoImpl implements ProductRepo {
  ApiConsumer apiConsumer;
  ProductRepoImpl(this.apiConsumer);
  @override
  Future<List<ProductModel>> getProductsByCategory(String categorySlug) async {
    final result = await apiConsumer.get('https://dummyjson.com/products/category/$categorySlug');
    final productsJson = result['products'] as List;

    return productsJson
        .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}