// lib/screens/product_list_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../utils/app_colors.dart';
import '../utils/theme.dart';
import '../widgets/main_button.dart';
import '../widgets/product_card.dart';
import '../widgets/search_bar.dart';
import '../widgets/custom_bottom_bar.dart';
import 'product_details_screen.dart';
import 'favorites_screen.dart';

class ProductListScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDark;

  const ProductListScreen({
    super.key,
    required this.onThemeToggle,
    required this.isDark,
  });

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isActionLoading = false;
  int _currentIndex = 1;

  final List<String> categories = [
    'All',
    'Classic',
    'Summer',
    'Tropical',
    'Green',
    'Citrus',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _handleSearch(ProductProvider provider, String query) async {
    setState(() => _isActionLoading = true);
    await Future.delayed(const Duration(milliseconds: 300));
    provider.searchProducts(query);
    if (mounted) setState(() => _isActionLoading = false);
  }

  Future<void> _handleCategoryFilter(ProductProvider provider, String category) async {
    setState(() => _isActionLoading = true);
    await Future.delayed(const Duration(milliseconds: 300));
    provider.filterByCategory(category);
    if (mounted) setState(() => _isActionLoading = false);
  }

  void _handleBottomBarTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    
    switch (index) {
      case 0:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Home tab selected')),
        );
        break;
      case 1:
        final provider = Provider.of<ProductProvider>(context, listen: false);
        provider.clearSearch();
        _searchController.clear();
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const FavoritesScreen(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        break;
      case 3:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile tab selected')),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 10,
        actions: [
          IconButton(
            icon: Icon(
              widget.isDark ? Icons.light_mode : Icons.dark_mode,
              color: context.textColor,
            ),
            onPressed: widget.onThemeToggle,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
            child: SearchBarWidget(
              controller: _searchController,
              onChanged: (query) => _handleSearch(provider, query),
              onClear: () async {
                _searchController.clear();
                setState(() => _isActionLoading = true);
                await Future.delayed(const Duration(milliseconds: 200));
                provider.clearSearch();
                if (mounted) setState(() => _isActionLoading = false);
              },
            ),
          ),
          if (provider.products.isNotEmpty && !provider.isLoading && !_isActionLoading)
            SizedBox(
              height: 55,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final selected = provider.selectedCategory == category;

                  return Padding(
                    padding: const EdgeInsets.all(4),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: selected,
                      showCheckmark: false,
                      selectedColor: widget.isDark ? AppColors.textLight : AppColors.textPrimary,
                      backgroundColor: context.cardBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: selected ? Colors.transparent : Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      labelStyle: theme.textTheme.bodyMedium?.copyWith(
                        color: selected ? Colors.white : context.textColor,
                        fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                      ),
                      onSelected: (value) {
                        _handleCategoryFilter(provider, category);
                      },
                    ),
                  );
                },
              ),
            ),
          Expanded(
            child: _buildBody(provider, theme),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: _currentIndex,
        onTap: _handleBottomBarTap,
        isDark: widget.isDark,
      ),
    );
  }

  Widget _buildBody(ProductProvider provider, ThemeData theme) {
    if (provider.isLoading || _isActionLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: widget.isDark ? AppColors.textLight : AppColors.textPrimary,
            ),
            const SizedBox(height: 16),
            Text(
              'Loading products...',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: context.textColor,
              ),
            ),
          ],
        ),
      );
    }

    if (provider.errorMessage.isNotEmpty) {
      return Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 80,
                color: AppColors.errorColor,
              ),
              const SizedBox(height: 16),
              Text(
                'Oops! Something went wrong',
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: context.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                provider.errorMessage,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: widget.isDark ? Colors.white54 : AppColors.getGreyShade(600),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: provider.retry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.isDark ? AppColors.textLight : AppColors.textPrimary,
                  foregroundColor: widget.isDark ? AppColors.textPrimary : AppColors.textLight,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text("Try Again"),
              ),
            ],
          ),
        ),
      );
    }

    if (provider.products.isEmpty) {
      final bool isSearching = _searchController.text.isNotEmpty || provider.selectedCategory != 'All';

      return Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: widget.isDark ? AppColors.darkCardBackground : AppColors.lightGreen,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    isSearching ? Icons.search_off_rounded : Icons.inbox_outlined,
                    size: 55,
                    color: AppColors.primaryGreen,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                isSearching ? "No results found" : "No products available",
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: context.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                isSearching
                    ? 'We couldn\'t find anything matching your search for "${_searchController.text}". Try checking for typos or using different keywords.'
                    : "No products are available at the moment. Please check back later.",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: widget.isDark ? Colors.white54 : AppColors.getGreyShade(600),
                  height: 1.5,
                ),
              ),
              if (isSearching) ...[
                const SizedBox(height: 32),
                MainButton(
                  text: "Clear Search",
                  onPressed: () async {
                    _searchController.clear();
                    setState(() => _isActionLoading = true);
                    await Future.delayed(const Duration(milliseconds: 200));
                    provider.clearSearch();
                    if (mounted) setState(() => _isActionLoading = false);
                  },
                ),
              ],
            ],
          ),
        ),
      );
    }

    final bool showBanner = provider.selectedCategory == 'All' && _searchController.text.isEmpty;

    return CustomScrollView(
      slivers: [
        if (showBanner)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: widget.isDark ? AppColors.darkCardBackground : AppColors.imagePlaceholderLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sweet, tropical, and naturally refreshing. Made from freshly picked pineapples for the perfect burst of flavor.",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              height: 1.4,
                              color: context.textColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: widget.isDark ? AppColors.textLight : AppColors.textPrimary,
                              foregroundColor: widget.isDark ? AppColors.textPrimary : AppColors.textLight,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text("Order Now"),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: Image.asset(
                        "assets/images/overlay.png",
                        height: 150,
                        width: 140,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stack) {
                          return Icon(
                            Icons.image_not_supported,
                            color: context.textColor.withOpacity(0.5),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.68,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final product = provider.products[index];
                return ProductCard(
                  product: product,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsScreen(
                          product: product,
                        ),
                      ),
                    );
                  },
                  onFavouriteToggle: () {
                    provider.toggleFavourite(product);
                  },
                );
              },
              childCount: provider.products.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 30),
        ),
      ],
    );
  }
}