import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/ui/page/base_scaffold.dart';
import 'package:louzero/ui/widget/widget.dart';

class CustomerLocationPage extends StatefulWidget {
  const CustomerLocationPage({Key? key}) : super(key: key);

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
    return BaseScaffold(
      child: Scaffold(
        appBar: SubAppBar(
          title: "Archwood House",
          context: context,
          leadingTxt: "Archwood House",
          hasActions: false,
        ),
        backgroundColor: AppColors.light_1,
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: true,
      initialCameraPosition: const CameraPosition(
        target: LatLng(45.6731541,-122.6928643),
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
