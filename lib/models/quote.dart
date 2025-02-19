class Quote {
  final String quote;
  final String author;
  final String category;
  final String context;

  Quote({required this.quote, required this.author, required this.category, required this.context});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Quote &&
          runtimeType == other.runtimeType &&
          quote == other.quote &&
          author == other.author &&
          category == other.category &&
          context == other.context;

  @override
  int get hashCode => quote.hashCode ^ author.hashCode ^ category.hashCode ^ context.hashCode;
}