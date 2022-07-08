import 'package:badges_for_employes/data/repo/client_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/admin/bloc/admin_bloc.dart';
import '../../model/user.dart';

class AdminHomeScreen extends StatelessWidget {
  final User user;

  AdminHomeScreen({Key? key, required this.user}) : super(key: key);
  final AdminBloc adminBloc = AdminBloc(iUserRepository: userRepository);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocProvider(
            create: (context) {
              adminBloc.add(AdminPageStarted(
                user: user,
              ));
              return adminBloc;
            },
            child: BlocBuilder<AdminBloc, AdminState>(
              builder: (context, state) {
                if (state is ShowInFormationToAdmin) {
                  return Column(
                    children: [
                      Text('Hello Admin : ${user.name}'),
                      state.topEmployes!.isNotEmpty
                          ? ListView.builder(
                              itemCount: state.topEmployes!.keys.length,
                              itemBuilder: ((context, index) {
                                return Container(
                                  height: 40,
                                );
                              }))
                          : Container(
                              child: Text('this is Empplty! '),
                            )
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
