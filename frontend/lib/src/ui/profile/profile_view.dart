import 'package:flutter/material.dart';
import 'package:jober/src/models/repositories/auth_repository.dart';
import 'package:jober/src/ui/profile/profile_viewmodel.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const routeName = "/profile";

  @override
  Widget build(BuildContext context) {
    print('ici ca build le profile');
    final viewModel = context.watch<ProfileViewModel>();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: viewModel.isConnected()
              ? [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        AssetImage('assets/images/job_default.png'),
                  ),
                  const SizedBox(height: 20),
                  ...(!viewModel.editMode
                      ? [
                          Text(
                            '${viewModel.userFirstName} ${viewModel.userLastName}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: viewModel.toggleEditMode,
                            child: const Text('Edit'),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: viewModel.signOut,
                            child: const Text('Sign out'),
                          )
                        ]
                      : [
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'Name'),
                                  initialValue: viewModel.userFirstName,
                                  validator: viewModel.validateFirstName,
                                  onSaved: (value) =>
                                      viewModel.userFirstName = value!,
                                ),
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'Last Name'),
                                  initialValue: viewModel.userLastName,
                                  validator: viewModel.validateLastName,
                                  onSaved: (value) =>
                                      viewModel.userLastName = value!,
                                ),
                                ElevatedButton(
                                  child: Text('Save'),
                                  onPressed: () =>
                                      viewModel.validateForm(_formKey),
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  child: Text('Cancel'),
                                  onPressed: () => viewModel.toggleEditMode(),
                                ),
                              ],
                            ),
                          )
                        ]),
                ]
              : [
                  ElevatedButton(
                    onPressed: () => viewModel.signUp(
                        'supabase_ICI_CA_TEST@myburnier.ch', '12345678901'),
                    child: Text("SIGN UP"),
                  ),
                  ElevatedButton(
                    onPressed: () => viewModel.signIn(
                        'supabase_ICI_CA_TEST@myburnier.ch', '12345678901'),
                    child: Text("SIGN IN"),
                  ),
                ],
        ),
      ),
    );
  }
}
