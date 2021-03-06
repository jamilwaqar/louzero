import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/models/models.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/common.dart';

class ContactCard extends StatelessWidget {
  final String title;
  final CustomerContact contact;
  final AddressModel address;
  final VoidCallback? onClickIcon;
  final Widget? trailing;
  final List<Widget> footerActions;

  const ContactCard({
    Key? key,
    required this.title,
    required this.contact,
    required this.address,
    this.trailing,
    this.onClickIcon,
    this.footerActions = const [],
  }) : super(key: key);

  String _fullAddress() {
    var street = address.street;
    var city = address.city;
    var state = address.state;
    var zip = address.zip;

    return "$street $city, $state $zip";
  }

  @override
  Widget build(BuildContext context) {
    return AppCardExpandable(
      title: AppHeaderIcon(
        title,
        icon: Icons.edit,
        onTap: onClickIcon,
      ),
      subtitle: RowSplit(
        space: 'center',
        left: TextIcon(
          _fullAddress(),
          MdiIcons.mapMarker,
        ),
        right: trailing,
      ),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: 316,
                decoration: BoxDecoration(
                    color: AppColors.secondary_95,
                    borderRadius: Common.border_24.copyWith(
                      topRight: const Radius.circular(0),
                      bottomRight: const Radius.circular(0),
                    )),
                child: address.latLng != null
                    ? GoogleMap(
                        mapType: MapType.normal,
                        myLocationEnabled: false,
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: false,
                        initialCameraPosition: CameraPosition(
                          target: address.latLng!,
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
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 4,
              child: Container(
                height: 316,
                margin: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AppCustomerInfo(address: address, contact: contact),
                      ],
                    ),
                    Column(
                      children: [
                        const AppDivider(mt: 0, mb: 16),
                        Row(
                          children: footerActions,
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class TextIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool trail;
  final double size;
  const TextIcon(
    this.text,
    this.icon, {
    this.trail = false,
    this.size = 14,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!trail)
          Icon(
            icon,
            color: AppColors.primary_60,
            size: size,
          ),
        Text(text, style: AppStyles.labelRegular.copyWith(fontSize: size)),
        if (trail)
          Icon(
            icon,
            color: AppColors.primary_60,
            size: size,
          ),
      ],
    );
  }
}
