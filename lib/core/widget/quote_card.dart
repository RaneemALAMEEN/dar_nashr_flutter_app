

// import 'package:flutter/material.dart';

// class QuoteCard extends StatelessWidget {
//   final String quoteText;
//   final String authorName;
//   final String addedBy; // اسم الشخص يلي أضاف الاقتباس

//   const QuoteCard({
//     super.key,
//     required this.quoteText,
//     required this.authorName,
//     required this.addedBy,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 220,
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: const Color(0xffE1D4B7),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ✅ أيقونة الإعجاب عاليمين
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [Text(
//             addedBy,
//             style: const TextStyle(
//               fontSize: 10,
//               fontWeight: FontWeight.w400,
//               color: Color(0xff1D2A45),
//             ),
//           ),
//               IconButton(
//                 icon: const Icon(
//                   Icons.favorite_border,
//                   size: 18,
//                   color: Color(0xff1D2A45),
//                 ),
//                 padding: EdgeInsets.zero,
//                 constraints: const BoxConstraints(),
//                 onPressed: () {
//                   // الأكشن لو حابة
//                 },
//               ),
              
//             ],
//           ),

//           // ✅ اسم الشخص يلي أضاف الاقتباس
          
//           const SizedBox(height: 9),

//           // ✅ نص الاقتباس
//           Text(
//             quoteText,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 14,
//               height: 1.3,
//               color: Color(0xff1D2A45),
//             ),
//             maxLines: 3,
//             overflow: TextOverflow.ellipsis,
//           ),

//           const SizedBox(height: 12),

//           // ✅ اسم الكاتب الأصلي
//           Text(
//             authorName,
//             style: const TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.w600,
//               color: Color(0xff731F28),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }





import 'package:dar_nashr/models/qoute_model.com';
import 'package:dar_nashr/models/quote_model.dart';
import 'package:dar_nashr/services/qoute_service.dart';
import 'package:flutter/material.dart';

class QuoteCard extends StatefulWidget {
  final Quote quote;
  final VoidCallback? onLike;

  const QuoteCard({super.key, required this.quote, this.onLike});

  @override
  State<QuoteCard> createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> {
  bool isLiked = false;
  final QuoteService _quoteService = QuoteService();

  // @override
  // void initState() {
  //   super.initState();
  //   // إذا بدك، ممكن تتحقق من هل المستخدم حب الاقتباس سابقًا
  // }

  Future<void> _toggleLike() async {
    try {
      final success = await _quoteService.toggleLike(widget.quote.id);

      if (success) {
        setState(() {
          isLiked = !isLiked;
        });

        // تشغيل أي دالة خارجية (مثل تحديث الاقتباسات)
        if (widget.onLike != null) widget.onLike!();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isLiked ? "تم الإعجاب بالاقتباس ✅" : "تم إلغاء الإعجاب ❌",
            ),
            backgroundColor: isLiked ? Colors.green : Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      debugPrint("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("حصل خطأ أثناء معالجة الإعجاب"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xffE1D4B7),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // اسم المستخدم + زر لايك
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.quote.userName,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff1D2A45),
                ),
              ),
              GestureDetector(
                onTap: _toggleLike,
                child: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: const Color(0xff731F28),
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),

          // نص الاقتباس
          Text(
            widget.quote.text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              height: 1.3,
              color: Color(0xff1D2A45),
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),

          const Spacer(),

          // اسم الكتاب
          Text(
            widget.quote.bookName,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xff731F28),
            ),
          ),
        ],
      ),
    );
  }
}



// import 'package:dar_nashr/models/quote_model.dart';
// import 'package:dar_nashr/services/qoute_service.dart';
// import 'package:flutter/material.dart';


// class QuoteCard extends StatefulWidget {
//   final Quote quote;

//   const QuoteCard({super.key, required this.quote});

//   @override
//   State<QuoteCard> createState() => _QuoteCardState();
// }

// class _QuoteCardState extends State<QuoteCard> {
//   bool isLiked = false;
//   final QuoteService _quoteService = QuoteService();

//   Future<void> _toggleLike() async {
//     try {
//       final success = await _quoteService.toggleLike(widget.quote.id);

//       if (success) {
//         setState(() {
//           isLiked = !isLiked;
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               isLiked ? "تم الإعجاب بالاقتباس ✅" : "تم إلغاء الإعجاب ❌",
//             ),
//             backgroundColor: isLiked ? Colors.green : Colors.red,
//             duration: const Duration(seconds: 2),
//           ),
//         );
//       }
//     } catch (e) {
//       debugPrint("Error: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("حصل خطأ أثناء معالجة الإعجاب"),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 220,
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: const Color(0xffE1D4B7),
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 6,
//             offset: const Offset(0, 4),
//           )
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ✅ اسم المستخدم + زر لايك
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 widget.quote.userName,
//                 style: const TextStyle(
//                   fontSize: 10,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xff1D2A45),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: _toggleLike,
//                 child: Icon(
//                   isLiked ? Icons.favorite : Icons.favorite_border,
//                   color: const Color(0xff731F28),
//                   size: 20,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 9),

//           // ✅ نص الاقتباس
//           Text(
//             widget.quote.text,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 14,
//               height: 1.3,
//               color: Color(0xff1D2A45),
//             ),
//             maxLines: 3,
//             overflow: TextOverflow.ellipsis,
//           ),

//           const Spacer(),

//           // ✅ اسم الكتاب
//           Text(
//             widget.quote.bookName,
//             style: const TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.w600,
//               color: Color(0xff731F28),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
