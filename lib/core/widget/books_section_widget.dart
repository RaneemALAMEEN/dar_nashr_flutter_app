// import 'package:dar_nashr/core/widget/book_card.dart';
// import 'package:dar_nashr/core/widget/section_header_widget.dart';
// import 'package:flutter/material.dart';

// class BooksSection extends StatelessWidget {
//   const BooksSection({super.key});

//   final List<String> bookTitles = const [
//     "رجال حول الرسول",
//     "رجال حول الرسول",
//     "رجال حول الرسول",
//     "رجال حول الرسول",
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SectionHeader(title: 'كتب قد تعجبك', onViewAll: () {}),
//         const SizedBox(height: 12),
//         SizedBox(
//           height: 250,
//           child: ListView.separated(
//             scrollDirection: Axis.horizontal,
//             itemCount: bookTitles.length,
//             separatorBuilder: (_, __) => const SizedBox(width: 12),
//             itemBuilder: (context, index) {
//               return BookCard(title: bookTitles[index]);
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }


import 'package:dar_nashr/core/widget/book_card.dart';
import 'package:dar_nashr/core/widget/section_header_widget.dart';
import 'package:dar_nashr/pages/homepages/book/BooksByCategoryPage.dart';
import 'package:dar_nashr/services/book_service.dart';
import 'package:flutter/material.dart';
import 'package:dar_nashr/models/book_model.dart'; // ✅ مهم

class BooksSection extends StatefulWidget {
  const BooksSection({super.key});

  @override
  State<BooksSection> createState() => _BooksSectionState();
}

class _BooksSectionState extends State<BooksSection> {
  final BookService bookService = BookService();
  List<dynamic> books = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    try {
      final result = await bookService.getAllBooks(limit: 5);
      setState(() {
        books = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasData = !isLoading && books.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'كتب قد تعجبك',
          onViewAll: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BooksByCategoryPage()),
            );
          },
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 250,
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : !hasData
                  ? const Center(child: Text('لا توجد كتب حالياً'))
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      scrollDirection: Axis.horizontal,
                      itemCount: books.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final map = books[index] as Map<String, dynamic>; // ✅ استعمل books
                        final book = Book.fromJson(map);                   // ✅ حوّل لـ Book
                        return SizedBox(
                          width: 160, // مقاس مناسب للكارد الأفقي
                          child: BookCard(book: book), // ✅ يمرر Book كامل
                        );
                      },
                    ),
        ),
      ],
    );
  }
}
