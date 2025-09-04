import 'package:flutter/material.dart';

class Job {
  final String id;
  final String title;           // العنوان: محرر لغوي...
  final String type;            // دوام جزئي / كامل
  final String location;        // عن بُعد / ضمن المكتب
  final String deadline;        // آخر موعد للتقديم
  final String publisherName;   // اسم دار النشر
  final String? salary;         // اختياري
  final List<String> tasks;     // وصف المهام (نقاط)
  final List<String> requirements; // المؤهلات المطلوبة (نقاط)

  const Job({
    required this.id,
    required this.title,
    required this.type,
    required this.location,
    required this.deadline,
    required this.publisherName,
    this.salary,
    required this.tasks,
    required this.requirements,
  });
}
