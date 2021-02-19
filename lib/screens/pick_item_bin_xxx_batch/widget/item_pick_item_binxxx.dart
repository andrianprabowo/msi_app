// import 'package:flutter/material.dart';
// import 'package:msi_app/models/pick_batch.dart';
// import 'package:msi_app/models/pick_item_receive.dart';
// import 'package:msi_app/models/pick_list_bin.dart';
// import 'package:msi_app/screens/pick_item_bin_xxx_batch/widget/widget_batchxxx.dart';
// import 'package:msi_app/utils/constants.dart';

// class ItemPickItemBinXxx extends StatelessWidget {
  
//   final PickItemReceive pickItemReceive;
//   final PickListBin item;

//   const ItemPickItemBinXxx(this.pickItemReceive, this.item);
  

//   @override

//   Widget build(BuildContext context) {
//   // final _quantity = TextEditingController() ;
    
   
//     return InkWell(
//       onTap: () {
        
//       },
//       child: Container(
//         margin: const EdgeInsets.all(kTiny),
//         padding: const EdgeInsets.all(kSmall),
//         decoration: kBoxDecoration,
//         child: Column(
//           children: [
           
//             buildItemBatchList(item.batchList),
           
//           ]
//         ),
//       ),
//     );
//   }
//   Widget buildItemBatchList(List<PickBatch> list) {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemCount: list.length,
//       itemBuilder: (_, index) {
//         return WidgetBatchxxx(pickItemReceive, list[index]);
//       },
//     );
//   }
// }
