import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/stock_counting_batch.dart';
import 'package:msi_app/models/stock_counting_item.dart';
import 'package:msi_app/providers/stock_counting_item_provider.dart';
import 'package:msi_app/screens/stock_counting_bin/stock_counting_bin_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';
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
        suffixIcon: Icon(Icons.local_see),
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

  Widget buildButtonSubmit(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        child: Text('Submit'),
        onPressed: () {
          // if (double.parse(_quantity.text) > widget.item.openQty) {

          //   print('Tidak boleh lebih besar dari Available Qty ');
          //   return;
          // }
          final itemPoProvider =
              Provider.of<StockCountingItemProvider>(context, listen: false);
          String dateString =
              DateFormat().addPattern('dd/MM/yy').format(_selectedDate);
          itemPoProvider.addBatchQtyBatchDate(
            item,
            StockCountingBatch(
              batchNo: _batchNumber.text.isEmpty
                  ? "BatchNo-$dateString"
                  : _batchNumber.text,
              expiredDate: _selectedDate,
              availableQty: double.parse(_quantity.text),
            ),
          );
          Navigator.of(context)
              .pushNamed(StockCountingBinScreen.routeName, arguments: item);
          //  Navigator.of(context).pop();
        },
      ),
    );
  }
}
