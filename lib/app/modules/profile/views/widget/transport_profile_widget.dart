import 'package:flutter/cupertino.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/modules/profile/views/widget/tranport_widget.dart';
import 'package:get/get.dart';

class ProfileTransportWidget extends StatelessWidget {
  const ProfileTransportWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransportWidget(
          title: AppText.transportRoute.tr,
          value: 'Transport Route 97',
        ),
        TransportWidget(
          title: AppText.transportVehicleNo.tr,
          value: 'Turner Bergnaum',
        ),
        TransportWidget(
          title: AppText.transportDriverName.tr,
          value: 'Turner Bergnaum',
        ),
        TransportWidget(
          title: AppText.transportDriverPhoneNo.tr,
          value: '1234578',
        ),
        // TransportWidget(title: AppText.transportDriverName, value: '1234578',),
        TransportWidget(
          title: AppText.transportDormitory.tr,
          value: 'Sir Isaac Newton Hostel',
        ),
      ],
    );
  }
}
