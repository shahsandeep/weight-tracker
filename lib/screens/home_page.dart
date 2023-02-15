import 'package:firestore_weight_tracker/constants/routes.dart';
import 'package:firestore_weight_tracker/enums/enum.dart';
import 'package:firestore_weight_tracker/helper/bottom_model_sheet.dart';
import 'package:firestore_weight_tracker/helper/conver_date.dart';
import 'package:firestore_weight_tracker/helper/delete_dialog.dart';

import 'package:firestore_weight_tracker/models/weight_model.dart';
import 'package:firestore_weight_tracker/view_model/login_provider.dart';
import 'package:firestore_weight_tracker/view_model/weight_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late WeightProvider _weightProvider;

  @override
  void initState() {
    super.initState();
    _weightProvider = Provider.of<WeightProvider>(
      context,
      listen: false,
    );

    _weightProvider.getWeightList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weight Tracker'),
        actions: [
          Consumer<LoginProvider>(builder: (context, data, widget) {
            if (data.loadingStatus == LoadingStatus.loading) {
              return const CircularProgressIndicator();
            }
            return ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
              ),
              onPressed: () async {
                var response = await data.logout();
                if (response) {
                  if (mounted) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, loginRoute, (route) => false);
                  }
                }
              },
              child: const Text(
                'Logout',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            );
          })
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showBottomModelSheet(context);
          },
          child: const Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Consumer<WeightProvider>(builder: (context, data, widget) {
            if (data.weigthList.isEmpty) {
              return const Center(
                child: Text("Not Found Please Add"),
              );
            }
            return ListView.builder(
                itemCount: data.weigthList.length,
                itemBuilder: (context, index) {
                  WeightModel item = data.weigthList[index];

                  return Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: Text(
                          item.weight.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text(
                          converDate(item.dateTime),
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        trailing:
                            Row(mainAxisSize: MainAxisSize.min, children: [
                          IconButton(
                              onPressed: () {
                                showBottomModelSheet(context, data: item);
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                deleteDialog(context, item.id);
                              },
                              icon: const Icon(Icons.delete)),
                        ]),
                      ),
                    ],
                  );
                });
          }),
        ),
      ),
    );
  }
}
