import 'package:badges_for_employes/data/repo/client_repository.dart';
import 'package:badges_for_employes/data/source/user/user_data_source.dart';
import 'package:badges_for_employes/model/roles/userRole.dart';
import 'package:badges_for_employes/ui/screens/adminHomeScreen.dart';
import 'package:badges_for_employes/ui/screens/userHomeScreen.dart';
import 'package:badges_for_employes/ui/widgets/forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/login/bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

bool isClinetLoginMde = true;
final TextEditingController username = TextEditingController();
final TextEditingController password = TextEditingController();
// for first seen i set false

@override
class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return BlocProvider<LoginBloc>(
        create: (context) {
          final LoginBloc loginBloc = LoginBloc(
              userRepository: userRepository,
              isClientLoginMode: isClinetLoginMde);
          loginBloc.add(LoginStarted());
          loginBloc.stream.forEach((state) {
            if (state is LoginFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.loginExceptionMessage)));
            } else if (state is LoginSuccess) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => state.user!.userRole == UserRole.client
                      ? UserHomeScreen(user: state.user!,employeeList: state.employesList,)
                      : AdminHomeScreen(user: state.user!)));
            }
          });
          return loginBloc;
        },
        child: Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if (state is InformationSettingState ||
                          state is LoginFailed) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              //default role is user
                              Text(
                                  'Click the button below and change your user role'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _selectRole(
                                      context: context,
                                      userRole: state.isClientLoginMode
                                          ? UserRole.client
                                          : UserRole.admin),
                                ],
                              ),
                            
                              CustomInputField(
                                title: 'userName',
                                context: context,
                                hint: 'your username here',
                                textEditingController: username,
                                themeData: themeData,
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              //ubScure text and etc not setted.
                              CustomInputField(
                                title: 'password',
                                context: context,
                                hint: 'your Password here',
                                textEditingController: password,
                                themeData: themeData,
                              ),
                              SizedBox(
                                height: 200,
                                child: TextButton(
                                  child: Text(state.isClientLoginMode
                                      ? 'login as User'
                                      : 'Login as Admin'),
                                  onPressed: () {
                                    setState(() {
                                      BlocProvider.of<LoginBloc>(context).add(
                                          AuthButtonClicked(
                                              userName: username.text,
                                              password: password.text));
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        );
                      } else if (state is LoginLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        // This is Only For Develoer The user will never see it
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }

  ElevatedButton _selectRole({required UserRole userRole, required context}) {
    return ElevatedButton(
        onPressed: () {
          if (userRole == UserRole.admin) {
            BlocProvider.of<LoginBloc>(context).add(SetRoleToClientClicked());
          } else {
            // userRole == UserRole.client
            setState(() {
              isClinetLoginMde = false;
            });
            BlocProvider.of<LoginBloc>(context).add(SetRoleToAmdinClicked());
          }
        },
        child: Text(userRole.toString()),
        style: ButtonStyle(
          // custom color {According to the project, the focus is not on the ui, so I did not use the theme features}
          backgroundColor: MaterialStateProperty.all(Colors.amber),
        ));
  }
}
