class OrderTrackingModel {
  // ... (other properties)

  final int id;
  final int userId;
  final String customerAddress;
  final String requestType;
  final String serviceName;
  final String replacementPart;
  final String typeOfWaste;
  final String weight;
  final String quantity;
  final String scrapMaterialOne;
  final String scrapMaterialTwo;
  final String scrapMaterialThree;
  final String scrapMaterialFour;
  final String scrapMaterialFive;
  final String vendorType;
  final int? vendorId;
  final String otherDetail;
  final String price;
  final String paymentMethod;
  final String transactionNumber;
  final String status;

  OrderTrackingModel({
    required this.id,
    required this.userId,
    required this.customerAddress,
    required this.requestType,
    required this.serviceName,
    required this.replacementPart,
    required this.typeOfWaste,
    required this.weight,
    required this.quantity,
    required this.scrapMaterialOne,
    required this.scrapMaterialTwo,
    required this.scrapMaterialThree,
    required this.scrapMaterialFour,
    required this.scrapMaterialFive,
    required this.vendorType,
    required this.vendorId,
    required this.otherDetail,
    required this.price,
    required this.paymentMethod,
    required this.transactionNumber,
    required this.status,
  });

  factory OrderTrackingModel.fromJson(Map<String, dynamic> json) {
    return OrderTrackingModel(
      id: json['ID'] ?? 0,
      userId: json['user_id'] ?? 0,
      customerAddress: json['customer_address'] ?? '',
      requestType: json['request_type'] ?? '',
      serviceName: json['service_name'] ?? '',
      replacementPart: json['replacement_part'] ?? '',
      typeOfWaste: json['type_of_waste'] ?? '',
      weight: (json['weight'] ?? '').toString(),
      quantity: (json['quantity'] ?? '').toString(),
      scrapMaterialOne: json['scrap_material_one'] ?? '',
      scrapMaterialTwo: json['scrap_material_two'] ?? '',
      scrapMaterialThree: json['scrap_material_three'] ?? '',
      scrapMaterialFour: json['scrap_material_four'] ?? '',
      scrapMaterialFive: json['scrap_material_five'] ?? '',
      vendorType: json['vendor_type'] ?? '',
      vendorId: json['vendor_id'],
      otherDetail: json['other_detail'] ?? '',
      price: (json['price'] ?? '').toString(),
      paymentMethod: json['payment_method'] ?? '',
      transactionNumber: (json['transaction_number'] ?? '').toString(),
      status: json['status'] ?? '',
    );
  }
}
