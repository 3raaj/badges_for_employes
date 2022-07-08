import 'package:badges_for_employes/common/constants.dart';
import 'package:badges_for_employes/data/repo/client_repository.dart';
import 'package:badges_for_employes/model/badge.dart';
import 'package:badges_for_employes/model/employee.dart';
import 'package:badges_for_employes/model/gender.dart';
import 'package:badges_for_employes/model/user.dart';
import 'package:badges_for_employes/ui/screens/login.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import '../../blocs/client/bloc/client_bloc.dart';

class UserHomeScreen extends StatelessWidget {
  final User user;

  // this list NOT recive the badges . only other info about employes.
  final List<Employee>? employeeList;
  const UserHomeScreen({Key? key, required this.user, this.employeeList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final ClientBloc clientBloc = ClientBloc(userRepository);
        clientBloc.add(ClientPageStarted(user));
        clientBloc.stream.forEach((state) {
          if (state is BadgeSuccessfulAwarded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    'You awarded ${state.employee.name} the ${state.badge.name} badge!'),
              ),
            );
          }
        });
        return clientBloc;
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          },
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocBuilder<ClientBloc, ClientState>(
              builder: (context, state) {
                if (state is ShowEmployesToUser) {
                  final BorderRadius containerBorderadius =
                      BorderRadius.circular(15);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 35,
                      ),
                      Center(child: Text('hello  ${user.name}')),
                      const SizedBox(
                        height: 50,
                      ),
                      const Text('Employes List'),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text(
                          'Award a badge to each employee by clicking Badges'),
                      SizedBox(
                        height: 700,
                        child: ListView.builder(
                            padding: const EdgeInsets.only(bottom: 150),
                            itemCount: state.employes!.length,
                            itemBuilder: (context, index) {
                              final Employee employee = state.employes![index];
                              return Container(
                                margin: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.blue,
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: 110,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text('Name : ' +
                                                employee.name +
                                                ' ' +
                                                employee.lastName),
                                          ),
                                          Icon(employee.gender == Gender.man
                                              ? Icons.man
                                              : employee.gender == Gender.wooman
                                                  ? Icons.woman
                                                  : Icons.question_answer),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      SizedBox(
                                        height: 42,
                                        child: ListView.builder(
                                          itemCount: filterBagdesByGender(
                                                  employee: employee)
                                              .length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            final Badge?
                                                theBadgeAwardedByThisUser =
                                                badgeAwardedTotheEmployee(
                                                    user: user,
                                                    employee: employee);
                                            final Badge badge =
                                                filterBagdesByGender(
                                                    employee: employee)[index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Material(
                                                color: theBadgeAwardedByThisUser !=
                                                            null &&
                                                        theBadgeAwardedByThisUser ==
                                                            badge
                                                    ? Colors.blue[500]
                                                    : Colors.grey.shade400,
                                                borderRadius:
                                                    containerBorderadius,
                                                clipBehavior: Clip.antiAlias,
                                                child: InkWell(
                                                  onTap: () {
                                                    BlocProvider.of<ClientBloc>(
                                                            context)
                                                        .add(AwardBadgeClicked(
                                                            badge: badge,
                                                            user: user,
                                                            employee:
                                                                employee));
                                                  },
                                                  child: Container(
                                                    child: Center(
                                                        child: Text(badge.name
                                                            .toString())),
                                                    width:
                                                        badge.name.length * 9,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          containerBorderadius,
                                                      color: Colors.transparent,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  );
                } else if (state is LoadingClientInformation) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const SizedBox(
                    child: const Text('unknown state / only for developer '),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
  // *** If we consider male, female and unspecified gender,
  // then we should also consider this filter to show employees. ***

  List<Badge> filterBagdesByGender({required Employee employee}) {
    if (employee.gender == Gender.man) {
      List<Badge> badges = [
        Badge.batman,
        Badge.ironman,
        Badge.joker,
        Badge.sherlock,
        Badge.spiderMan,
      ];
      return badges;
    } else if (employee.gender == Gender.wooman) {
      List<Badge> badges = [
        Badge.batgirl,
        Badge.irongirl,
        Badge.spiderGirl,
      ];
      return badges;
    } else {
      // if Gender is NOTDEFINED ....
      return Badge.values.toList();
    }
  }

  // ** We also need a function that specifies the badges
  // granted to each employee by the current user. **
  Badge? badgeAwardedTotheEmployee(
      {required User user, required Employee employee}) {
    //  The Badge awarded functionality and details for each employee is look like this :
    // {
    //   User:Badges.Batman
    //}
// ** Map<User,Badge> **
    //I have implemented this in such a way that it is clear from
    //whom exactly the badges given to each employee were.
    if (employee.badgesAwarded != null && employee.badgesAwarded!.isNotEmpty) {
      Badge? badgeAwardedByThisUser;
      employee.badgesAwarded!.forEach((key, value) {
        if (key.id == user.id) {
          badgeAwardedByThisUser = value;
        }
      });
      return badgeAwardedByThisUser;
    }
  }
}
