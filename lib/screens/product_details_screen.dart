// lib/screens/product_details_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';
import '../utils/app_colors.dart';
import '../widgets/main_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.backgroundColor,
        elevation: 0.5,
        toolbarHeight: kToolbarHeight,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: context.textColor,
            size: 22,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Product Details',
          style: theme.textTheme.titleMedium?.copyWith(
            color: context.textColor,
            fontWeight: FontWeight.w600,
            fontSize: 20, 
          ),
        ),
        centerTitle: true,
       actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0), 
            child: IconButton(
              icon: Icon(
                widget.product.isFavourite ? Icons.favorite : Icons.favorite_border,
                color: widget.product.isFavourite 
                    ? AppColors.favoriteColor 
                    : context.textColor,
                size: 28,
              ),
              onPressed: () {
                context.read<ProductProvider>().toggleFavourite(widget.product);
                setState(() {});
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 320,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: context.imagePlaceholderColor,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    widget.product.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) {
                      return Center(
                        child: Icon(
                          Icons.image_not_supported,
                          size: 64,
                          color: isDark ? AppColors.getGreyShade(400) : AppColors.getGreyShade(400),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.product.name,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: isDark ? AppColors.textLight : AppColors.secondaryGreen,
                      fontWeight: FontWeight.w600, 
                    ),
                  ),
                ),
                Text(
                  'LKR ${widget.product.price.toStringAsFixed(0)}',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: context.textColor,
                    fontWeight: FontWeight.w600, 
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Category
            Text(
              widget.product.category,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isDark ? AppColors.getGreyShade(400) : AppColors.getGreyShade(600),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),

            // Quantity Selector
            Container(
              decoration: BoxDecoration(
                color: AppColors.darkElement,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              width: 130,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (quantity > 1) {
                        setState(() {
                          quantity--;
                        });
                      }
                    },
                    child: const Icon(Icons.remove, color: Colors.white, size: 20),
                  ),
                  Text(
                    '$quantity',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.textLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        quantity++;
                      });
                    },
                    child: const Icon(Icons.add, color: Colors.white, size: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Description Header
            Text(
              'Description',
              style: theme.textTheme.titleLarge?.copyWith(
                color: context.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Description Body
            Text(
              widget.product.description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isDark ? AppColors.getGreyShade(400) : AppColors.getGreyShade(700),
                height: 1.8,
                letterSpacing: 0.3,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: context.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.getShadowColor(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            // Buy Now Button
            Expanded(
              child: MainButton(
                text: 'Buy Now',
                onPressed: () {
                  // Handle Buy Now
                },
                backgroundColor: AppColors.darkElement,
                textColor: AppColors.textLight,
                height: 45,
                borderRadius: 30,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 16),
            // Add to Cart Button
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: context.textColor,
                  side: BorderSide(
                    color: isDark ? AppColors.getGreyShade(600) : AppColors.getGreyShade(400),
                    width: 1,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  // Handle Add to Cart
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 18,
                      color: context.textColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Add to Cart',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: context.textColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}