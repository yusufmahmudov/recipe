// import 'package:flutter/cupertino.dart';

// class CategoryWidget extends StatefulWidget {
//   const  @override
//   State<CategoryWidget> createState() => _CategoryWidgetState();
// }

// class _CategoryWidgetState extends State<CategoryWidget> {
//  CategoryWidget({
//     super.key,
//     required this.categories,
//     required this.selIndex,
//   });
//   final List<String> categories;

//   final ValueNotifier<int> selIndex;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       scrollDirection: Axis.horizontal,
//       separatorBuilder: (context, index) =>
//           const SizedBox(width: 16),
//       itemCount: categories.length,
//       itemBuilder: (context, index) => GestureDetector(
//         onTap: () => selIndex.value = index,
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           height: 34,
//           decoration: BoxDecoration(
//             color:
//                 value == index ? redOrange : Colors.transparent,
//             border: value == index
//                 ? Border.all(color: redOrange)
//                 : null,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 categories[index],
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w700,
//                   color: value == index ? white : redOrange20,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
