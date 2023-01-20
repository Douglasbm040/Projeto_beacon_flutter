class BeaconModels {
  String? characteristicUuid;
  String? descricao;
  String? deviceName;
  String? deviceId;
  double? latitude;
  double? longitude;
  String? serviceUuid;

  BeaconModels(
      {this.characteristicUuid,
      this.descricao,
      this.deviceName,
      this.deviceId,
      this.latitude,
      this.longitude,
      this.serviceUuid});

  BeaconModels.fromJson(Map<dynamic, dynamic> json) {
    characteristicUuid = json['CharacteristicUuid'];
    descricao = json['descricao'];
    deviceName = json['deviceName'];
    deviceId = json['device_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    serviceUuid = json['serviceUuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CharacteristicUuid'] = this.characteristicUuid;
    data['descricao'] = this.descricao;
    data['deviceName'] = this.deviceName;
    data['device_id'] = this.deviceId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['serviceUuid'] = this.serviceUuid;
    return data;
  }
}
