class CartsModel {
  int _id;
  String _productid;
  String _optionlable;
  String _optionvalueId;
  String _quantity;
  String _price;
  String _optionname;
  String _optionid;
  String _productpriceincreased;

  CartsModel(
      this._id,
      this._productid,
      this._optionlable,
      this._optionvalueId,
      this._quantity,
      this._price,
      this._optionname,
      this._optionid,
      this._productpriceincreased);

  String get price => _price;

  set price(String value) {
    _price = value;
  }

  String get quantity => _quantity;

  set quantity(String value) {
    _quantity = value;
  }

  String get optionlable => _optionlable;

  set optionlable(String value) {
    _optionlable = value;
  }

  String get optionvalueId => _optionvalueId;

  set optionvalueId(String value) {
    _optionvalueId = value;
  }

  String get productid => _productid;

  set productid(String value) {
    _productid = value;
  }

  String get optionname => _optionname;

  set optionname(String value) {
    _optionname = value;
  }

  String get optionid => _optionid;

  set optionid(String value) {
    _optionid = value;
  }

  String get productpriceincreased => _productpriceincreased;

  set productpriceincreased(String value) {
    _productpriceincreased = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['productid'] = _productid;
    map['optionlable'] = _optionlable;
    map['optionvalue'] = _optionvalueId;
    map['quantity'] = _quantity;
    map['price'] = _price;
    map['productpriceincreased'] = _productpriceincreased;
    map['optionname'] = _optionname;
    map['optionid'] = _optionid;

    return map;
  }

  CartsModel.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._productid = map['productid'];
    this._optionlable = map['optionlable'];
    this._optionvalueId = map['optionvalue'];
    this._price = map['price'];
    this._quantity = map['quantity'];
    this._optionname = map['optionname'];
    this._optionid = map['optionid'];
    this._productpriceincreased = map['productpriceincreased'];
  }
}
