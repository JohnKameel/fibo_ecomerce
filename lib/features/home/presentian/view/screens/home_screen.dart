import 'package:fido_e/core/routing/router_app.dart';
import 'package:fido_e/features/cart/presentation/viewModel/cart_cubit.dart';
import 'package:fido_e/features/home/presentian/viewModel/product_by_category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../viewModel/category_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Home',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<CartCubit>().getCart();
              context.push(RouterApp.cart);
            },
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for clothes...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Categories UI
            BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CategorySuccess) {
                  final categories = state.categories;
                  if (selectedCategory == null && categories.isNotEmpty) {
                    selectedCategory = categories.first;
                    context
                        .read<ProductByCategoryCubit>()
                        .loadProductsByCategory(selectedCategory!);
                  }
                  return SizedBox(
                    height: 50,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final isSelected = category == selectedCategory;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = category;
                            });
                            context
                                .read<ProductByCategoryCubit>()
                                .loadProductsByCategory(category);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isSelected ? Color(0xFF3669C9) : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                category,
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                    ),
                  );
                } else if (state is CategoryFailure) {
                  return Center(child: Text('Failed: ${state.errorMessage}'));
                } else {
                  return const SizedBox();
                }
              },
            ),
            const SizedBox(height: 12),
            // Product grid below categories
            Expanded(
              child:
                  BlocBuilder<ProductByCategoryCubit, ProductByCategoryState>(
                builder: (context, state) {
                  if (state is ProductByCategoryLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProductByCategorySuccess) {
                    final products = state.products;
                    return GridView.builder(
                      padding: const EdgeInsets.all(12),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return InkWell(
                          onTap: () {
                            GoRouter.of(context).push(
                              RouterApp.details,
                              extra: product,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Image.network(
                                    product.thumbnail,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  product.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text("\$${product.price}"),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is ProductByCategoryFailure) {
                    return Center(child: Text('Error: ${state.errorMessage}'));
                  }
                  return const Center(child: Text("Select a category"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
