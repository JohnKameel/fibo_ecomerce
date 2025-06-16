import '../../../../core/network/api_consumer.dart';
import 'category_repo.dart';

class CategoryRepoImpl implements CategoryRepo {
  ApiConsumer apiConsumer;
  CategoryRepoImpl(this.apiConsumer);

  @override
  Future<List<String>> getCategories() async {
    final response = await apiConsumer.get('https://dummyjson.com/products/category-list');
    return List<String>.from(response);
  }
}