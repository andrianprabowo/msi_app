// import 'package:flutter/material.dart';
// import 'package:msi_app/models/pick_item_receive.dart';
// import 'package:msi_app/models/pick_list_bin.dart';
// import 'package:msi_app/providers/pick_item_receive_provider.dart';
// import 'package:msi_app/screens/pick_item_receive/pick_item_receive_screen.dart';
// import 'package:msi_app/utils/constants.dart';
// import 'package:msi_app/utils/size_config.dart';
// import 'package:msi_app/widgets/base_title.dart';
// import 'package:msi_app/widgets/base_title_color.dart';
// import 'package:provider/provider.dart';

// class DialogPickBinNonbatch extends StatefulWidget {
//   final PickItemReceive item;
//   final PickListBin items;

//   const DialogPickBinNonbatch(this.item,this.items);

//   @override
//   _DialogPickBinNonbatchState createState() => _DialogPickBinNonbatchState();
// }

// class _DialogPickBinNonbatchState extends State<DialogPickBinNonbatch> {
//   final _quantity = TextEditingController();

//   PickItemReceive get item {
//     return widget.item;
//   }

//  PickListBin get items {
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
//           final pickItemReceiveProvider =
//               Provider.of<PickItemReceiveProvider>(context, listen: false);
//               // pickItemProvider.addBinList(pickItemReceive, binList);
//           // pickItemReceive.itemStorageLocation = item.binLocation;
// // final pickBinProvider =
// //         Provider.of<PickListBinProvider>(context, listen: false);
//           // pickItemReceive.itemStorageLocation = item.binLocation;
//               // final binList = pickBinProvider.items;

             

//           pickItemReceiveProvider.inputQtyNonBatch(
//             item,
//             double.parse(_quantity.text),
//           );

//           pickItemReceiveProvider.addBin(
//             item,
//             PickListBin(
//               binLocation: items.binLocation,
//               pickBinQty: double.parse(_quantity.text),
//               batchList: items.batchList
//             )
            
//           );



//       //  pickItemReceiveProvider.addBinList(item, binList);
//           Navigator.of(context)
//               .popUntil(ModalRoute.withName(PickItemReceiveScreen.routeName));

//           //     .pushNamed(PickItemReceiveScreen.routeName, arguments: item);
//           //  Navigator.of(context).pop();
//         },
//       ),
//     );
//   }
// }
