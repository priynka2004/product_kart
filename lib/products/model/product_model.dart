class ProductModel {
  String? sId;
  String? name;
  int? price;
  String? description;
  String? imgUrl;
  double? rating;
  int? iV;

  ProductModel(
      {this.sId,
        this.name,
        this.price,
        this.description,
        this.imgUrl,
        this.rating,
        this.iV});

  ProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    imgUrl = json['imgUrl'];
    rating = json['rating'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['price'] = price;
    data['description'] = description;
    data['imgUrl'] = imgUrl;
    data['rating'] = rating;
    data['__v'] = iV;
    return data;
  }
}