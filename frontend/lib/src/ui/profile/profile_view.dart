import 'package:flutter/material.dart';
import 'package:jober/src/ui/profile/profile_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jober/src/ui/theme/app_colors.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const routeName = "/profile";

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProfileViewModel>();

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return viewModel.editMode
                  ? _buildEditProfileForm(context, viewModel)
                  : _buildProfileView(context, viewModel);
            } else {
              return const CircularProgressIndicator.adaptive();
            }
          }),
          future: viewModel.ensureUserProfileDefined(),
        ),
      ),
    );
  }

  Widget _buildProfileView(BuildContext context, ProfileViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/images/job_default.png'),
        ),
        const SizedBox(height: 20),
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
          onPressed: () => viewModel.signOut(context),
          child: const Text('Sign out'),
        )
      ],
    );
  }

  Widget _buildEditProfileForm(
      BuildContext context, ProfileViewModel viewModel) {
    final localizations = AppLocalizations.of(context)!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/images/job_default.png'),
        ),
        const SizedBox(height: 20),
        Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  cursorColor:
                      Theme.of(context).extension<AppColors>()!.primaryColor,
                  decoration:
                      InputDecoration(labelText: localizations.firstName),
                  initialValue: viewModel.userFirstName,
                  validator: viewModel.validateFirstName,
                  onSaved: (value) => viewModel.userFirstName = value!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  cursorColor:
                      Theme.of(context).extension<AppColors>()!.primaryColor,
                  decoration:
                      InputDecoration(labelText: localizations.lastName),
                  initialValue: viewModel.userLastName,
                  validator: viewModel.validateLastName,
                  onSaved: (value) => viewModel.userLastName = value!,
                ),
              ),
              ElevatedButton(
                child: Text(localizations.save),
                onPressed: () => viewModel.validateForm(_formKey),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                child: Text(localizations.cancel),
                onPressed: () => viewModel.toggleEditMode(),
              ),
            ],
          ),
        )
      ],
    );
  }
}
