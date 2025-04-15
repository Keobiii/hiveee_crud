enum ProductCategory {
  UNKNOWN("Unknown", 0),
  AA("Apparel and Accessories", 1),
  ET("Electronics", 2),
  HL("Home and Living", 3),
  HB("Health and Beauty", 4),
  FB("Food and Beverages", 5);

  final String categoryName;
  final int categoryId;

  const ProductCategory(this.categoryName, this.categoryId);

  // This function is responsible for converting an int (which represents a category id) into a corresponding ProductCategory enum value.
  static ProductCategory fromCategoryId(int categoryId) {
    return ProductCategory.values.firstWhere(
      (catId) => catId.categoryId == categoryId,
      orElse: () => ProductCategory.UNKNOWN,
    );
  }
}
