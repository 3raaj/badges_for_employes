import 'package:badges_for_employes/common/constants.dart';
import 'package:badges_for_employes/data/repo/client_repository.dart';
import 'package:badges_for_employes/ui/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../blocs/admin/bloc/admin_bloc.dart';
import '../../model/user.dart';

/// The home page of the application which hosts the datagrid.
class AdminHomeScreen extends StatefulWidget {
  final User user;

  /// Creates the home page.
  const AdminHomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdminBloc>(
      create: (context) {
        final AdminBloc adminBloc = AdminBloc(iUserRepository: userRepository);
        adminBloc.add(AdminPageStarted(user: widget.user));
        return adminBloc;
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.arrow_back),
            onPressed: ()async {
            // olny tsest : commented : 
            // await   hiveEmployesBox.clear();
            // dont be forget to Restart app
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            }),
        appBar: AppBar(
          title: const Text('Admin Screen'),
        ),
        body: BlocBuilder<AdminBloc, AdminState>(
          builder: (context, state) {
            if (state is ShowInFormationToAdmin) {
              return SfDataGrid(
                onCellTap:(details) {
                  //batgirl = 1 z hashemi
                  print(state.employes!.first.id);
                },
                allowPullToRefresh: true,
                source: state.employeeDataSource,
                columnWidthMode: ColumnWidthMode.auto,
                allowSorting: true,
                columns: state.gridColumn,
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
