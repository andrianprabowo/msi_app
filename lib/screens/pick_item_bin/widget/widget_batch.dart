// import 'package:flutter/material.dart';
// import 'package:msi_app/models/pick_batch.dart';
// import 'package:msi_app/models/pick_item_receive.dart';
// import 'package:msi_app/utils/constants.dart';
// import 'package:msi_app/widgets/base_text_line.dart';

// class WidgetBatch extends StatelessWidget {
//   final PickItemReceive pickBin;
//   final PickBatch batch;

//   const WidgetBatch(this.pickBin, this.batch);

//   @override
//   Widget build(BuildContext context) {
//     // final provider =
//     //     Provider.of<PickListBinProvider>(context, listen: false); 
//     //     final pickBatchProvider =
//     //     Provider.of<PickBatchProvider>(context, listen: false);
//     return Container(
//       margin: const EdgeInsets.all(kTiny),
//       padding: const EdgeInsets.all(kSmall),
//       decoration: kBoxDecoration,
//       child: Row(
//         children: [
//           IconButton(
//             icon: Icon(Icons.delete, color: Colors.red),
//             onPressed: () {
              
//             },
//           ),
//           Expanded(
//             child: Column(
//               children: [
//                 BaseTextLine('Expired Date', convertDate(batch.expiredDate)),
//                 BaseTextLine('Quantity', batch.pickQty.toStringAsFixed(4) ??''),
//                 // BaseTextLine('Quantity', "zzz"),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
