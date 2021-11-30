import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:louzero/bloc/bloc.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_card.dart';
import 'package:louzero/common/app_row_flex.dart';
import 'package:louzero/common/app_text_body.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/models/customer_models.dart';
import 'package:louzero/ui/page/base_scaffold.dart';
import 'package:louzero/ui/page/customer/add_customer.dart';
import 'package:louzero/ui/page/customer/customer.dart';
import 'package:louzero/ui/widget/widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerListPage extends StatefulWidget {
  const CustomerListPage({Key? key}) : super(key: key);

  @override
  _CustomerListPageState createState() => _CustomerListPageState();
}

class _CustomerListPageState extends State<CustomerListPage> {
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _parentAccountNameController =
      TextEditingController();
  late CustomerBloc _customerBloc;

  int mockId = 8520;

  @override
  void initState() {
    _customerBloc = CustomerBloc(context.read<BaseBloc>())
      ..add(InitCustomerEvent());
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
    return BlocProvider(
      create: (_) => _customerBloc,
      child: BlocListener<CustomerBloc, CustomerState>(
        listener: (BuildContext context, CustomerState state) {},
        child: BlocBuilder<CustomerBloc, CustomerState>(
            builder: (context, CustomerState state) {
          return BaseScaffold(
            child: Scaffold(
              appBar: SubAppBar(
                title: "Customers",
                context: context,
                leadingTxt: "Home",
                actions: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: AppButton(
                          label: 'Add New',
                          color: AppColors.medium_3,
                          height: 32,
                          icon: Icons.add_circle,
                          onPressed: () => NavigationController().pushTo(
                              context,
                              child: AddCustomerPage(_customerBloc))),
                    ),
                  )
                ],
              ),
              backgroundColor: Colors.transparent,
              body: Column(children: [
                Expanded(child: _body(state)),
              ]),
            ),
          );
        }),
      ),
    );
  }

  Widget _body(CustomerState state) {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 32),
        shrinkWrap: true,
        itemCount: state.customers.length,
        itemBuilder: (context, index) {
          CustomerModel model = state.customers[index];
          return AppCard(
            mb: 8,
            px: 24,
            py: 24,
            children: [
              GestureDetector(
                onTap: () {
                  NavigationController().pushTo(context,
                      child: CustomerProfilePage(model, _customerBloc));
                },
                child: AppRowFlex(
                    flex: const [1, 5, 2, 0],
                    align: CrossAxisAlignment.center,
                    mb: 0,
                    children: [
                      AppTextBody('#$mockId'),
                      Column(
                        children: [
                          AppTextBody(
                            model.name,
                            color: AppColors.darkest,
                            bold: true,
                          ),
                          AppTextBody(
                            model.fullServiceAddress,
                          )
                        ],
                      ),
                      AppTextBody(
                        model.type,
                      ),
                      Icon(Icons.more_vert)
                    ]),
              )
            ],
          );
        });
  }
}
