import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:louzero/bloc/bloc.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/models/customer_models.dart';
import 'package:louzero/ui/page/base_scaffold.dart';
import 'package:louzero/ui/page/customer/add_customer.dart';
import 'package:louzero/ui/page/customer/customer.dart';
import 'package:louzero/ui/widget/appbar_action.dart';
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

  @override
  void initState() {
    _customerBloc =  CustomerBloc(context.read<BaseBloc>());
    _fetchCustomers();
    super.initState();
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _parentAccountNameController.dispose();
    super.dispose();
  }

  void _fetchCustomers() {
    if (mounted) {
      NavigationController().notifierInitLoading.value = true;
    }
    Backendless.data.of(BLPath.customer).find().then((res) {
      _customerBloc.add(UpdateCustomerModelListEvent(
          List<Map>.from(res!).map((e) => CustomerModel.fromMap(e)).toList()));
      NavigationController().notifierInitLoading.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _customerBloc,
      child: BlocListener<CustomerBloc, CustomerState>(
        listener: (BuildContext context, CustomerState state) {

        },
        child: BlocBuilder<CustomerBloc, CustomerState>(
          builder: (context, CustomerState state) {
            return BaseScaffold(
              child: Scaffold(
                appBar: SubAppBar(
                  title: "Customers",
                  context: context,
                  leadingTxt: "Home",
                  actions: [
                    AppBarAction(
                        label: 'Add New',
                        onPressed: () => NavigationController()
                            .pushTo(context, child: AddCustomerPage(_customerBloc)))
                  ],
                ),
                backgroundColor: Colors.transparent,
                body: _body(state),
              ),
            );
          }
        ),
      ),
    );
  }

  Widget _body(CustomerState state) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        itemCount: state.customers.length,
        itemBuilder: (context, index) {
          CustomerModel model = state.customers[index];
          return DashboardCell(
            title: model.name,
            description: "",
            count: 0,
            buttonTitleLeft: model.fullServiceAddress,
            buttonTitleRight: "",
            onPressed: () => NavigationController()
                .pushTo(context, child: CustomerProfilePage(model)),
            onPressedLeft: () {},
            onPressedRight: () {},
          );
        });
  }
}
