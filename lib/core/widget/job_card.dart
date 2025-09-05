import 'package:dar_nashr/core/resources/color.dart';
import 'package:flutter/material.dart';

class JobCard extends StatelessWidget {
  final String title;
  final String type;
  final String location;
  final String deadline;
  final VoidCallback onApply;
  final VoidCallback onTap;

  const JobCard({
    super.key,
    required this.title,
    required this.type,
    required this.location,
    required this.deadline,
    required this.onApply,
    required this.onTap, 
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // أيقونة بسيطة متوافقة مع فغما
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.textSecondaryC,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.edit, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 12),
            // نصوص
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // العنوان + أيقونة حفظ (اختياري)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Color(0xff1D2A45),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.work_outline, size: 16, color: Color(0xFF6B7280)),
                      const SizedBox(width: 4),
                      Text(
                        type,
                        style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.place_outlined, size: 16, color: Color(0xFF6B7280)),
                      const SizedBox(width: 4),
                      Text(
                        location,
                        style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.event_note, size: 16, color: Color(0xFF6B7280)),
                      const SizedBox(width: 4),
                      Text(
                        'آخر موعد التقديم: $deadline',
                        style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // زر "قدّم الآن" صغير مثل فغما
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 32,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.secondary, // خمري
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: onApply,
                        child: const Text(
                          'قدّم الآن',
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
