import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/product_model.dart';
import '../../data/repo/product_repo.dart';

part 'product_by_category_state.dart';

class ProductByCategoryCubit extends Cubit<ProductByCategoryState> {
  final ProductRepo productRepo;
  ProductByCategoryCubit(this.productRepo) : super(ProductByCategoryInitial());

  Future<void> loadProductsByCategory(String categorySlug) async {
    emit(ProductByCategoryLoading());
    try {
      final products = await productRepo.getProductsByCategory(categorySlug);
      emit(ProductByCategorySuccess(products));
    } catch (e) {
      emit(ProductByCategoryFailure(e.toString()));
    }
  }
}
