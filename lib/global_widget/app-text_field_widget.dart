import 'package:flutter/material.dart';

class AppTextFieldWidget extends StatelessWidget {
  final String? hint;
  final TextEditingController? textController;

  const AppTextFieldWidget({
    super.key,
    this.hint,
    this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        // filled: true,
      ),
      maxLines: null,
      keyboardType: TextInputType.multiline,
    );
  }
}

// import 'package:flutter/material.dart';
//
// class AppTextFieldWidget extends StatelessWidget {
//   final String? hint;
//   final TextEditingController? textController;
//
//   const AppTextFieldWidget({
//     super.key,
//     this.hint,
//     this.textController,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: textController,
//       decoration: InputDecoration(
//         hintText: hint,
//         hintStyle: TextStyle(fontSize: 16, color: Colors.grey[600]), //
//         filled: true,
//         fillColor: Colors.grey[200],
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Colors.blue, width: 2),
//         ),
//         contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//       ),
//       maxLines: null,
//       keyboardType: TextInputType.multiline,
//     );
//   }
// }
