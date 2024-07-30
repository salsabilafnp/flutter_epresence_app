class Kantor {
  int? id;
  String? name;
  String? email;
  String? address;
  String? latitude;
  String? longitude;
  String? radiusKm;
  String? timeIn;
  String? timeOut;
  String? createdAt;
  String? updatedAt;

  Kantor({
    this.id,
    this.name,
    this.email,
    this.address,
    this.latitude,
    this.longitude,
    this.radiusKm,
    this.timeIn,
    this.timeOut,
    this.createdAt,
    this.updatedAt,
  });
  Kantor.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    name = json['name']?.toString();
    email = json['email']?.toString();
    address = json['address']?.toString();
    latitude = json['latitude']?.toString();
    longitude = json['longitude']?.toString();
    radiusKm = json['radius_km']?.toString();
    timeIn = json['time_in']?.toString();
    timeOut = json['time_out']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['radius_km'] = radiusKm;
    data['time_in'] = timeIn;
    data['time_out'] = timeOut;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
