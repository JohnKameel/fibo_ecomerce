part of 'product_by_category_cubit.dart';

@immutable
sealed class ProductByCategoryState {}

final class ProductByCategoryInitial extends ProductByCategoryState {}
final class ProductByCategoryLoading extends ProductByCategoryState {}
final class ProductByCategorySuccess extends ProductByCategoryState {
  final List<ProductModel> products;

  ProductByCategorySuccess(this.products);
}
final class ProductByCategoryFailure extends ProductByCategoryState {
  final String errorMessage;

  ProductByCategoryFailure(this.errorMessage);
}
