class TaxModel {
  int status;
  String message;
  List<taxData> data;

  TaxModel({this.status, this.message, this.data});

  TaxModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<taxData>();
      json['data'].forEach((v) {
        data.add(new taxData.fromJson(v));
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

class taxData {
  String taxClassId;
  String basedOn;
  String label;
  var taxRates;

  taxData({this.taxClassId, this.basedOn, this.label, this.taxRates});

  taxData.fromJson(Map<String, dynamic> json) {
    taxClassId = json['tax_class_id'];
    basedOn = json['based_on'];
    label = json['label'];
    if (json['tax_rates'].length > 0) {
      taxRates = new List<TaxRates>();
      json['tax_rates'].forEach((v) {
        taxRates.add(new TaxRates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tax_class_id'] = this.taxClassId;
    data['based_on'] = this.basedOn;
    data['label'] = this.label;
    if (this.taxRates != null) {
      data['tax_rates'] = this.taxRates.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaxRates {
  String taxRateId;
  String label;
  String country;
  String state;
  String city;
  String zip;
  String rate;

  TaxRates(
      {this.taxRateId,
      this.label,
      this.country,
      this.state,
      this.city,
      this.zip,
      this.rate});

  TaxRates.fromJson(Map<String, dynamic> json) {
    taxRateId = json['tax_rate_id'];
    label = json['label'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    zip = json['zip'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tax_rate_id'] = this.taxRateId;
    data['label'] = this.label;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['zip'] = this.zip;
    data['rate'] = this.rate;
    return data;
  }
}
