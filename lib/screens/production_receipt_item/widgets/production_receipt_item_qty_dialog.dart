import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_receipt_item_batch_model.dart';
import 'package:msi_app/models/production_receipt_item_model.dart';
import 'package:msi_app/providers/production_receipt_item_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
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
  DateTime _selectedDate = DateTime.now();

  ProductionReceiptItemModel get item {
    return widget.item;
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###.0000#', 'en_US');
    var openQty = widget.item.openQty == 0.0
        ? widget.item.openQty.toStringAsFixed(4)
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
          if (((_quantity.text != '' || _quantityReject.text != '') ||
                  (_quantity.text == '0' || _quantity.text == '0.0') ||
                  (_quantityReject.text == '0' ||
                      _quantityReject.text == '0.0')) &&
              (((_quantity.text.isEmpty
                          ? double.parse('0')
                          : double.parse(_quantity.text)) +
                      (_quantityReject.text.isEmpty
                          ? double.parse('0')
                          : double.parse(_quantityReject.text))) >
                  double.tryParse(widget.item.openQty.toStringAsFixed(4))))
            buildButtonNotif(context, openQty)
          else
            buildButtonSubmit(context)
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
        suffixIcon: Icon(Icons.local_see),
      ),
    );
  }

  Widget buildDatePicker(context) {
    return Row(
      children: [
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
            child: Text(convertDate(_selectedDate)),
          ),
        ),
        IconButton(
          icon: Icon(Icons.event),
          onPressed: () async {
            final maxYear = DateTime.now().year + 5;
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(maxYear),
            );

            if (pickedDate == null) return;

            setState(() {
              _selectedDate = pickedDate;
            });
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

  Widget buildButtonSubmit(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        child: Text('Submit'),
        onPressed: () {
          final itemPoProvider = Provider.of<ProductionReceiptItemProvider>(
              context,
              listen: false);
          String dateString =
              DateFormat().addPattern('dd/MM/yy').format(_selectedDate);
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