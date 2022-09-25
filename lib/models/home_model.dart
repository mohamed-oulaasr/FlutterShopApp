// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this


class HomeModel {
  bool? status;
  HomeDataModel? data;

  HomeModel({
    this.status,
    this.data
  });

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new HomeDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class HomeDataModel {
  List<BannerModel>? banners;
  List<ProductModel>? products;

  HomeDataModel({this.banners, this.products});

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <BannerModel>[];
      json['banners'].forEach((element) {
        banners!.add(new BannerModel.fromJson(element));
      });
    }
    if (json['products'] != null) {
      products = <ProductModel>[];
      json['products'].forEach((element) {
        products!.add(new ProductModel.fromJson(element));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.banners != null) {
      data['banners'] = this.banners!.map((element) => element.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((element) => element.toJson()).toList();
    }
    return data;
  }
}

class BannerModel {
  int? id;
  String? image;

  BannerModel({
    this.id,
    this.image
  });

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    return data;
  }
}

class ProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;

  ProductModel({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.inFavorites,
    this.inCart
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['discount'] = this.discount;
    data['image'] = this.image;
    data['name'] = this.name;
    data['in_favorites'] = this.inFavorites;
    data['in_cart'] = this.inCart;
    return data;
  }
}

/*
class HomeModel
{
  bool? status;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data   = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel
{
  List<BannerModel>? banners;
  List<ProductModel>? products;

  HomeDataModel.fromJson(Map<String, dynamic> json)
  {
    json['banners'].forEach((element)
    {
      banners!.add(element);
    });

    json['products'].forEach((element)
    {
      products!.add(element);
    });
  }
}

class BannerModel
{
  int? id;
  String? image;

  BannerModel.fromJson(Map<String, dynamic> json)
  {
    id    = json['id'];
    image = json['image'];
  }
}

class ProductModel
{
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;

  ProductModel.fromJson(Map<String, dynamic> json)
  {
    id          = json['id'];
    price       = json['price'];
    oldPrice    = json['old_price'];
    discount    = json['discount'];
    image       = json['image'];
    name        = json['name'];
    inFavorites = json['in_favorites'];
    inCart      = json['in_cart'];
  }
}
*/