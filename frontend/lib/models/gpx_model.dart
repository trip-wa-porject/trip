class GPXModel {
  final String tripId;
  String gpxString;
  GPXModel(this.tripId, this.gpxString);

  factory GPXModel.fromJson(Map<String, dynamic> json) {
    return GPXModel(
      json['tripId'],
      json['gpxString'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'tripId': tripId,
      'gpxString': gpxString,
    };
  }
}
