import 'package:badges_for_employes/data/repo/client_repository.dart';
import 'package:badges_for_employes/data/source/user/user_data_source.dart';
import 'package:badges_for_employes/model/roles/userRole.dart';
import 'package:badges_for_employes/model/user.dart';
import 'package:badges_for_employes/ui/screens/adminHomeScreen.dart';
import 'package:badges_for_employes/ui/screens/userHomeScreen.dart';
import 'package:badges_for_employes/ui/widgets/forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/login/bloc/login_bloc.dart';
import '../../model/gender.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

bool isClinetLoginMde = true;
final TextEditingController username = TextEditingController();
final TextEditingController password = TextEditingController();
final TextEditingController firstName = TextEditingController();
final TextEditingController lastName = TextEditingController();

//
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
                      ? UserHomeScreen(
                          user: state.user!,
                          employeeList: state.employesList,
                        )
                      : AdminHomeScreen(
                          user: state.user!,
                        )));
            } else if (state is ErrorCreateNewUser) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error | This user exists')));
            } else if (state is SignUpSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('The user was created successfully!')));
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
                          state is LoginFailed || state is SignUpSuccess) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              //default role is user

                              CustomInputField(
                                title: 'userName',
                                context: context,
                                hint: 'your username here',
                                textEditingController: username,
                                themeData: themeData,
                              ),
                              const SizedBox(
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
                                height: 80,
                              ),
                              const Text(
                                  'Click the button below and change your user role'),
                              Divider(
                                height: 15,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
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
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                height: 50,
                                child: TextButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15))),
                                    minimumSize: MaterialStateProperty.all(Size(
                                        MediaQuery.of(context).size.width * 0.7,
                                        48)),
                                    backgroundColor: MaterialStateProperty.all(
                                        themeData.primaryColor
                                            .withOpacity(0.2)),
                                  ),
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
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account?",
                                    style: themeData.textTheme.caption,
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<LoginBloc>(context)
                                          .add(MakeAnAccountBottonClicked());
                                    },
                                    child: Text(
                                      'create an account',
                                      style:
                                          themeData.textTheme.caption!.copyWith(
                                        color: themeData.primaryColor,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      } else if (state is LoginLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is ShowSignUpPage ||state is  ErrorCreateNewUser) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              CustomInputField(
                                  title: 'userName',
                                  hint: 'your userName',
                                  textEditingController: username,
                                  context: context,
                                  themeData: themeData),
                              CustomInputField(
                                  title: 'first Name ',
                                  hint: 'your FirstName',
                                  textEditingController: firstName,
                                  context: context,
                                  themeData: themeData),
                              CustomInputField(
                                  title: 'last Name',
                                  hint: 'your LastName',
                                  textEditingController: lastName,
                                  context: context,
                                  themeData: themeData),
                              CustomInputField(
                                  title: 'Password',
                                  hint: 'your Pssword here',
                                  textEditingController: password,
                                  context: context,
                                  themeData: themeData),
                              SizedBox(
                                height: 25,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    //This can also be done in the bloc
                                    if (username.text.isEmpty ||
                                        firstName.text.isEmpty ||
                                        lastName.text.isEmpty ||
                                        password.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showMaterialBanner(MaterialBanner(
                                              content: Text(
                                                  'Please fill in all fields'),
                                              backgroundColor: Colors.red,
                                              actions: [Container()]));
                                    } else {
                                      BlocProvider.of<LoginBloc>(context)
                                          .add(RegisterAccountClicked(
                                              user: User(
                                        id: hiveUserBox.isEmpty
                                            ? 0
                                            : hiveUserBox.values.last.id + 1,
                                        lastName: lastName.text,
                                        name: firstName.text,
                                        password: password.text,
                                        userName: username.text,
                                        userRole: UserRole.client,
                                      )));
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('create Account'),
                                    ],
                                  ),
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15))),
                                    minimumSize: MaterialStateProperty.all(Size(
                                        MediaQuery.of(context).size.width * 0.7,
                                        48)),
                                    // custom color {According to the project, the focus is not on the ui, so I did not use the theme features}
                                    backgroundColor: MaterialStateProperty.all(
                                        Theme.of(context).primaryColor),
                                  )),
                              SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<LoginBloc>(context)
                                        .add(LoginStarted());
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Cancell'),
                                    ],
                                  ),
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15))),
                                    minimumSize: MaterialStateProperty.all(Size(
                                        MediaQuery.of(context).size.width * 0.7,
                                        48)),
                                    // custom color {According to the project, the focus is not on the ui, so I did not use the theme features}
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.grey),
                                  )),
                            ],
                          ),
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
        child: Row(
          children: [
            Icon(Icons.arrow_right_alt),
            Text(userRole.toString()),
          ],
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
          minimumSize: MaterialStateProperty.all(
              Size(MediaQuery.of(context).size.width * 0.7, 48)),
          // custom color {According to the project, the focus is not on the ui, so I did not use the theme features}
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).primaryColor),
        ));
  }
}
