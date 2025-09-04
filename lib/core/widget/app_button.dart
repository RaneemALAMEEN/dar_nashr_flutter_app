// import 'package:dar_nashr/core/resources/color.dart';
// import 'package:flutter/material.dart';

// class MyButton extends StatelessWidget {
//   const MyButton({
//     Key? key,
//     this.onTap,
//     required this.text,
//     required Null Function() onPressed,
//   }) : super(key: key);
//   final String text;
//   final VoidCallback? onTap;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.primary,
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       width: 350,
//       height: 50,
//       child: FilledButton(
//         style: ButtonStyle(
//             backgroundColor: MaterialStateProperty.all<Color>(
//               AppColors.primary,
//             ),
//             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                 RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ))),
//         onPressed: () {},
//         child: Center(
//             child: Text(
//           text,
//           style: TextStyle(
//             fontWeight: FontWeight.w700,
//             fontSize: 16,
//           ),
//         )),
//       ),
//     );
//   }
// }



import 'package:dar_nashr/core/resources/color.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.onTap,
    required this.text, 
  }) : super(key: key);

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12.0),
      ),
      width: 350,
      height: 50,
      child: FilledButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            AppColors.primary,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onPressed: onTap, // هون الأساس!
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
