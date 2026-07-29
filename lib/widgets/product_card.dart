// lib/widgets/product_card.dart

import 'package:flutter/material.dart';
import '../models/product.dart';
import '../utils/app_colors.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final VoidCallback onFavouriteToggle;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.onFavouriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0.05,
      color: context.productCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: context.cardBorderColor,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Expanded(
              child: Container(
                color: context.imagePlaceholderColor,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      product.image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: context.imageErrorColor,
                          child: Icon(
                            Icons.image_not_supported,
                            size: 48,
                            color: AppColors.getGreyShade(400),
                          ),
                        );
                      },
                    ),

                    // Favorite button
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.favoriteContainerColor,
                          border: Border.all(
                            color: AppColors.favoriteBorderColor,
                            width: 1.0,
                          ),
                        ),
                        child: IconButton(
                          icon: Icon(
                            product.isFavourite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: AppColors.getFavoriteColor(product.isFavourite),
                            size: 20,
                          ),
                          onPressed: onFavouriteToggle,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                            minWidth: 34,
                            minHeight: 34,
                          ),
                          splashRadius: 17,
                        ),
                      ),
                    ),

                    // Category label
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          product.category,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.categoryLabelText,
                            fontWeight: FontWeight.w600,
                          ) ?? TextStyle(
                            color: AppColors.categoryLabelText,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Product Details
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: context.textColor,
                    ) ?? const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'LKR ${product.price.toStringAsFixed(0)}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.textColor,
                    ) ?? const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}