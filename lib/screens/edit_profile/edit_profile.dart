import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/components.dart';
import 'package:social_app/components/consts.dart';
import 'package:social_app/components/icon_broken.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/size_config.dart';

class EditProfile extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update',
          style: TextStyle(
            fontSize: SizeConfig.scaleTextFont(20),
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.scaleWidth(10),
            ),
            child: TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  SocialCubit.get(context).updateUserData(
                    name: _nameController.text,
                    phone: _phoneController.text,
                    bio: _bioController.text,
                  );
                  return;
                }
                return null;
              },
              child: Text(
                'Update',
                style: TextStyle(
                  fontSize: SizeConfig.scaleTextFont(18),
                ),
              ),
            ),
          ),
        ],
      ),
      body: BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialCubit.get(context).user;
          var imageProfile = SocialCubit.get(context).imageProfile;
          var coverProfile = SocialCubit.get(context).coverProfile;
          if (cubit != null) {
            _nameController.text = cubit.name!;
            _bioController.text = cubit.bio!;
            _phoneController.text = cubit.phone!;
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (state is SocialUpdateDataLoadingState)
                      LinearProgressIndicator(),
                    if (state is SocialUpdateDataLoadingState)
                      SizedBox(
                        height: SizeConfig.scaleHeight(15),
                      ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(175),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          if (coverProfile != null)
                            Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional.topCenter,
                                  child: Container(
                                    height: SizeConfig.scaleHeight(140),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: FileImage(coverProfile),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.all(SizeConfig.scaleHeight(8)),
                                  child: CircleAvatar(
                                    backgroundColor: defaultColor,
                                    child: IconButton(
                                      icon: Icon(
                                        IconBroken.Camera,
                                        color: Colors.white,
                                        size: SizeConfig.scaleHeight(19),
                                      ),
                                      onPressed: () {
                                        SocialCubit.get(context).getCover();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          if (coverProfile == null)
                            Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional.topCenter,
                                  child: Container(
                                    height: SizeConfig.scaleHeight(140),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage('${cubit.cover}'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.all(SizeConfig.scaleHeight(8)),
                                  child: CircleAvatar(
                                    backgroundColor: defaultColor,
                                    child: IconButton(
                                      icon: Icon(
                                        IconBroken.Camera,
                                        color: Colors.white,
                                        size: SizeConfig.scaleHeight(19),
                                      ),
                                      onPressed: () {
                                        SocialCubit.get(context).getCover();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              if (imageProfile != null)
                                CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  radius: 42,
                                  child: CircleAvatar(
                                    backgroundImage: FileImage(imageProfile),
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    radius: 40,
                                  ),
                                ),
                              if (imageProfile == null)
                                CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  radius: 42,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage('${cubit.image}'),
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    radius: 40,
                                  ),
                                ),
                              CircleAvatar(
                                backgroundColor: defaultColor,
                                radius: 15,
                                child: IconButton(
                                  icon: Icon(
                                    IconBroken.Camera,
                                    color: Colors.white,
                                    size: SizeConfig.scaleHeight(12),
                                  ),
                                  onPressed: () {
                                    SocialCubit.get(context).getImage();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(20),
                    ),
                    defaultFromField(
                      controller: _nameController,
                      validatorString: 'Enter name Please',
                      label: 'Name',
                      prefix: IconBroken.User,
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(10),
                    ),
                    defaultFromField(
                      keyboard: TextInputType.number,
                      controller: _phoneController,
                      validatorString: 'Enter phone number Please',
                      label: 'Phone',
                      prefix: IconBroken.Call,
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(10),
                    ),
                    defaultFromField(
                      controller: _bioController,
                      validatorString: 'Enter bio Please',
                      label: 'Bio',
                      prefix: IconBroken.Info_Circle,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
