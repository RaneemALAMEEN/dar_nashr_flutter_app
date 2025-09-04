


// // import 'package:flutter/material.dart';
// // import 'package:gap/gap.dart';
// // import 'package:dar_nashr/core/resources/color.dart';
// // import 'package:dar_nashr/core/widget/app_button.dart';
// // import 'package:dar_nashr/core/widget/app_textfield.dart';
// // import 'package:dar_nashr/pages/homepages/navigation_bar.dart';

// // class AddQuotePage extends StatelessWidget {
// //   const AddQuotePage({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final TextEditingController quoteController = TextEditingController();
// //     final TextEditingController bookNameController = TextEditingController();
// //     final TextEditingController authorNameController = TextEditingController();

// //     return Scaffold(
// //       backgroundColor: AppColors.background,
// //       body: SafeArea(
// //         child: Directionality(
// //           textDirection: TextDirection.rtl,
// //           child: Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 15),
// //             child: Column(
// //               children: [
// //                 const Gap(15),
              
// //                  Row(
// //                   children: [
// //                     FloatingActionButton.small(
// //                       backgroundColor: Colors.white,
// //                       onPressed: () {
// //                         Navigator.pushReplacement(
// //                           context,
// //                           MaterialPageRoute(builder: (context) => const MainNavigationPage()),
// //                         );
// //                       },
// //                       child: const Icon(Icons.arrow_back, color: AppColors.primary),
// //                     ),
// //                     const Spacer(),
// //                     const Text(
// //                       "إضافة اقتباس",
// //                       style: TextStyle(
// //                         fontSize: 22,
// //                         fontWeight: FontWeight.bold,
// //                         color: AppColors.primary,
// //                       ),
// //                     ),
// //                      Spacer(flex: 2),
// //                   ],
// //                 ),
// //                 const Gap(24),

// //                 Container(
// //                   width: 370,
// //                   height: 144,
// //                   padding: const EdgeInsets.all(12),
// //                   decoration: BoxDecoration(
// //                     color: AppColors.textSecondaryC,
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                   child: TextFormField(
// //                     controller: quoteController,
// //                     maxLines: null,
// //                     expands: true,
// //                     textAlign: TextAlign.right,
// //                     decoration: const InputDecoration(
// //                       hintText: "اقتباس...",
// //                       border: InputBorder.none,
// //                     ),
// //                   ),
// //                 ),
// //                 const Gap(20),

          
// //                 Container( padding: const EdgeInsets.all(12),
// //                   width: 370,
// //                   height: 55,    decoration: BoxDecoration(
// //                     color: AppColors.textSecondaryC,
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                   child:  TextFormField(
// //                     controller: bookNameController,
// //                     maxLines: null,
// //                     expands: true,
// //                     textAlign: TextAlign.right,
// //                     decoration: const InputDecoration(
// //                       hintText: "اسم الكتاب",
// //                       border: InputBorder.none,
// //                     ),
// //                   ),
// //                 ),
// //                 const Gap(12),

// //                  Container( padding: const EdgeInsets.all(12),
// //                   width: 370,
// //                   height: 55,    decoration: BoxDecoration(
// //                     color: AppColors.textSecondaryC,
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                   child:  TextFormField(
// //                     controller: authorNameController,
// //                     maxLines: null,
// //                     expands: true,
// //                     textAlign: TextAlign.right,
// //                     decoration: const InputDecoration(
// //                       hintText: "اسم الكاتب",
// //                       border: InputBorder.none,
// //                     ),
// //                   ),
// //                 ),
// //                 const Gap(80),

// //                 AppButton(
// //                   text: "نشر الاقتباس",
// //                   onTap: () {
// //                     final quote = quoteController.text.trim();
// //                     final book = bookNameController.text.trim();
// //                     final author = authorNameController.text.trim();

// //                     if (quote.isNotEmpty &&
// //                         book.isNotEmpty &&
// //                         author.isNotEmpty) {
                  
// //                       print("اقتباس: $quote");
// //                       print("الكتاب: $book");
// //                       print("الكاتب: $author");

// //                       ScaffoldMessenger.of(context).showSnackBar(
// //                         const SnackBar(content: Text("تم نشر الاقتباس بنجاح")),
// //                       );

// //                        Navigator.push(
// //                     context,
// //                     MaterialPageRoute(builder: (context) => MainNavigationPage()),
// //                   );;
// //                     } else {
// //                       ScaffoldMessenger.of(context).showSnackBar(
// //                         const SnackBar(content: Text("يرجى تعبئة جميع الحقول")),
// //                       );
// //                     }
// //                   },
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }





// import 'package:dar_nashr/services/qoute_service.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:dar_nashr/core/resources/color.dart';
// import 'package:dar_nashr/core/widget/app_button.dart';
// import 'package:dar_nashr/pages/homepages/navigation_bar.dart';


// class AddQuotePage extends StatefulWidget {
//   const AddQuotePage({super.key});

//   @override
//   State<AddQuotePage> createState() => _AddQuotePageState();
// }

// class _AddQuotePageState extends State<AddQuotePage> {
//   final TextEditingController quoteController = TextEditingController();
//   final TextEditingController bookNameController = TextEditingController();
//   final TextEditingController authorNameController = TextEditingController();

//   final QuoteService _quoteService = QuoteService();
//   bool _loading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: SafeArea(
//         child: Directionality(
//           textDirection: TextDirection.rtl,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15),
//             child: Column(
//               children: [
//                 const Gap(15),
//                 Row(
//                   children: [
//                     FloatingActionButton.small(
//                       backgroundColor: Colors.white,
//                       onPressed: () {
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(builder: (context) => const MainNavigationPage()),
//                         );
//                       },
//                       child: const Icon(Icons.arrow_back, color: AppColors.primary),
//                     ),
//                     const Spacer(),
//                     const Text(
//                       "إضافة اقتباس",
//                       style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.primary,
//                       ),
//                     ),
//                     const Spacer(flex: 2),
//                   ],
//                 ),
//                 const Gap(24),

//                 // حقل الاقتباس
//                 Container(
//                   width: 370,
//                   height: 144,
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: AppColors.textSecondaryC,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: TextFormField(
//                     controller: quoteController,
//                     maxLines: null,
//                     expands: true,
//                     textAlign: TextAlign.right,
//                     decoration: const InputDecoration(
//                       hintText: "اقتباس...",
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//                 const Gap(20),

//                 // اسم الكتاب
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   width: 370,
//                   height: 55,
//                   decoration: BoxDecoration(
//                     color: AppColors.textSecondaryC,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: TextFormField(
//                     controller: bookNameController,
//                     textAlign: TextAlign.right,
//                     decoration: const InputDecoration(
//                       hintText: "اسم الكتاب",
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//                 const Gap(12),

//                 // اسم الكاتب (لسه غير مربوط بالباك)
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   width: 370,
//                   height: 55,
//                   decoration: BoxDecoration(
//                     color: AppColors.textSecondaryC,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: TextFormField(
//                     controller: authorNameController,
//                     textAlign: TextAlign.right,
//                     decoration: const InputDecoration(
//                       hintText: "اسم الكاتب",
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//                 const Gap(80),

//                 _loading
//                     ? const CircularProgressIndicator()
//                     : AppButton(
//                         text: "نشر الاقتباس",
//                         onTap: () async {
//                           final quote = quoteController.text.trim();
//                           final book = bookNameController.text.trim();

//                           if (quote.isEmpty || book.isEmpty) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(content: Text("يرجى تعبئة جميع الحقول")),
//                             );
//                             return;
//                           }

//                           setState(() => _loading = true);

//                           try {
//                             await _quoteService.addQuote(text: quote, bookName: book);
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(content: Text("تم نشر الاقتباس بنجاح")),
//                             );
//                             Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(builder: (context) => const MainNavigationPage()),
//                             );
//                           } catch (e) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text(e.toString())),
//                             );
//                           } finally {
//                             setState(() => _loading = false);
//                           }
//                         },
//                       ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




//===============================================================


// import 'package:dar_nashr/services/qoute_service.dart';
// import 'package:flutter/material.dart';
// import 'package:dar_nashr/core/resources/color.dart';
// import 'package:dar_nashr/core/widget/app_button.dart';
// import 'package:dar_nashr/pages/homepages/navigation_bar.dart';

// import 'package:gap/gap.dart';

// class AddQuotePage extends StatefulWidget {
//   const AddQuotePage({super.key});

//   @override
//   State<AddQuotePage> createState() => _AddQuotePageState();
// }

// class _AddQuotePageState extends State<AddQuotePage> {
//   final TextEditingController quoteController = TextEditingController();
//   final TextEditingController bookNameController = TextEditingController();
//   final TextEditingController authorNameController = TextEditingController();

//   final QuoteService _quoteService = QuoteService();
//   bool _loading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: SafeArea(
//         child: Directionality(
//           textDirection: TextDirection.rtl,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15),
//             child: Column(
//               children: [
//                 const Gap(15),
//                 Row(
//                   children: [
//                     FloatingActionButton.small(
//                       backgroundColor: Colors.white,
//                       onPressed: () {
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(builder: (context) => const MainNavigationPage()),
//                         );
//                       },
//                       child: const Icon(Icons.arrow_back, color: AppColors.primary),
//                     ),
//                     const Spacer(),
//                     const Text(
//                       "إضافة اقتباس",
//                       style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.primary,
//                       ),
//                     ),
//                     const Spacer(flex: 2),
//                   ],
//                 ),
//                 const Gap(24),

//                 // حقل الاقتباس
//                 _buildInputField(controller: quoteController, hint: "اقتباس...", maxLines: 5),

//                 const Gap(20),

//                 _buildInputField(controller: bookNameController, hint: "اسم الكتاب"),
//                 const Gap(12),

//                 _buildInputField(controller: authorNameController, hint: "اسم الكاتب"),

//                 const Gap(80),

//                 _loading
//                     ? const CircularProgressIndicator()
//                     : AppButton(
//                         text: "نشر الاقتباس",
//                         onTap: () async {
//                           final quote = quoteController.text.trim();
//                           final book = bookNameController.text.trim();
//                           final author = authorNameController.text.trim();

//                           if (quote.isEmpty || book.isEmpty) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(content: Text("يرجى تعبئة جميع الحقول")),
//                             );
//                             return;
//                           }

//                           setState(() => _loading = true);

//                           try {
//                             await _quoteService.addQuote(
//                               text: quote,
//                               bookName: book,
//                               authorName: author.isEmpty ? null : author,
//                             );
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(content: Text("تم نشر الاقتباس بنجاح")),
//                             );
//                             Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(builder: (context) => const MainNavigationPage()),
//                             );
//                           } catch (e) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text(e.toString())),
//                             );
//                           } finally {
//                             setState(() => _loading = false);
//                           }
//                         },
//                       ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInputField({required TextEditingController controller, required String hint, int maxLines = 1}) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: AppColors.textSecondaryC,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: TextFormField(
//         controller: controller,
//         maxLines: maxLines,
//         textAlign: TextAlign.right,
//         decoration: InputDecoration(
//           hintText: hint,
//           border: InputBorder.none,
//         ),
//       ),
//     );
//   }
// }





import 'package:dar_nashr/core/widget/app_button.dart';
import 'package:dar_nashr/pages/homepages/navigation_bar.dart';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:dar_nashr/core/resources/color.dart';
import 'package:dar_nashr/services/qoute_service.dart';
import 'package:dar_nashr/core/widget/app_button.dart';
import 'package:dar_nashr/pages/homepages/navigation_bar.dart';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:dar_nashr/core/resources/color.dart';
import 'package:dar_nashr/services/qoute_service.dart';

class AddQuotePage extends StatefulWidget {
  const AddQuotePage({super.key});

  @override
  State<AddQuotePage> createState() => _AddQuotePageState();
}

class _AddQuotePageState extends State<AddQuotePage> {
  final TextEditingController quoteController = TextEditingController();
  final TextEditingController bookNameController = TextEditingController();
  //final TextEditingController authorNameController = TextEditingController();

  final QuoteService _quoteService = QuoteService();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const Gap(15),
                Row(
                  children: [
                    FloatingActionButton.small(
                      backgroundColor: Colors.white,
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Icon(Icons.arrow_back, color: AppColors.primary),
                    ),
                    const Spacer(),
                    const Text(
                      "إضافة اقتباس",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
                const Gap(24),

                _buildInputField(controller: quoteController, hint: "اقتباس...", maxLines: 5),
                const Gap(20),
                _buildInputField(controller: bookNameController, hint: "اسم الكتاب"),
                const Gap(12),
               // _buildInputField(controller: authorNameController, hint: "اسم الكاتب"),
                const Gap(80),

                _loading
                    ? const CircularProgressIndicator()
                    : AppButton(
                        text: "نشر الاقتباس",
                        onTap: () async {
                          final quote = quoteController.text.trim();
                          final book = bookNameController.text.trim();
                       //  final author = authorNameController.text.trim();

                          if (quote.isEmpty || book.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("يرجى تعبئة جميع الحقول")),
                            );
                            return;
                          }

                          setState(() => _loading = true);

                          try {
                            await _quoteService.addQuote(
                              text: quote,
                              bookName: book,
                            //  authorName: author.isEmpty ? null : author,
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("تم نشر الاقتباس بنجاح")),
                            );

                            Navigator.pop(context, true); // تحديث الواجهة الرئيسية
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("فشل في نشر الاقتباس: $e")),
                            );
                          } finally {
                            setState(() => _loading = false);
                          }
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.textSecondaryC,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
