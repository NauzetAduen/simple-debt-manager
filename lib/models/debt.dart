class Debt {
  
  int _id;
  String _name;
  String _debitor;
  String _description;
  double _totalQuantity;
  double _paidQuantity;
  
  Debt(this._name,this._debitor, this._description, this._totalQuantity, this._paidQuantity);
  Debt.withID(this._id, this._name,this._debitor, this._description, this._totalQuantity, this._paidQuantity);

  int get id => _id;
  String get name => _name;
  String get debitor => _debitor;
  String get description => _description;
  double get totalQuantity => _totalQuantity;
  double get paidQuantity => _paidQuantity;

  set name(String name) => this.name = name;
  set debitor(String debitor) => this._debitor = debitor;
  set description(String description) => this._description = description;
  set totalQuantity(double totalQuantity) => this._totalQuantity = totalQuantity;
  set paidQuantity(double paidQuantity) => this._paidQuantity = paidQuantity;

  //this.debt to map
  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();

    if (id != null) map['id'] = _id;
    map['name'] = _name;
    map['debitor'] = _debitor;
    map['description'] = _description;
    map['totalQuantity'] = _totalQuantity;
    map['paidQuantity'] = _paidQuantity;

    return map;
  }

  //named cosntructor from a map
  Debt.fromMap(Map<String,dynamic> map){
    this._id = map['id'];
    this._name = map['name'];
    this._debitor = map['debitor'];
    this._description = map['description'];
    this._totalQuantity = map['totalQuantity'];
    this._paidQuantity = map['paidQuantity'];
  }
  //named constructor: empty debt
  Debt.blank(){
    this._name = "";
    this._debitor = "";
    this._description = "";
    this._totalQuantity = 0.0;
    this._paidQuantity = 0.0;
  }

}
