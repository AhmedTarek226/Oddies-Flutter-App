class Product {
  String Pname;
  String Pprice;
  String Pdescription;
  String Pcategory;
  String Plocation;
  String Pid;
  List<dynamic> Psizes = [];
  bool saved;
  bool checkedinfav;
  Product(
      {this.Pname,
      this.Pprice,
      this.Pdescription,
      this.Pcategory,
      this.Plocation,
      this.Pid,
      this.Psizes,
      this.saved=false,
      this.checkedinfav = false});
  void toggleSaved() {
    saved = !saved;
  }

  void togglechecked() {
    checkedinfav = !checkedinfav;
  }
}
