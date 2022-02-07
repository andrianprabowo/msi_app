import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/providers/pick_list_whs_provider.dart';
import 'package:provider/provider.dart';

class ItemDatePickList extends StatefulWidget {
  @override
  _ItemDatePickListState createState() => _ItemDatePickListState();
}

class _ItemDatePickListState extends State<ItemDatePickList> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PickListWhsProvider>(context, listen: false);

    var initial = DateTime.now();
    return Row(
      children: [
        Expanded(
          child: Container(
            // padding: const EdgeInsets.all(kLarge),
            // decoration: ShapeDecoration(
            //   shape: RoundedRectangleBorder(
            //     // side: BorderSide(
            //     //   width: kTiny,
            //     //   // style: BorderStyle.solid,
            //     //   color: kPrimaryColor,
            //     // ),
            //     borderRadius: BorderRadius.all(
            //       Radius.circular(kMedium),
            //     ),
            //   ),
            // ),
            // if (pickedDate == null) {

            // }

            child: Text('Posting Date  ' +
                DateFormat().addPattern('dd/MM/yyyy').format(_selectedDate)),
                
          ),
        ),
        IconButton(
          icon: Icon(Icons.event),
          onPressed: () async {
            final init = DateTime.now();
            print(" date initial $initial");

            final maxYear = init.year + 5;
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: init,
              firstDate: DateTime(-1),
              lastDate: DateTime(maxYear),
            );
            print(" 2 date picked $pickedDate");
            if (pickedDate == null) {
              return;
            }
            setState(() {
              _selectedDate = pickedDate;
              initial = _selectedDate;
              provider.selected.postingDate = _selectedDate;
            });
            print("3 date initial $initial");
          },
        ),
      ],
    );
  }
}
