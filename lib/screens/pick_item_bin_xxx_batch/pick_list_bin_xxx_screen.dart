// import 'package:flutter/material.dart';
// import 'package:msi_app/providers/pick_item_receive_provider.dart';
// import 'package:msi_app/providers/pick_list_whs_provider.dart';
// import 'package:msi_app/utils/constants.dart';
// import 'package:msi_app/utils/size_config.dart';
// import 'package:msi_app/widgets/base_text_line.dart';
// import 'package:msi_app/widgets/base_title.dart';
// import 'package:provider/provider.dart';

// class PickListBinXxxScreen extends StatelessWidget {
//   static const routeName = '/pick_list_bin_xxx';

//   Future<void> refreshData(BuildContext context, String pickNumber) async {
//     final pickItemProvider =
//         Provider.of<PickItemReceiveProvider>(context, listen: false);
//     await pickItemProvider.getPlActionByPlNo(pickNumber);

//     final pickWhsProvider =
//         Provider.of<PickListWhsProvider>(context, listen: false);
//     pickWhsProvider.selected.pickItemList = pickItemProvider.items;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final item =
//         Provider.of<PickListWhsProvider>(context, listen: false).selected;
//     // final authProvider = Provider.of<AuthProvider>(context, listen: false);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Picker Pick List'),
//         actions: [
//           // IconButton(
//           //   icon: Icon(Icons.post_add),
//           //   onPressed: () {
//           //     authProvider.clearBin();
//           //     Navigator.of(context).pushNamed(PickCheckScreen.routeName);
//           //   },
//           // )
//         ],
//       ),
//       body: Container(
//         padding: const EdgeInsets.symmetric(
//           vertical: kLarge,
//           horizontal: kMedium,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             BaseTextLine('Doc Number', item.pickNumber),
//             SizedBox(height: getProportionateScreenHeight(kLarge)),
//             BaseTextLine('Pick Date', convertDate(item.pickDate)),
//             SizedBox(height: getProportionateScreenHeight(kLarge)),
//             BaseTextLine('Remarks', item.pickRemark),
//             SizedBox(height: getProportionateScreenHeight(kLarge)),
           
//             SizedBox(height: getProportionateScreenHeight(kLarge)),
//             BaseTitle('List Items'),
//             Divider(),
//           ],
//         ),
//       ),
//     );
//   }

  
// }
