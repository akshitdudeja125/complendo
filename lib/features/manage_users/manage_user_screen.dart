import 'package:complaint_portal/features/auth/providers/user_provider.dart';
import 'package:complaint_portal/features/manage_users/custom_app_bar.dart';
import 'package:complaint_portal/features/manage_users/filter/filter_provider.dart';
import 'package:complaint_portal/features/manage_users/widgets/user_data_card.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageUsers extends ConsumerStatefulWidget {
  const ManageUsers({super.key});

  @override
  ConsumerState<ManageUsers> createState() => _ManageUsersState();
}

class _ManageUsersState extends ConsumerState<ManageUsers> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(userFilterOptionsProvider.notifier).state = {
        "hostel": [],
        "usertype": [],
        "status": [],
        "search": "",
      };
    });
  }

  final searchController = TextEditingController();
  bool isSearch = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          searchController: searchController,
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Consumer(
                builder: (context, ref, _) {
                  final users = ref.watch(allUsersStreamProvider);
                  final List<UserModel> usersList = [];
                  return users.when(
                    data: (data) {
                      for (var user in users.value ?? []) {
                        usersList.add(UserModel.fromMap(user));
                      }

                      final filterOptions =
                          ref.watch(userFilterOptionsProvider);

                      final filteredUsers = usersList.where((user) {
                        return filterOptions["hostel"]
                                .contains(user.hostel.toString()) ||
                            filterOptions['hostel']!.isEmpty;
                      }).where((user) {
                        return filterOptions["usertype"]
                                .contains(user.userType.toString()) ||
                            filterOptions['usertype']!.isEmpty;
                      }).where(
                        (user) {
                          if (user.blocked == true) {
                            return filterOptions["status"]
                                    .contains("Blocked") ||
                                filterOptions['status']!.isEmpty;
                          } else {
                            return filterOptions["status"]
                                    .contains("Unblocked") ||
                                filterOptions['status']!.isEmpty;
                          }
                        },
                      ).where(
                        (user) {
                          return user.name
                              .toLowerCase()
                              .contains(filterOptions["search"]!.toLowerCase());
                        },
                      ).toList();
                      if (kDebugMode) {
                        print(filterOptions["search"]!.toLowerCase());
                      }
                      filteredUsers.sort((a, b) {
                        return a.name.compareTo(b.name);
                      });

                      if (filteredUsers.isEmpty) {
                        return const Center(
                          child: Text("No users found"),
                        );
                      }

                      return Expanded(
                        child: ListView.builder(
                          itemCount: filteredUsers.length,
                          itemBuilder: (context, index) {
                            return UserDetailsCard(
                              user: filteredUsers[index],
                            );
                          },
                        ),
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (error, stackTrace) => Center(
                      child: Text(error.toString()),
                    ),
                  );
                },
              )
            ],
          ),
        ));
  }
}
