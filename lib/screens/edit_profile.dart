import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import '/components/text_form_builder.dart';
import '/models/user.dart';
import '/utils/firebase.dart';
import '/utils/validation.dart';
import '/view_models/profile/edit_profile_view_model.dart';
import '/widgets/indicators.dart';

class EditProfile extends StatefulWidget {
  final UserModel user;

  const EditProfile({this.user});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  UserModel user;

  String currentUid() {
    return firebaseAuth.currentUser.uid;
  }

  @override
  Widget build(BuildContext context) {
    EditProfileViewModel viewModel = Provider.of<EditProfileViewModel>(context);
    return ModalProgressHUD(
      progressIndicator: circularProgress(context),
      inAsyncCall: viewModel.loading,
      child: Scaffold(
        key: viewModel.scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Профайлаа засах"),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () => viewModel.editProfile(context),
                  child: Text(
                    'ХАДГАЛАХ',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 13.0,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: ListView(
          children: [
            Center(
              child: GestureDetector(
                onTap: () => viewModel.pickImage(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        offset: new Offset(0.0, 0.0),
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                  ),
                  child: viewModel.imgLink != null
                      ? Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: CircleAvatar(
                            radius: 65.0,
                            backgroundImage: NetworkImage(viewModel.imgLink),
                          ),
                        )
                      : viewModel.image == null
                          ? Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: CircleAvatar(
                                radius: 65.0,
                                backgroundImage:
                                    NetworkImage(widget.user.photoUrl),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: CircleAvatar(
                                radius: 65.0,
                                backgroundImage: FileImage(viewModel.image),
                              ),
                            ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            buildForm(viewModel, context)
          ],
        ),
      ),
    );
  }

  buildForm(EditProfileViewModel viewModel, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: viewModel.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormBuilder(
              enabled: !viewModel.loading,
              initialValue: widget.user.username,
              prefix: Feather.user,
              hintText: "Нэр",
              textInputAction: TextInputAction.next,
              validateFunction: Validations.validateName,
              onSaved: (String val) {
                viewModel.setUsername(val);
              },
            ),
            SizedBox(height: 10.0),
            TextFormBuilder(
              initialValue: widget.user.country,
              enabled: !viewModel.loading,
              prefix: Feather.map_pin,
              hintText: "Улс",
              textInputAction: TextInputAction.next,
              validateFunction: Validations.validateName,
              onSaved: (String val) {
                viewModel.setCountry(val);
              },
            ),
            SizedBox(height: 10.0),
            Text(
              "Намтар нэмэх",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextFormField(
              maxLines: null,
              initialValue: widget.user.bio,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (String value) {
                if (value.length > 1000) {
                  return 'Намтар тань богино байх ёстой';
                }
                return null;
              },
              onSaved: (String val) {
                viewModel.setBio(val);
              },
              onChanged: (String val) {
                viewModel.setBio(val);
              },
            ),
          ],
        ),
      ),
    );
  }
}
