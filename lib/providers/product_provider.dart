// lib/providers/product_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService _service = ProductService();
  
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = false;
  bool _isFavoritesLoading = false;
  String _errorMessage = "";
  String _searchQuery = "";
  String _selectedCategory = "All";
  bool _isInitialLoad = true;

  List<Product> get products => _filteredProducts;
  bool get isLoading => _isLoading;
  bool get isFavoritesLoading => _isFavoritesLoading;
  bool get isInitialLoad => _isInitialLoad;
  String get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;

  List<Product> get favoriteProducts => _allProducts.where((p) => p.isFavourite).toList();

  Future<void> loadProducts() async {
    try {
      _isLoading = true;
      _isInitialLoad = true;
      _errorMessage = "";
      notifyListeners();

      _allProducts = await _service.fetchProducts();
      await _loadFavourites();
      _applyFilter();
      
      _errorMessage = "";
    } catch (e) {
      _errorMessage = e.toString();
      _allProducts = [];
      _filteredProducts = [];
    } finally {
      _isLoading = false;
      _isInitialLoad = false;
      notifyListeners();
    }
  }
  
  Future<void> loadFavorites() async {
    try {
      _isFavoritesLoading = true;
      notifyListeners();

      // If products haven't been loaded yet, load them
      if (_allProducts.isEmpty) {
        await loadProducts();
      } else {
        // Otherwise just reload favorites from storage
        await _loadFavourites();
        _applyFilter();
      }
      
      _errorMessage = "";
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      await Future.delayed(const Duration(milliseconds: 500));
      _isFavoritesLoading = false;
      notifyListeners();
    }
  }

  
  Future<void> loadFavoritesWithDelay() async {
    try {
      _isFavoritesLoading = true;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 1500));
      
      if (_allProducts.isEmpty) {
        await loadProducts();
      } else {
        await _loadFavourites();
        _applyFilter();
      }
      
      _errorMessage = "";
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isFavoritesLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshProducts() async {
    await loadProducts();
  }

  void toggleFavourite(Product product) {
    final index = _allProducts.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _allProducts[index].isFavourite = !_allProducts[index].isFavourite;
      _saveFavourites();
      _applyFilter();
      notifyListeners();
    }
  }

  Future<void> searchProductsAsync(String query) async {
    try {
      _isLoading = true;
      _searchQuery = query;
      notifyListeners();
      
      await Future.delayed(const Duration(milliseconds: 300));
      
      _applyFilter();
      _errorMessage = "";
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchProducts(String query) {
    _searchQuery = query;
    _applyFilter();
    notifyListeners();
  }

  Future<void> filterByCategoryAsync(String category) async {
    try {
      _isLoading = true;
      _selectedCategory = category;
      notifyListeners();
      
      await Future.delayed(const Duration(milliseconds: 300));
      
      _applyFilter();
      _errorMessage = "";
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void filterByCategory(String category) {
    _selectedCategory = category;
    _applyFilter();
    notifyListeners();
  }

  void _applyFilter() {
    _filteredProducts = _allProducts.where((product) {
      final matchesSearch = product.name.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == "All" || product.category.toLowerCase() == _selectedCategory.toLowerCase();
      return matchesSearch && matchesCategory;
    }).toList();
  }

  Future<void> _loadFavourites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favourites = prefs.getStringList('favourites') ?? [];
      for (var product in _allProducts) {
        product.isFavourite = favourites.contains(product.id.toString());
      }
    } catch (e) {
     
    }
  }

  Future<void> _saveFavourites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favourites = _allProducts
          .where((p) => p.isFavourite)
          .map((p) => p.id.toString())
          .toList();
      await prefs.setStringList('favourites', favourites);
    } catch (e) {
      
    }
  }

  void retry() {
    loadProducts();
  }

  Future<void> clearSearchAsync() async {
    try {
      _isLoading = true;
      notifyListeners();
      
      await Future.delayed(const Duration(milliseconds: 200));
      
      _searchQuery = "";
      _applyFilter();
      _errorMessage = "";
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    _searchQuery = "";
    _applyFilter();
    notifyListeners();
  }

  bool get hasFavorites => _allProducts.any((p) => p.isFavourite);
}