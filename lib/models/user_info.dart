class UserInformation {
  String email;
  String name;
  String address;
  String addressDetails;
  String phoneNumber;
  List<int> orderId = [];
  //List<String> savedProducts=[];
  String Uid;
  UserInformation({
    this.address,
    this.email,
    this.name,
    this.addressDetails,
    this.phoneNumber,
    this.orderId,
    this.Uid, //this.savedProducts
  });
}
