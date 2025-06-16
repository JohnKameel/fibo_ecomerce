import 'package:fido_e/features/home/data/model/product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'products_model.g.dart';
@JsonSerializable()
class ProductsModel {
  List<ProductModel> products;
  int total;
  int skip;
  int limit;

  ProductsModel({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => _$ProductsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsModelToJson(this);
}