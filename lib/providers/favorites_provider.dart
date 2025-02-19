import 'package:flutter/material.dart';
import '../models/quote.dart';

class FavoritesProvider extends ChangeNotifier {
  final Set<Quote> _favoriteQuotes = {};

  Set<Quote> get favoriteQuotes => _favoriteQuotes;

  void toggleFavorite(Quote quote) {
    if (_favoriteQuotes.contains(quote)) {
      _favoriteQuotes.remove(quote);
    } else {
      _favoriteQuotes.add(quote);
    }
    notifyListeners();
  }
}