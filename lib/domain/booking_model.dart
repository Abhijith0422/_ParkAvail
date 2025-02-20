class BookingModel {
  final String id;
  final int slotNumber;
  final String district;
  final String timeSlot;
  final String parkingName;
  final String location;
  final bool isActive;
  final String userId;
  final DateTime bookingDate;
  final DateTime startTime; // Add this field

  BookingModel({
    required this.id,
    required this.slotNumber,
    required this.district,
    required this.timeSlot,
    required this.parkingName,
    required this.location,
    required this.isActive,
    required this.userId,
    required this.bookingDate,
    required this.startTime, // Add this
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slotNumber': slotNumber,
      'district': district,
      'timeSlot': timeSlot,
      'parkingName': parkingName,
      'location': location,
      'isActive': isActive,
      'userId': userId,
      'bookingDate': bookingDate.toIso8601String(),
      'startTime': startTime.toIso8601String(), // Add this
    };
  }

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] ?? '',
      slotNumber: json['slotNumber'] ?? 0,
      district: json['district'] ?? '',
      timeSlot: json['timeSlot'] ?? '',
      parkingName: json['parkingName'] ?? '',
      location: json['location'] ?? '',
      isActive: json['isActive'] ?? false,
      userId: json['userId'] ?? '',
      bookingDate:
          json['bookingDate'] != null
              ? DateTime.parse(json['bookingDate'])
              : DateTime.now(),
      startTime:
          json['startTime'] != null
              ? DateTime.parse(json['startTime'])
              : DateTime.now(), // Add this
    );
  }
}
