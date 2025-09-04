import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFReaderScreen extends StatefulWidget {
  final String pdfUrl;
  final bool isFree;
  final Map<String, String>? headers;

  const PDFReaderScreen({
    super.key,
    required this.pdfUrl,
    required this.isFree,
    this.headers,
  });

  @override
  State<PDFReaderScreen> createState() => _PDFReaderScreenState();
}

class _PDFReaderScreenState extends State<PDFReaderScreen> {
  final PdfViewerController _pdfController = PdfViewerController();
  final GlobalKey<SfPdfViewerState> _pdfKey = GlobalKey(); // ← للبوكمارك
  int _pageCount = 1; // ← نحدّثه عند تحميل الملف

  @override
  Widget build(BuildContext context) {
    if (widget.pdfUrl.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("قراءة الكتاب"),
          backgroundColor: const Color(0xff1D2A45),
          foregroundColor: Colors.white,
        ),
        body: const Center(child: Text('لا يوجد ملف متاح')),
      );
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("قراءة الكتاب"),
          backgroundColor: const Color(0xff1D2A45),
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              tooltip: 'الأولى',
              icon: const Icon(Icons.first_page),
              onPressed: () => _pdfController.jumpToPage(1),
            ),
            IconButton(
              tooltip: 'الأخيرة',
              icon: const Icon(Icons.last_page),
              onPressed: () => _pdfController.jumpToPage(_pageCount),
            ),
            IconButton(
              tooltip: 'الفهرس/Bookmarks',
              icon: const Icon(Icons.bookmarks),
              onPressed: () => _pdfKey.currentState?.openBookmarkView(), // ← من الـ key
            ),
          ],
        ),
        body: SfPdfViewer.network(
          widget.pdfUrl,
          key: _pdfKey,                      // ← اربط الـ key
          controller: _pdfController,        // ← اربط الكنترولر
          headers: widget.headers,           // (اختياري) لو عندك Authorization
          canShowScrollStatus: true,
          canShowPaginationDialog: true,
          enableDoubleTapZooming: true,
          onDocumentLoaded: (details) {
            // خزّن عدد الصفحات لاستخدامه في زر "الأخيرة"
            setState(() {
              _pageCount = details.document.pages.count;
            });
          },
          onDocumentLoadFailed: (details) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('تعذّر فتح الملف: ${details.description}'),
                backgroundColor: Colors.red,
              ),
            );
          },
        ),
      ),
    );
  }
}
