import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/models/models.dart';

class AddressList extends GetWidget<BaseController> {
  const AddressList(
      {required this.onSelectedSearchedModel,
      this.left,
      this.right,
      this.bottom,
      this.top,
      Key? key})
      : super(key: key);

  final Function(SearchAddressModel) onSelectedSearchedModel;
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.searchedAddresses.value.isEmpty) {
        return Container();
      }
      return Positioned(
        left: left,
        bottom: bottom,
        right: right,
        top: top,
        child: Container(
          padding: const EdgeInsets.all(8),
          height: 340,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.light_1,
            border: Border.all(color: AppColors.dark_1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (_, int index) => _searchAddressItem(index),
              separatorBuilder: (_, __) => const Divider(),
              itemCount: controller.searchedAddresses.value.length),
        ),
      );
    });
  }

  Widget _searchAddressItem(int index) {
    SearchAddressModel model = controller.searchedAddresses.value[index];
    return InkWell(
      onTap: () => _onSelectAddress(model),
      child: Container(
        height: 42,
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            const Icon(Icons.location_pin, color: AppColors.dark_1, size: 32),
            const SizedBox(width: 14),
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(model.name,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    Text(model.description,
                        style: const TextStyle(
                            color: Color(0xFF9B9B9B),
                            fontSize: 10,
                            fontWeight: FontWeight.w500),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ],
                )),
            IconButton(
                icon: const Icon(Icons.save_outlined, color: AppColors.dark_1),
                onPressed: () {})
          ],
        ),
      ),
    );
  }

  void _onSelectAddress(SearchAddressModel model) async {
    NavigationController().loading();
    List? res = await controller.getLatLng(model.placeId);
    if (res != null) {
      LatLng latLng = res[0];
      String formattedAddress = res[1];
      model.latitude = latLng.latitude;
      model.longitude = latLng.longitude;

      List<String> arr = formattedAddress.split(',');
      if (arr.length > 2) {
        model.street = arr[0];
        model.city = arr[1];
      }
    }
    controller.searchedAddressList = [];
    onSelectedSearchedModel(model);
    NavigationController().loading(isLoading: false);
  }
}
