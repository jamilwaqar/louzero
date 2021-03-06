import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:louzero/models/models.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';

class CustomerLocationPage extends StatefulWidget {
  final CustomerModel customerModel;
  const CustomerLocationPage(this.customerModel, {Key? key}) : super(key: key);

  @override
  _CustomerLocationPageState createState() => _CustomerLocationPageState();
}

class _CustomerLocationPageState extends State<CustomerLocationPage> {
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _parentAccountNameController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _parentAccountNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBaseScaffold(
      subheader: widget.customerModel.customerContacts.first.fullName,
      child: _body(),
    );
  }

  Widget _body() {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: true,
      initialCameraPosition: CameraPosition(
        target: widget.customerModel.serviceAddress.latLng!,
        zoom: 18,
      ),
      onMapCreated: (GoogleMapController controller) {
        Future.delayed(const Duration(milliseconds: 500)).then((value) {
          setState(() {
            // mapController.complete(controller);
          });
        });
      },
    );
  }
}
