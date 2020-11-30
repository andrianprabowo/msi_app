// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:msi_app/models/item_batch_rfo.dart';
// import 'package:msi_app/models/item_purchase_order_rfo.dart';
// import 'package:msi_app/providers/item_po_provider_rfo.dart';
// import 'package:msi_app/utils/constants.dart';
// import 'package:msi_app/utils/size_config.dart';
// import 'package:msi_app/widgets/base_text_line.dart';
// import 'package:msi_app/widgets/base_title.dart';
// import 'package:provider/provider.dart';

// class DialogInputQtyRfo extends StatefulWidget {
//   final ItemPurchaseOrderRfo item;

//   const DialogInputQtyRfo(this.item);

//   @override
//   _DialogInputQtyRfoState createState() => _DialogInputQtyRfoState();
// }

// class _DialogInputQtyRfoState extends State<DialogInputQtyRfo> {
//   final _batchNumber = TextEditingController();
//   final _quantity = TextEditingController();
//   DateTime _selectedDate = DateTime.now();

//   ItemPurchaseOrderRfo get item {
//     return widget.item;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(kLarge),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           BaseTitle('Batch Number / Exp Date'),
//           SizedBox(height: getProportionateScreenHeight(kLarge)),
//           BaseTextLine('PO Qty', item.openQty.toStringAsFixed(2)),
//           SizedBox(height: getProportionateScreenHeight(kLarge)),
//           buildInput(),
//           SizedBox(height: getProportionateScreenHeight(kLarge)),
//           buildQtyFormField(),
//           SizedBox(height: getProportionateScreenHeight(kLarge)),
//           buildDatePicker(context),
//           SizedBox(height: getProportionateScreenHeight(kLarge)),
//           if (_quantity.text != '' &&
//                   (double.parse(_quantity.text) >
//                       double.tryParse(
//                           widget.item.openQty.toStringAsFixed(2))) ||
//               _quantity.text == '0')
//             buildButtonNotif(context, widget.item.openQty.toString())
//           else
//             buildButtonSubmit(context),
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

//   Widget buildInput() {
//     return TextFormField(
//       controller: _batchNumber,
//       textInputAction: TextInputAction.next,
//       decoration: InputDecoration(
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         labelText: 'Batch Number',
//         hintText: 'Scan /Input Batch Number',
//         suffixIcon: Icon(Icons.local_see),
//       ),
//       autofocus: true,
//     );
//   }

//   Widget buildDatePicker(context) {
//     return Row(
//       children: [
//         Expanded(
//           child: Container(
//             padding: const EdgeInsets.all(kLarge),
//             decoration: ShapeDecoration(
//               shape: RoundedRectangleBorder(
//                 side: BorderSide(
//                   width: kTiny,
//                   style: BorderStyle.solid,
//                   color: kPrimaryColor,
//                 ),
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(kMedium),
//                 ),
//               ),
//             ),
//             child: Text(convertDate(_selectedDate)),
//           ),
//         ),
//         IconButton(
//           icon: Icon(Icons.event),
//           onPressed: () async {
//             final maxYear = DateTime.now().year + 5;
//             final pickedDate = await showDatePicker(
//               context: context,
//               initialDate: DateTime.now(),
//               firstDate: DateTime.now(),
//               lastDate: DateTime(maxYear),
//             );

//             if (pickedDate == null) return;

//             setState(() {
//               _selectedDate = pickedDate;
//             });
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildQtyFormField() {
//     return SizedBox(
//       width: getProportionateScreenWidth(280),
//       child: TextFormField(
//         keyboardType: TextInputType.number,
//         controller: _quantity,
//         textInputAction: TextInputAction.next,
//         decoration: InputDecoration(
//           floatingLabelBehavior: FloatingLabelBehavior.always,
//           labelText: 'Quantity',
//           hintText: 'Input Quantity',
//         ),
//         autofocus: true,
//       ),
//     );
//   }

//   Widget buildButtonSubmit(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: RaisedButton(
//         child: Text('Submit'),
//         onPressed: () {
//           if (double.parse(_quantity.text) > widget.item.openQty) {
//             print('Tidak boleh lebih besar dari Available Qty ');
//             return;
//           }
//           final itemPoProvider =
//               Provider.of<ItemPoRfoProvider>(context, listen: false);
//           String dateString =
//               DateFormat().addPattern('dd/MM/yy').format(_selectedDate);
//           itemPoProvider.addBatch(
//             item,
//             ItemBatchRfo(
//               batchNo: _batchNumber.text.isEmpty
//                   ? "BatchNo-$dateString"
//                   : _batchNumber.text,
//               expiredDate: _selectedDate,
//               availableQty: double.parse(_quantity.text),
//             ),
//           );
//           Navigator.of(context).pop();
//         },
//       ),
//     );
//   }
// }
