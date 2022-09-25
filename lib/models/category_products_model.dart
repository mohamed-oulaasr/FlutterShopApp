// ignore_for_file: prefer_void_to_null, unnecessary_new

class CategoryProductsModel {
  bool? status;
  Null message;
  Data? data;

  CategoryProductsModel({
    this.status,
    this.message,
    this.data
  });

  CategoryProductsModel.fromJson(Map<String, dynamic> json) {
    status  = json['status'];
    message = json['message'];
    data    = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  List<ProductModel>? products;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  Null nextPageUrl;
  String? path;
  int? perPage;
  Null prevPageUrl;
  int? to;
  int? total;

  Data({
    this.currentPage,
    this.products,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total
  });

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      products = <ProductModel>[];
      json['data'].forEach((v) {
        products!.add(new ProductModel.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class ProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;

  ProductModel({
    this.id,
      this.price,
      this.oldPrice,
      this.discount,
      this.image,
      this.name,
      this.description,
      this.images,
      this.inFavorites,
      this.inCart
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id          = json['id'];
    price       = json['price'];
    oldPrice    = json['old_price'];
    discount    = json['discount'];
    image       = json['image'];
    name        = json['name'];
    description = json['description'];
    images      = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart      = json['in_cart'];
  }

}
