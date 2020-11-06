class CategoryModel {
  int status;
  String message;
  List<Data> data;

  CategoryModel({this.status, this.message, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String categoryId;
  String slug;
  String sequence;
  String name;
  List<Images> images;

  Data({this.categoryId, this.slug, this.sequence, this.name, this.images});

  Data.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    slug = json['slug'];
    sequence = json['sequence'];
    name = json['name'];
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['slug'] = this.slug;
    data['sequence'] = this.sequence;
    data['name'] = this.name;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  String logo;
  String banner;

  Images({this.logo, this.banner});

  Images.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
    banner = json['banner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logo'] = this.logo;
    data['banner'] = this.banner;
    return data;
  }
}
