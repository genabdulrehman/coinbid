class PricePlanModel {

  String packageName,url,des1,des2,des3;
  double price;
  bool active;
  bool isRecommended;

  PricePlanModel({required this.packageName,
    required this.url,
    required this.des1,
    required this.des2,
    required this.des3,
    required this.active,
    required this.isRecommended,
    required this.price});

  // RequestModel.fromMap(Map<String, dynamic> data){
  //   uid = data[iD];
  //   name = data[dbName];
  //   misId = data[dbMisId];
  //   department = data[dbDepartment];
  //   shift = data[dbShift];
  //   token = data[dbToken];
  // }


}