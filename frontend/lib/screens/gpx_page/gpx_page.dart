import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'gpx_controller.dart';

class GpxPage extends StatelessWidget {
  const GpxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GpxController controller = Get.put(GpxController());
    return Scaffold(
      body: Center(
        child: Container(
          child: Text('gpx page'),
        ),
      ),
    );
  }
}
