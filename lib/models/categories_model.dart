// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this



class CategoriesModel
{
  bool? status;
  CategoriesDataModel? data;

  CategoriesModel({
    this.status,
    this.data
  });

  CategoriesModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = json['data'] != null ? new CategoriesDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['status'] = this.status;

    if (this.data != null)
    {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CategoriesDataModel
{
  int? currentPage;
  List<CategoryModel>? data;

  CategoriesDataModel({
    this.currentPage,
    this.data,
  });

  CategoriesDataModel.fromJson(Map<String, dynamic> json)
  {
    currentPage = json['current_page'];
    if (json['data'] != null)
    {
      data = <CategoryModel>[];
      json['data'].forEach((element)
      {
        data!.add(new CategoryModel.fromJson(element));
      });
    }
  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['current_page'] = this.currentPage;

    if (this.data != null)
    {
      data['data'] = this.data!.map((element) => element.toJson()).toList();
    }

    return data;
  }
}

class CategoryModel
{
  int? id;
  String? name;
  String? image;

  CategoryModel({
    this.id,
    this.name,
    this.image
  });

  CategoryModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

