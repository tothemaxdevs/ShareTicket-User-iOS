class SaveGaleryModel {
  String? filePath;
  String? errorMessage;
  bool? isSuccess;

  SaveGaleryModel({this.filePath, this.errorMessage, this.isSuccess});

  factory SaveGaleryModel.fromJson(Map<String, dynamic> json) {
    return SaveGaleryModel(
      filePath: json['filePath'],
      errorMessage: json['errorMessage'],
      isSuccess: json['isSuccess'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['filePath'] = filePath;
    data['errorMessage'] = errorMessage;
    data['isSuccess'] = isSuccess;
    return data;
  }
}
