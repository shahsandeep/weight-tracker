import 'package:firestore_weight_tracker/enums/enum.dart';
import 'package:firestore_weight_tracker/models/common_response_mode.dart';
import 'package:firestore_weight_tracker/models/weight_model.dart';
import 'package:firestore_weight_tracker/view_model/weight_provider.dart';
import 'package:flutter/Material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

showBottomModelSheet(BuildContext context, {WeightModel? data}) {
  String weight = "";
  if (data != null) {
    weight = (data.weight).toString();
  }
  TextEditingController textEditingController =
      TextEditingController(text: weight);

  late CommonResponse _response;

  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
      ),
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: StatefulBuilder(
              builder: ((BuildContext ct, StateSetter modelState) {
            return SafeArea(
                child: Container(
              height: MediaQuery.of(context).size.height / 2.3,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20),
              child: Consumer<WeightProvider>(
                builder: (context, consumerData, child) {
                  if (consumerData.loadingStatus == LoadingStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Column(children: [
                    TextFormField(
                      onFieldSubmitted: (value) async {
                        if (value.trim().isEmpty) {
                          Fluttertoast.showToast(msg: "Field can't be empty");
                          return;
                        }

                        if (data == null) {
                          _response = await consumerData
                              .addWeight(textEditingController.text.trim());
                        } else {
                          data.weight =
                              double.parse(textEditingController.text.trim());
                          _response = await consumerData.updateWeight(data);
                        }
                        Fluttertoast.showToast(msg: _response.message);
                        if (_response.status == true) {
                          Navigator.pop(context);
                        }
                      },
                      keyboardType: TextInputType.number,
                      controller: textEditingController,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (textEditingController.text.trim().isEmpty) {
                            Fluttertoast.showToast(msg: "Field can't be empty");
                            return;
                          }

                          if (data == null) {
                            _response = await consumerData
                                .addWeight(textEditingController.text.trim());
                          } else {
                            data.weight =
                                double.parse(textEditingController.text.trim());
                            _response = await consumerData.updateWeight(data);
                          }
                          Fluttertoast.showToast(msg: _response.message);
                          if (_response.status == true) {
                            Navigator.pop(context);
                          }
                        },
                        child: Text(data == null ? "Add" : "Update"))
                  ]);
                },
              ),
            ));
          })),
        );
      });
}
