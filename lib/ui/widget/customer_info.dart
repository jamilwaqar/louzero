import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/utils.dart';
import 'package:louzero/models/customer_models.dart';
import 'package:louzero/ui/page/customer/customer_location.dart';
import 'buttons/top_left_button.dart';

class CustomerInfo extends StatelessWidget {
  final CustomerModel customerModel;
  final bool fromJob;
  const CustomerInfo(this.customerModel, {this.fromJob = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mapH = fromJob ? 286 : 240;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.light_2, width: 1),
        color: AppColors.lightest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(customerModel.customerContacts.first.fullName,
                                  style: TextStyles.headLineS
                                      .copyWith(color: AppColors.dark_2)),
                              const SizedBox(width: 8),
                              TopLeftButton(
                                  onPressed: () {}, iconData: Icons.edit),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                flex:4,
                                child: Text(customerModel.serviceAddress.fullAddress,
                                    style: TextStyles.bodyL, overflow: TextOverflow.ellipsis),
                              ),
                              const SizedBox(width: 50),
                              appIcon(Icons.attach_money),
                              const SizedBox(width: 3),
                              Text('Acct. Balance:',
                                  style: TextStyles.bodyL
                                      .copyWith(color: AppColors.dark_2)),
                              Text("\$0.00:",
                                  style: TextStyles.bodyL
                                      .copyWith(color: AppColors.darkest)),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              CupertinoButton(
                  onPressed: () {},
                  child: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.light_4.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(30)),
                    child: SvgPicture.asset(
                        "${Constant.imgPrefixPath}/icon-collapse.svg"),
                  ))
            ],
          ),
          SizedBox(
            height: mapH,
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 246,
                      height: mapH,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8))),
                      child: GoogleMap(
                        mapType: MapType.normal,
                        myLocationEnabled: false,
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: false,
                        initialCameraPosition: CameraPosition(
                          target: customerModel.serviceAddress.latLng!,
                          zoom: 18,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          Future.delayed(const Duration(milliseconds: 500))
                              .then((value) {
                            // setState(() {
                            //   // mapController.complete(controller);
                            // });
                          });
                        },
                      ),
                    ),
                    Positioned(
                        top: 8,
                        right: 8,
                        child: InkWell(
                          onTap: () {
                            Get.to(()=> CustomerLocationPage(customerModel));
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            alignment: Alignment.center,
                            child: Image.asset(
                                "assets/icons/icon-full-screen.png"),
                          ),
                        )),
                  ],
                ),
                const SizedBox(width: 21),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Divider(
                          thickness: 2, color: AppColors.light_1, height: 0),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 103,
                          height: 24,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8)),
                              color: AppColors.light_1),
                          child: Text('RESIDENTIAL',
                              style: TextStyles.bodyL.copyWith(fontSize: 12)),
                        ),
                      ),
                      Row(
                        children: [
                          appIcon(Icons.person, color: AppColors.dark_1),
                          const SizedBox(width: 8),
                          const Text('Primary Contact',
                              style: TextStyles.labelL),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(left: 32.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(customerModel.customerContacts[0].fullName,
                                style: TextStyles.bodyL
                                    .copyWith(color: AppColors.dark_3)),
                            Text(customerModel.customerContacts[0].email,
                                style: TextStyles.bodyL
                                    .copyWith(color: AppColors.dark_3)),
                            Text(customerModel.customerContacts[0].phone,
                                style: TextStyles.bodyL
                                    .copyWith(color: AppColors.dark_3)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          appIcon(Icons.location_pin, color: AppColors.dark_1),
                          const SizedBox(width: 8),
                          const Text('Billing Address',
                              style: TextStyles.labelL),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 32.0),
                              child: Text('Same as Service Address',
                                  style: TextStyles.bodyL
                                      .copyWith(color: AppColors.dark_3)),
                            ),
                            if (fromJob)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const SizedBox(height: 16),
                                  const Divider(
                                      thickness: 2, color: AppColors.light_1, height: 0),
                                  const SizedBox(height: 16,),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      _bottomButton("Site Profile", Icons.home_work, () {}),
                                      const SizedBox(width: 8,),
                                      _bottomButton("Notes", Icons.note_sharp, () {}),
                                    ],
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _bottomButton(String label, IconData icon, Function() onPressed) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.light_1
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            appIcon(icon),
            const SizedBox(width: 8),
            Text(label, style: TextStyles.titleS.copyWith(color: AppColors.dark_2),)
          ],
        ),
      ),
    );
  }
}
