// lib/models/job_opportunity.dart
class JobOpportunity {
  final int id;
  final String position;       // عنوان الفرصة
  final String description;    // الوصف
  final String requirements;   // المتطلبات
  final bool isActive;
  final String createdAt;      // ISO
  final int publisherHouseId;
  final String publisherName;
  final String? publisherEmail;
  final String? publisherAddress;

  JobOpportunity({
    required this.id,
    required this.position,
    required this.description,
    required this.requirements,
    required this.isActive,
    required this.createdAt,
    required this.publisherHouseId,
    required this.publisherName,
    this.publisherEmail,
    this.publisherAddress,
  });

  factory JobOpportunity.fromJson(Map<String, dynamic> json) {
    final ph = json['publisher_house'] as Map<String, dynamic>?;

    return JobOpportunity(
      id: (json['id'] as num).toInt(),
      position: json['position'] ?? '',
      description: json['description'] ?? '',
      requirements: json['requirements'] ?? '',
      isActive: json['is_active'] ?? true,
      createdAt: json['created_at'] ?? '',
      publisherHouseId: (json['publisher_house_id'] as num?)?.toInt() ?? 0,
      publisherName: ph != null ? (ph['name'] ?? '') : '',
      publisherEmail: ph != null ? ph['email'] as String? : null,
      publisherAddress: ph != null ? ph['address'] as String? : null,
    );
  }
}
