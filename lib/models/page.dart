class Page<T> {
  final List<T> items;
  final int total;
  final int page;
  final int pageSize;
  final int pages;

  const Page({
    required this.items,
    required this.total,
    required this.page,
    required this.pageSize,
    required this.pages,
  });

  factory Page.fromJson(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic> json) fromItemJson,
      ) {
    return Page<T>(
      items: (json['items'] as List)
          .map((item) => fromItemJson(item as Map<String, dynamic>))
          .toList(),
      total: json['total'],
      page: json['page'],
      pageSize: json['page_size'],
      pages: json['pages'],
    );
  }
}