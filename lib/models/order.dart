class Order {
  int totalPrice;
  int orderNumber;
  String address;
  String addressDetails;
  String documentId;
  bool isConfirmed = false;
  Order(
      {this.totalPrice,
      this.address,
      this.addressDetails,
      this.documentId,
      this.orderNumber,
      this.isConfirmed});
}
