import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:louzero/bloc/bloc.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/enum/enums.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/models/models.dart';
import 'package:louzero/ui/page/base_scaffold.dart';
import 'package:louzero/ui/page/customer/customer_site.dart';
import 'package:louzero/ui/widget/customer_info.dart';
import 'package:louzero/ui/widget/widget.dart';

class CustomerProfilePage extends StatefulWidget {
  final CustomerModel customerModel;
  const CustomerProfilePage(this.customerModel, {Key? key})
      : super(key: key);

  @override
  _CustomerProfilePageState createState() => _CustomerProfilePageState();
}

class _CustomerProfilePageState extends State<CustomerProfilePage> {
  late CustomerModel customerModel;
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _parentAccountNameController =
      TextEditingController();

  @override
  void initState() {
    customerModel = widget.customerModel;
    widget.customerBloc.add(FetchCustomerDetailsEvent(customerModel.objectId!));
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
    return BlocListener<CustomerBloc, CustomerState>(
      bloc: widget.customerBloc,
      listener: (context, CustomerState state) {
        customerModel =
            widget.customerBloc.customerModelById(customerModel.objectId!) ??
                customerModel;
        setState(() {});
      },
      child: BlocBuilder<CustomerBloc, CustomerState>(
          bloc: widget.customerBloc,
          builder: (context, state) {
            return BaseScaffold(
              child: Scaffold(
                appBar: SubAppBar(
                  title: customerModel.name,
                  context: context,
                  leadingTxt: "Customers",
                  hasActions: false,
                ),
                backgroundColor: Colors.transparent,
                body: _body(),
              ),
            );
          }),
    );
  }

  Widget _body() {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomerInfo(customerModel),
              const SizedBox(height: 24),
              _category()
            ],
          );
        });
  }

  Widget _category() {
    List<Widget> itemList = List.generate(CustomerCategory.values.length,
        (index) => _categoryItem(CustomerCategory.values[index])).toList();
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 24,
      mainAxisSpacing: 24,
      shrinkWrap: true,
      children: itemList,
      childAspectRatio: 2.4 / 1,
    );
  }

  Widget _categoryItem(CustomerCategory category) {
    int count = 0;
    switch (category) {
      case CustomerCategory.jobs:
        break;
      case CustomerCategory.siteProfiles:
        count = customerModel.siteProfiles.length;
        break;
      case CustomerCategory.contacts:
        break;
      case CustomerCategory.pictures:
        break;
      case CustomerCategory.notes:
        break;
      case CustomerCategory.subAccounts:
        break;
    }
    return InkWell(
      onTap: () {
        Widget? categoryPage;
        switch (category) {
          case CustomerCategory.jobs:
            break;
          case CustomerCategory.siteProfiles:
            count = customerModel.siteProfiles.length;
            categoryPage = CustomerSiteProfilePage(
                widget.customerBloc, customerModel.siteProfiles,
                customerId: customerModel.objectId);
            break;
          case CustomerCategory.contacts:
            break;
          case CustomerCategory.pictures:
            break;
          case CustomerCategory.notes:
            break;
          case CustomerCategory.subAccounts:
            break;
        }

        if (categoryPage != null) {
          NavigationController().pushTo(context, child: categoryPage);
        }
      },
      child: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.light_2, width: 1),
          color: AppColors.lightest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.light_1,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(category.title,
                              style: TextStyles.titleL
                                  .copyWith(color: AppColors.dark_3))),
                      Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.light_2,
                        ),
                        child: Text('$count',
                            style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.dark_3,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    category.description,
                    style: TextStyles.bodyM.copyWith(color: AppColors.dark_3),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
