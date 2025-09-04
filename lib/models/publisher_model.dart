// lib/models/publisher_model.dart
class Publisher {
  final int id;
  final String name;
  final String email;
  final bool isActive;
  final bool isVerified;
  final String createdAt;
  final String? logoImage;    // قد تكون "string" أو null
  final String? licenseImage;
  final String? address;
  final String? contactInfo;

  Publisher({
    required this.id,
    required this.name,
    required this.email,
    required this.isActive,
    required this.isVerified,
    required this.createdAt,
    this.logoImage,
    this.licenseImage,
    this.address,
    this.contactInfo,
  });

  factory Publisher.fromJson(Map<String, dynamic> json) {
    return Publisher(
      id: (json['id'] as num).toInt(),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      isActive: json['is_active'] ?? false,
      isVerified: json['is_verified'] ?? false,
      createdAt: json['created_at'] ?? '',
      logoImage: json['logo_image'],
      licenseImage: json['license_image'],
      address: json['address'],
      contactInfo: json['contact_info'],
    );
  }
}
