// import 'package:flutter/material.dart';
// import 'package:msi_app/models/pick_item_receive_rtv.dart';
// import 'package:msi_app/models/pick_list_bin_rtv.dart';
// import 'package:msi_app/providers/pick_batch_rtv_provider.dart';
// import 'package:msi_app/providers/pick_item_receive_rtv_provider.dart';
// import 'package:msi_app/screens/pick_item_receive_rtv/pick_item_receive_rtv_screen.dart';
// import 'package:msi_app/utils/constants.dart';
// import 'package:msi_app/utils/size_config.dart';
// import 'package:msi_app/widgets/base_title.dart';
// import 'package:msi_app/widgets/base_title_color.dart';
// import 'package:provider/provider.dart';

// class DialogPickBinRtvNonbatch extends StatefulWidget {
//   final PickItemReceiveRtv item;
//   final PickListBinRtv items;

//   const DialogPickBinRtvNonbatch(this.item,this.items);

//   @override
//   _DialogPickBinRtvNonbatchState createState() => _DialogPickBinRtvNonbatchState();
// }

// class _DialogPickBinRtvNonbatchState extends State<DialogPickBinRtvNonbatch> {
//   final _quantity = TextEditingController();

//   PickItemReceiveRtv get item {
//     return widget.item;
//   }

//  PickListBinRtv get items {
//     return widget.items;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(kLarge),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           BaseTitle(item.itemCode),
//           SizedBox(height: getProportionateScreenHeight(kLarge)),
//           BaseTitle(item.description),
//           SizedBox(height: getProportionateScreenHeight(kLarge)),
//           // BaseTextLine(
//               // 'Available Quantity', widget.item.openQty.toStringAsFixed(4)),
//           SizedBox(height: getProportionateScreenHeight(kLarge)),
//           buildQtyFormField(),
//           SizedBox(height: getProportionateScreenHeight(kLarge)),
//           buildButtonSubmit(context, widget.item.openQty.toStringAsFixed(4)),
//         ],
//       ),
//     );
//   }

//   Widget buildButtonNotif(BuildContext context, String avlQty) {
//     return SizedBox(
//       width: double.infinity,
//       child: RaisedButton(
//         color: Colors.red,
//         child: Text('Qty must be above 0 or equal to ' + avlQty),
//         onPressed: () {},
//       ),
//     );
//   }

//   Widget buildQtyFormField() {
//     return SizedBox(
//       width: getProportionateScreenWidth(280),
//       child: TextFormField(
//         keyboardType: TextInputType.number,
//         controller: _quantity,
//         decoration: InputDecoration(
//           floatingLabelBehavior: FloatingLabelBehavior.always,
//           labelText: 'Quantity',
//           hintText: 'Input Quantity',
//         ),
//         autofocus: true,
//       ),
//     );
//   }

//   Widget buildButtonSubmit(BuildContext context, String avlQty) {
//     return SizedBox(
//       width: double.infinity,
//       child: RaisedButton(
//         child: Text('Submit'),
//         onPressed: () {
//           if (double.parse(_quantity.text) > widget.item.openQty) {
//             print('Tidak boleh lebih besar dari Available Qty ');
//             return showDialog<void>(
//               context: context,
//               barrierDismissible: false,
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                   content: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(Icons.notification_important,
//                           color: Colors.red, size: 50),
//                       Divider(),
//                       SizedBox(height: getProportionateScreenHeight(kLarge)),
//                       BaseTitleColor('Qty must be above 0'),
//                       SizedBox(height: getProportionateScreenHeight(kLarge)),
//                       BaseTitleColor('or equal to  $avlQty'),
//                       SizedBox(height: getProportionateScreenHeight(kLarge)),
//                       SizedBox(
//                         width: double.infinity,
//                         child: RaisedButton(
//                           child: Text('OK'),
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           }
//           final pickBatchProv =
//               Provider.of<PickBatchRtvProvider>(context, listen: false);
//               final pickItemProv =
//               Provider.of<PickItemReceiveRtvProvider>(context, listen: false);
           
//           // update bin location
//               item.itemStorageLocation = items.binLocation;

//               // add batch list
//               final batchList = pickBatchProv.pickedItems;
//               // batchList.first.bin = pickItem.itemStorageLocation;  //done
//               batchList.forEach((detail) {
//                 // calculate remaining qty
//                 detail.bin = item.itemStorageLocation;
//               });
//               // batchList. = itemBin.binLocation;
//               pickItemProv.addBin(item, batchList);



//       //  pickItemReceiveProvider.addBinList(item, binList);
//           Navigator.of(context)
//               .popUntil(ModalRoute.withName(PickItemReceiveRtvScreen.routeName));

//           //     .pushNamed(PickItemReceiveScreen.routeName, arguments: item);
//           //  Navigator.of(context).pop();
//         },
//       ),
//     );
//   }
// }
