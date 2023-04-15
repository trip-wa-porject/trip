import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'api_test_controller.dart';

class ApiTestsPage extends GetView<ApiTestController> {
  const ApiTestsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ApiTestController());
    return Scaffold(
      body: Row(
        children: [
          Flexible(
            flex: 1,
            child: ListView(
              children: [
                FilledButton(
                  onPressed: () {
                    controller.testSearchTrips1();
                  },
                  child: Text('API'),
                ),
                FilledButton(
                  onPressed: () {
                    controller.testSearchTrips2();
                  },
                  child: Text('API'),
                ),
                FilledButton(
                  onPressed: () {
                    controller.testSearchTrip();
                  },
                  child: Text('API'),
                ),
              ],
            ),
          ),
          Flexible(
              flex: 8,
              child: Center(
                child: Text(
                  'response:\n  data',
                ),
              ))
        ],
      ),
    );
  }
}
