import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jober/src/ui/profile/profile_viewmodel.dart';
import 'package:jober/src/ui/theme/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const routeName = "/profile";

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProfileViewModel>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
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
      ),
    );
  }

  Widget _buildProfileView(BuildContext context, ProfileViewModel viewModel) {
    final String countryToPrint = viewModel.userLocation['country'] == ''
        ? 'COUNTRY NOT DEFINED'
        : viewModel.userLocation['country'];
    final String postalToPrint = viewModel.userLocation['postalcode'] == 0
        ? 'POSTAL_CODE NOT DEFINED'
        : viewModel.userLocation['postalcode'];

    final String userFirstNameToPrint =
        viewModel.userFirstName == '' ? 'FIRST_NAME' : viewModel.userFirstName;
    final String userLastNameToPrint =
        viewModel.userLastName == '' ? 'LAST_NAME' : viewModel.userLastName;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/images/job_default.png'),
        ),
        const SizedBox(height: 20),
        Text(
          userFirstNameToPrint + ' ' + userLastNameToPrint,
          style: const TextStyle(fontSize: 18),
        ),
        Text('${viewModel.userAge.toString()} years old'),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.email),
            const SizedBox(width: 10),
            Text(viewModel.userEmail == '' ? 'EMAIL' : viewModel.userEmail),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.attach_money),
            const SizedBox(width: 10),
            Text(NumberFormat.decimalPattern().format(viewModel.userSalary))
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: viewModel.userSkills
              .map((skill) => Chip(
                    label: Text(skill),
                  ))
              .toList(),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.star),
            const SizedBox(width: 10),
            Text(
                viewModel.userLevel == '' ? 'NOT DEFINED' : viewModel.userLevel)
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.location_on),
            const SizedBox(width: 10),
            Text(countryToPrint + ', ' + postalToPrint)
          ],
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
                  keyboardType: TextInputType.name,
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
                  keyboardType: TextInputType.name,
                  cursorColor:
                      Theme.of(context).extension<AppColors>()!.primaryColor,
                  decoration:
                      InputDecoration(labelText: localizations.lastName),
                  initialValue: viewModel.userLastName,
                  validator: viewModel.validateLastName,
                  onSaved: (value) => viewModel.userLastName = value!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  cursorColor:
                      Theme.of(context).extension<AppColors>()!.primaryColor,
                  decoration: InputDecoration(labelText: localizations.age),
                  initialValue: viewModel.userAge.toString(),
                  validator: viewModel.validateAge,
                  onSaved: (value) => viewModel.userAge = int.parse(value!),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  cursorColor:
                      Theme.of(context).extension<AppColors>()!.primaryColor,
                  decoration: InputDecoration(labelText: localizations.salary),
                  initialValue: viewModel.userSalary.toString(),
                  validator: viewModel.validateSalary,
                  onSaved: (value) => viewModel.userSalary = int.parse(value!),
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
