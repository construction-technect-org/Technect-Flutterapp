import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/models/marketplace_products_model.dart';

// ConnectorProductDetailResponse removed, API returns object directly

class ConnectorProductDetail {
  String? id;
  String? merchantProfileId;
  MerchantProfile? merchantProfile;
  String? categoryProductId;
  CategoryProductData? categoryProduct;
  String? inventoryType;
  String? inventorySKU;
  SpecificProductDetails? productDetails;
  GenericDetails? genericDetails;
  String? name;
  String? brand;
  String? description;
  List<MarketplaceProductImage>? images;
  List<dynamic>? videos;
  String? price;
  String? gstPercentage;
  String? gstAmount;
  String? finalPrice;
  int? stock;
  bool? isAvailable;
  String? approvalStatus;
  String? status;
  String? comment;
  String? createdAt;
  String? updatedAt;

  ConnectorProductDetail({
    this.id,
    this.merchantProfileId,
    this.merchantProfile,
    this.categoryProductId,
    this.categoryProduct,
    this.inventoryType,
    this.inventorySKU,
    this.productDetails,
    this.genericDetails,
    this.name,
    this.brand,
    this.description,
    this.images,
    this.videos,
    this.price,
    this.gstPercentage,
    this.gstAmount,
    this.finalPrice,
    this.stock,
    this.isAvailable,
    this.approvalStatus,
    this.status,
    this.comment,
    this.createdAt,
    this.updatedAt,
  });

  factory ConnectorProductDetail.fromJson(Map<String, dynamic> json) {
    return ConnectorProductDetail(
      id: json['id'],
      merchantProfileId: json['merchantProfileId'],
      merchantProfile: json['merchantProfile'] != null
          ? MerchantProfile.fromJson(json['merchantProfile'])
          : null,
      categoryProductId: json['categoryProductId'],
      categoryProduct: json['categoryProduct'] != null
          ? CategoryProductData.fromJson(json['categoryProduct'])
          : null,
      inventoryType: json['inventoryType'],
      inventorySKU: json['inventorySKU'],
      productDetails: json['productDetails'] != null
          ? SpecificProductDetails.fromJson(json['productDetails'])
          : null,
      genericDetails: json['genericDetails'] != null
          ? GenericDetails.fromJson(json['genericDetails'])
          : null,
      name: json['name'],
      brand: json['brand'],
      description: json['description'],
      images: json['images'] != null
          ? (json['images'] as List).map((i) => MarketplaceProductImage.fromJson(i)).toList()
          : null,
      videos: json['videos'] != null ? List<dynamic>.from(json['videos']) : null,
      price: json['price'],
      gstPercentage: json['gstPercentage'],
      gstAmount: json['gstAmount'],
      finalPrice: json['finalPrice'],
      stock: json['stock'],
      isAvailable: json['isAvailable'],
      approvalStatus: json['approvalStatus'],
      status: json['status'],
      comment: json['comment'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class MerchantProfile {
  String? id;
  String? businessName;
  String? businessType;
  String? businessWebsite;
  String? businessEmail;
  String? businessPhone;
  String? alternateBusinessPhone;
  int? yearOfEstablish;
  dynamic logo;
  dynamic businessAddress;
  BusinessHours? businessHours;

  MerchantProfile({
    this.id,
    this.businessName,
    this.businessType,
    this.businessWebsite,
    this.businessEmail,
    this.businessPhone,
    this.alternateBusinessPhone,
    this.yearOfEstablish,
    this.logo,
    this.businessAddress,
    this.businessHours,
  });

  factory MerchantProfile.fromJson(Map<String, dynamic> json) {
    return MerchantProfile(
      id: json['id'],
      businessName: json['businessName'],
      businessType: json['businessType'],
      businessWebsite: json['businessWebsite'],
      businessEmail: json['businessEmail'],
      businessPhone: json['businessPhone'],
      alternateBusinessPhone: json['alternateBusinessPhone'],
      yearOfEstablish: json['yearOfEstablish'],
      logo: json['logo'],
      businessAddress: json['businessAddress'],
      businessHours: json['businessHours'] != null
          ? BusinessHours.fromJson(json['businessHours'])
          : null,
    );
  }
}

class BusinessHours {
  DayHours? monday;
  DayHours? tuesday;
  DayHours? wednesday;
  DayHours? thursday;
  DayHours? friday;
  DayHours? saturday;
  DayHours? sunday;

  BusinessHours({
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
  });

  factory BusinessHours.fromJson(Map<String, dynamic> json) {
    return BusinessHours(
      monday: json['monday'] != null ? DayHours.fromJson(json['monday']) : null,
      tuesday: json['tuesday'] != null ? DayHours.fromJson(json['tuesday']) : null,
      wednesday: json['wednesday'] != null ? DayHours.fromJson(json['wednesday']) : null,
      thursday: json['thursday'] != null ? DayHours.fromJson(json['thursday']) : null,
      friday: json['friday'] != null ? DayHours.fromJson(json['friday']) : null,
      saturday: json['saturday'] != null ? DayHours.fromJson(json['saturday']) : null,
      sunday: json['sunday'] != null ? DayHours.fromJson(json['sunday']) : null,
    );
  }
}

class DayHours {
  String? open;
  String? close;
  bool? closed;

  DayHours({this.open, this.close, this.closed});

  factory DayHours.fromJson(Map<String, dynamic> json) {
    return DayHours(open: json['open'], close: json['close'], closed: json['closed']);
  }
}

class CategoryProductData {
  String? id;
  String? subCategoryId;
  String? name;
  String? description;
  bool? isActive;

  CategoryProductData({this.id, this.subCategoryId, this.name, this.description, this.isActive});

  factory CategoryProductData.fromJson(Map<String, dynamic> json) {
    return CategoryProductData(
      id: json['id'],
      subCategoryId: json['subCategoryId'],
      name: json['name'],
      description: json['description'],
      isActive: json['isActive'],
    );
  }
}

class GenericDetails {
  String? id;
  String? unit;
  String? note;
  String? referenceUrl;
  List<String>? features;

  GenericDetails({this.id, this.unit, this.note, this.referenceUrl, this.features});

  factory GenericDetails.fromJson(Map<String, dynamic> json) {
    return GenericDetails(
      id: json['id'],
      unit: json['unit'],
      note: json['note'],
      referenceUrl: json['referenceUrl'],
      features: json['features'] != null ? List<String>.from(json['features']) : null,
    );
  }
}

class SpecificProductDetails {
  String? id;
  String? warehouseDetails;
  String? note;
  String? termsAndConditions;
  String? uom;
  String? uoc;
  String? packageType;
  String? shape;
  String? texture;
  String? colour;
  String? size;
  String? finenessModules;
  String? specificGravity;
  String? bulkDensity;
  String? waterAbsorption;
  String? moistureContent;
  String? clayDustContent;
  String? siltContent;
  String? machineType;

  SpecificProductDetails({
    this.id,
    this.warehouseDetails,
    this.note,
    this.termsAndConditions,
    this.uom,
    this.uoc,
    this.packageType,
    this.shape,
    this.texture,
    this.colour,
    this.size,
    this.finenessModules,
    this.specificGravity,
    this.bulkDensity,
    this.waterAbsorption,
    this.moistureContent,
    this.clayDustContent,
    this.siltContent,
    this.machineType,
  });

  factory SpecificProductDetails.fromJson(Map<String, dynamic> json) {
    return SpecificProductDetails(
      id: json['id'],
      warehouseDetails: json['warehouseDetails'],
      note: json['note'],
      termsAndConditions: json['termsAndConditions'],
      uom: json['uom'],
      uoc: json['uoc'],
      packageType: json['packageType'],
      shape: json['shape'],
      texture: json['texture'],
      colour: json['colour'],
      size: json['size'],
      finenessModules: json['finenessModules'],
      specificGravity: json['specificGravity'],
      bulkDensity: json['bulkDensity'],
      waterAbsorption: json['waterAbsorption'],
      moistureContent: json['moistureContent'],
      clayDustContent: json['clayDustContent'],
      siltContent: json['siltContent'],
      machineType: json['machineType'],
    );
  }
}
