import 'package:firestore_weight_tracker/enums/enum.dart';
import 'package:firestore_weight_tracker/view_model/weight_provider.dart';
import 'package:flutter/Material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

deleteDialog(BuildContext context, String id) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Are you sure wants to delete?"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("No")),
            Consumer<WeightProvider>(builder: (context, data, widget) {
              if (data.loadingStatus == LoadingStatus.loading) {
                return const Center(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return TextButton(
                  onPressed: () async {
                    var response = await data.deleteWeight(id);
                    Fluttertoast.showToast(msg: response.message);
                    if (response.status) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Yes"));
            }),
          ],
        );
      });
}
