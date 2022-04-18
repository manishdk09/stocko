
import 'dart:convert';

import 'package:get/get.dart';

VersionResponce versionResponceFromJson(String str) => VersionResponce.fromJson(json.decode(str));

String versionResponceToJson(VersionResponce data) => json.encode(data.toJson());

class VersionResponce {
  VersionResponce({
    this.status,
    this.version,
  });

  String? status;
  RxString? version;

  factory VersionResponce.fromJson(Map<String, dynamic> json) => VersionResponce(
    status: json["status"],
    version: RxString(json["version"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "version": version,
  };
}
