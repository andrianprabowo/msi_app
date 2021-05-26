import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_receipt_item_batch_model.dart';
import 'package:msi_app/models/production_receipt_item_model.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/production_receipt_item_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/base_title_color.dart';
import 'package:provider/provider.dart';

class ProductionReceiptItemQtyDialog extends StatefulWidget {
  final ProductionReceiptItemModel item;

  const ProductionReceiptItemQtyDialog(this.item);

  @override
  _ProductionReceiptItemQtyDialogState createState() =>
      _ProductionReceiptItemQtyDialogState();
}

class _ProductionReceiptItemQtyDialogState
    extends State<ProductionReceiptItemQtyDialog> {
  final _batchNumber = TextEditingController();
  final _quantity = TextEditingController();
  final _quantityReject = TextEditingController();
  var itemxx = 1;
  var helpDate = 1;
  DateTime _selectedDate = DateTime.now();

  ProductionReceiptItemModel get item {
    return widget.item;
  }

  @override
  Widget build(BuildContext context) {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);
   
    final formatter =
        NumberFormat(('#,###.' + authProvider.decString), 'en_US');
    var openQty = widget.item.openQty == 0.0
        ? widget.item.openQty.toStringAsFixed(authProvider.decLen)
        : formatter.format(widget.item.openQty);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(kLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseTitle('Batch Number / Exp Date'),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          BaseTextLine('PO Quantity', openQty),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          buildInput(),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          buildQtyFormField(),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          buildQtyRejectFormField(),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          buildDatePicker(context),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          //buildButtonSubmit(context),
          // if (((_quantity.text != '' || _quantityReject.text != '') ||
          //         (_quantity.text == '0' || _quantity.text == '0.0') ||
          //         (_quantityReject.text == '0' ||
          //             _quantityReject.text == '0.0')) &&
          //     (((_quantity.text.isEmpty
          //                 ? double.parse('0')
          //                 : double.parse(_quantity.text)) +
          //             (_quantityReject.text.isEmpty
          //                 ? double.parse('0')
          //                 : double.parse(_quantityReject.text))) >
          //         double.tryParse(widget.item.openQty.toStringAsFixed(4))))
          //   buildButtonNotif(context, openQty)
          // else
          buildButtonSubmit(context, openQty)
        ],
      ),
    );
  }

  Widget buildInput() {
    return TextFormField(
      controller: _batchNumber,
      textInputAction: TextInputAction.next,
      autofocus: true,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'Batch Number',
        hintText: 'Input or Scan Batch Number',
        suffixIcon: Icon(Icons.search),
      ),
    );
  }

  Widget buildDatePicker(context) {
    var initial =
        DateTime.now().add(new Duration(days: widget.item.defDayExpired));
    return Row(
      children: [
              if (helpDate == 5 )
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(kLarge),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: kTiny,
                    style: BorderStyle.solid,
                    color: kPrimaryColor,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(kMedium),
                  ),
                ),
              ),
              // child: Text(convertDate(initial)),

              child: Text(
                  DateFormat().addPattern('dd/MM/yyyy').format(_selectedDate)),

              // child: Text(convertDate(_selectedDate)),
            ),
          ),
                if (helpDate == 1 )
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(kLarge),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: kTiny,
                    style: BorderStyle.solid,
                    color: kPrimaryColor,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(kMedium),
                  ),
                ),
              ),
              // child: Text(convertDate(initial)),

              child: Text(
                  DateFormat().addPattern('dd/MM/yyyy').format(initial)),

              // child: Text(convertDate(_selectedDate)),
            ),
          ),
        IconButton(
          icon: Icon(Icons.event),
          onPressed: () async {
            // final maxYear = DateTime.now().year + 5;
            // print('initital $initial');
            // print('hari ${widget.item.defDayExpired}');
            // final pickedDate = await showDatePicker(
            //   context: context,
            //   // initialDate: DateTime.now(),
            //   initialDate: initial,
            //   firstDate: DateTime.now(),
            //   lastDate: DateTime(maxYear),
            itemxx = 2;
            final init = DateTime.now()
                .add(new Duration(days: widget.item.defDayExpired));

            print(" ini xxx  $itemxx");

            print(" date initial $initial");

            final maxYear = init.year + 5;
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: init,
              firstDate: DateTime.now(),
              lastDate: DateTime(maxYear),
            );

            print(" 2 date picked $pickedDate");
            if (pickedDate == null) {
             
              return;
            }
            setState(() {
              _selectedDate = pickedDate;
              initial = _selectedDate;
               helpDate = 5;
            });
            print("3 date select ${item.xxxx.toString()}");
            print("3 date initial $initial");
          },
        ),
  
      ],
    );
  }

  Widget buildQtyFormField() {
    return SizedBox(
      width: getProportionateScreenWidth(280),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: _quantity,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: 'Complete Quantity',
          hintText: 'Input Quantity',
        ),
      ),
    );
  }

  Widget buildQtyRejectFormField() {
    return SizedBox(
      width: getProportionateScreenWidth(280),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: _quantityReject,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: 'Reject Quantity',
          hintText: 'Input Reject Quantity',
        ),
      ),
    );
  }

  Widget buildButtonSubmit(BuildContext context, String avlQty) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        child: Text('Submit'),
        onPressed: () {
          // if (((_quantity.text != '' || _quantityReject.text != '') ||
          //         (_quantity.text == '0' || _quantity.text == '0.0') ||
          //         (_quantityReject.text == '0' ||
          //             _quantityReject.text == '0.0')) &&
          //     (((_quantity.text.isEmpty
          //                 ? double.parse('0')
          //                 : double.parse(_quantity.text)) +
          //             (_quantityReject.text.isEmpty
          //                 ? double.parse('0')
          //                 : double.parse(_quantityReject.text))) >
          //         double.tryParse(widget.item.openQty.toStringAsFixed(4)))) {
          //   print('Tidak boleh lebih besar darig Available Qty ');
          //   return showDialog<void>(
          //     context: context,
          //     barrierDismissible: false,
          //     builder: (BuildContext context) {
          //       return AlertDialog(
          //         content: Column(
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             Icon(Icons.notification_important,
          //                 color: Colors.red, size: 50),
          //             Divider(),
          //             SizedBox(height: getProportionateScreenHeight(kLarge)),
          //             BaseTitleColor('Total Qty must be above 0'),
          //             SizedBox(height: getProportionateScreenHeight(kLarge)),
          //             BaseTitleColor('or equal to  $avlQty'),
          //             SizedBox(height: getProportionateScreenHeight(kLarge)),
          //             SizedBox(
          //               width: double.infinity,
          //               child: RaisedButton(
          //                 child: Text('OK'),
          //                 onPressed: () {
          //                   Navigator.of(context).pop();
          //                 },
          //               ),
          //             ),
          //           ],
          //         ),
          //       );
          //     },
          //   );
          // }
          if (_quantityReject.text == '') {
            print('Tidak boleh lebih besar darig Available Qty ');
            return showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.notification_important,
                          color: Colors.red, size: 50),
                      Divider(),
                      SizedBox(height: getProportionateScreenHeight(kLarge)),
                      BaseTitleColor('Please Input All Qty'),
                      SizedBox(height: getProportionateScreenHeight(kLarge)),
                      SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            final itemPoProvider = Provider.of<ProductionReceiptItemProvider>(
                context,
                listen: false);
            final date = new DateTime.now();
            String dateString =
                DateFormat().addPattern('yyyy/MM/dd').format(date);
            if (_batchNumber.text.isEmpty) {
              if (itemxx == 1) {
                _selectedDate = DateTime.now()
                    .add(new Duration(days: widget.item.defDayExpired));
                print("ini number null xxx $_selectedDate");
              }

              return showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.notification_important,
                            color: Colors.red, size: 50),
                        Divider(),
                        SizedBox(height: getProportionateScreenHeight(kLarge)),
                        BaseTitleColor('Please input batch number'),
                        BaseTitleColor('or automatically filled with'),
                        SizedBox(height: getProportionateScreenHeight(kLarge)),
                        BaseTitle('BatchNo-$dateString'),
                        SizedBox(height: getProportionateScreenHeight(kLarge)),
                        SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            child: Text('OK'),
                            onPressed: () {
                              itemPoProvider.addBatch(
                                item,
                                ProductionReceiptItemBatchModel(
                                  batchNo: _batchNumber.text.isEmpty
                                      ? "BatchNo-$dateString"
                                      : _batchNumber.text,
                                  expiredDate: _selectedDate,
                                  availableQty: double.parse(_quantity.text),
                                  rejectQty: double.parse(_quantityReject.text),
                                ),
                              );
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }

            if (itemxx == 1) {
              _selectedDate = DateTime.now()
                  .add(new Duration(days: widget.item.defDayExpired));

              print("ini xxx $_selectedDate");
            }
            itemPoProvider.addBatch(
              item,
              ProductionReceiptItemBatchModel(
                batchNo: _batchNumber.text.isEmpty
                    ? "BatchNo-$dateString"
                    : _batchNumber.text,
                expiredDate: _selectedDate,
                availableQty: double.parse(_quantity.text),
                rejectQty: double.parse(_quantityReject.text),
              ),
            );
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }

  Widget buildButtonNotif(BuildContext context, String avlQty) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.red,
        child: Text('Qty must be above 0 or equal to ' + avlQty),
        onPressed: () {},
      ),
    );
  }
}
