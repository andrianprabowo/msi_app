import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/stock_counting_batch.dart';
import 'package:msi_app/models/stock_counting_item.dart';
import 'package:msi_app/providers/stock_counting_batch_provider.dart';
import 'package:msi_app/providers/stock_counting_item_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/base_title_color.dart';
import 'package:provider/provider.dart';

class DialogInputQtyBatch extends StatefulWidget {
  final StockCountingItem item;

  const DialogInputQtyBatch(this.item);

  @override
  _DialogInputQtyBatchState createState() => _DialogInputQtyBatchState();
}

class _DialogInputQtyBatchState extends State<DialogInputQtyBatch> {
  final _batchNumber = TextEditingController();
  final _quantity = TextEditingController();
  // final _uom = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  StockCountingItem get item {
    return widget.item;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(kLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseTitle('Batch Number / Exp Date'),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          buildInput(),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          buildQtyFormField(),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          // buildUomFormField(),
          // SizedBox(height: getProportionateScreenHeight(kLarge)),
          buildDatePicker(context),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          buildButtonSubmit(context),
        ],
      ),
    );
  }

  Widget buildInput() {
    return TextFormField(
      controller: _batchNumber,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'Batch Number',
        hintText: 'Scan /Input Batch Number',
        suffixIcon: Icon(Icons.assessment_outlined),
      ),
      autofocus: true,
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
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: 'Quantity',
          hintText: 'Input Quantity',
        ),
        autofocus: true,
      ),
    );
  }

  // Widget buildUomFormField() {
  //   return SizedBox(
  //     width: getProportionateScreenWidth(280),
  //     child: TextFormField(
  //       keyboardType: TextInputType.number,
  //       controller: _uom,
  //       textInputAction: TextInputAction.done,
  //       decoration: InputDecoration(
  //         floatingLabelBehavior: FloatingLabelBehavior.always,
  //         labelText: 'Uom',
  //         hintText: 'Input Uom',
  //       ),
  //       autofocus: true,
  //     ),
  //   );
  // }

  Widget buildButtonSubmit(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        child: Text('Submit'),
        onPressed: () {
          try {
            double.parse(_quantity.text);
          } catch (error) {
            print('Quantity is required');
            // return;
          }

          // if (double.parse(_quantity.text) > widget.item.openQty) {

          //   print('Tidak boleh lebih besar dari Available Qty ');
          //   return;
          // }

          final provider =
              Provider.of<StockCountingBatchProvider>(context, listen: false);
          final iteMprovider =
              Provider.of<StockCountingItemProvider>(context, listen: false);
          final date = new DateTime.now();
          String dateString =
              DateFormat().addPattern('yyyy/MM/dd').format(date);
          final qty = double.parse(_quantity.text);
          // final uom = _uom.text;
          if (_batchNumber.text.isEmpty) {
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
                            var itemBatch = StockCountingBatch(
                                batchNo: _batchNumber.text.isEmpty
                                    ? "BatchNo-$dateString"
                                    : _batchNumber.text,
                                expiredDate: _selectedDate,
                                flagSo: 0,
                                pickQty: qty,
                                uom: item.unitMsr,
                                availableQty: 0.0);

                            provider.addItemBatch(itemBatch);
                            provider.updatePickQty(itemBatch.batchNo, qty);
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
            // Navigator.of(context).pop();

          }
          var itemBatch = StockCountingBatch(
              batchNo: _batchNumber.text.isEmpty
                  ? "BatchNo-$dateString"
                  : _batchNumber.text,
              expiredDate: _selectedDate,
              pickQty: qty,
              uom: item.unitMsr,
              flagSo: 0,
              availableQty: 0.0);
          provider.addItemBatch(itemBatch);
          provider.updatePickQty(itemBatch.batchNo, qty);
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
