import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:youapp_test/blocs/profile/profile_bloc.dart';
import 'package:youapp_test/cubits/profile%20controller/profile_controller_cubit.dart';
import 'package:youapp_test/helper/color_helper.dart';
import 'package:youapp_test/helper/converter_helper.dart';
import 'package:youapp_test/helper/gradient_helper.dart';
import 'package:youapp_test/models/profile_model.dart';

class AboutContainer extends StatelessWidget {
  const AboutContainer();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProfileLoaded) {
          return Container(
            padding: const EdgeInsets.only(
              left: 24,
              bottom: 20,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            width: double.infinity,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(14)),
                color: ColorHelper.miniContainerBackground),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(),
                const SizedBox(
                  height: 10,
                ),
                _Body()
              ],
            ),
          );
        } else {
          return Center(
            child: Text('something wrong'),
          );
        }
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileControllerCubit, ProfileControllerState>(
      builder: (context, stateController) {
        return BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProfileLoaded) {
              return AnimatedContainer(
                padding: const EdgeInsets.only(right: 24),
                duration: const Duration(milliseconds: 500),
                height: !stateController.expanded
                    ? state.profile == Profile.empty()
                        ? 30
                        : 150
                    : 475,
                curve: Curves.easeIn,
                child: !stateController.expanded
                    ? state.profile == Profile.empty()
                        ? Text(
                            'Add in your to help others know you better',
                            style: Get.textTheme.bodyMedium!
                                .copyWith(color: ColorHelper.subtitleText),
                          )
                        : Column(
                            children: [
                              _AboutItem(
                                title: 'Gender: ',
                                value: state.profile.gender == null
                                    ? 'unknown'
                                    : state.profile.gender!.name.capitalizeFirst
                                        .toString(),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              _AboutItem(
                                title: 'Birthday: ',
                                value: state.profile.birthday == null
                                    ? 'unknown'
                                    : ConverterHelper.dateFormat(
                                        value: state.profile.birthday),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              _AboutItem(
                                title: 'Horoscope: ',
                                value: '${state.profile.horoscope}',
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              _AboutItem(
                                title: 'Zodiac: ',
                                value: '${state.profile.zodiac}',
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              _AboutItem(
                                title: 'Height: ',
                                value: '${state.profile.height ?? 0} cm',
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              _AboutItem(
                                title: 'Weight: ',
                                value: '${state.profile.weight ?? 0} kg',
                              ),
                            ],
                          )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            _AddImage(),
                            SizedBox(
                              height: 10,
                            ),
                            _InputName(),
                            SizedBox(
                              height: 10,
                            ),
                            _InputGender(),
                            SizedBox(
                              height: 10,
                            ),
                            _InputBirthday(),
                            SizedBox(
                              height: 10,
                            ),
                            _InputHoroscope(),
                            SizedBox(
                              height: 10,
                            ),
                            _InputZodiac(),
                            SizedBox(
                              height: 10,
                            ),
                            _InputHeight(),
                            SizedBox(
                              height: 10,
                            ),
                            _InputWeight(),
                          ],
                        ),
                      ),
              );
            } else {
              return Center(
                child: Text('something wrong'),
              );
            }
          },
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileControllerCubit, ProfileControllerState>(
      builder: (context, stateController) {
        return BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProfileLoaded) {
              return Row(
                children: [
                  Expanded(
                      child: Text(
                    'About',
                    style: Get.textTheme.bodyMedium!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  )),
                  if (!stateController.expanded)
                    IconButton(
                      key: Key('edit_button'),
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 16,
                      ),
                      onPressed: () {
                        context
                            .read<ProfileControllerCubit>()
                            .getProfile(state.profile);
                        context.read<ProfileControllerCubit>().reverseExpand();
                      },
                    )
                  else
                    TextButton(
                      key: Key('save_button'),
                      onPressed: () {
                        context.read<ProfileBloc>().add(
                            UpdateProfile(profile: stateController.profile));
                        context.read<ProfileControllerCubit>().reverseExpand();
                      },
                      child: GradientText(
                        'Save & Update',
                        gradient:
                            LinearGradient(colors: ColorHelper.goldenGradient),
                      ),
                    ),
                ],
              );
            } else {
              return Center(
                child: Text('something wrong'),
              );
            }
          },
        );
      },
    );
  }
}

class _AboutItem extends StatelessWidget {
  _AboutItem({
    super.key,
    required this.title,
    required this.value,
  });

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Get.textTheme.bodyMedium!.copyWith(
              color: ColorHelper.subtitleText, fontWeight: FontWeight.w500),
        ),
        Text(
          value,
          key: Key(title),
          style: Get.textTheme.bodyMedium!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _InputBirthday extends StatelessWidget {
  const _InputBirthday({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileControllerCubit, ProfileControllerState>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Text(
                'Birthday:',
                style: Get.textTheme.bodyMedium!.copyWith(
                    color: ColorHelper.subtitleText,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              flex: 2,
              child: TextFormField(
                onTap: () async {
                  var birthDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(0),
                      lastDate: DateTime(9999));

                  context.read<ProfileControllerCubit>().setBirthday(birthDate);
                },
                controller: TextEditingController(
                    text: state.profile.birthday.toString()),
                textAlign: TextAlign.right,
                readOnly: true,
                style: Get.textTheme.bodyMedium!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  hintText: 'DD MM YYYY',
                  hintStyle: Get.textTheme.bodyMedium!.copyWith(
                      color: ColorHelper.subtitleText,
                      fontWeight: FontWeight.w500),
                  filled: true,
                  fillColor: const Color(0xff0fd9d9d9),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _InputZodiac extends StatelessWidget {
  const _InputZodiac({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Text(
            'Zodiac:',
            style: Get.textTheme.bodyMedium!.copyWith(
                color: ColorHelper.subtitleText, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          flex: 2,
          child: TextFormField(
            textAlign: TextAlign.right,
            style: Get.textTheme.bodyMedium!
                .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
            readOnly: true,
            decoration: InputDecoration(
              hintText: '--',
              hintStyle: Get.textTheme.bodyMedium!.copyWith(
                  color: ColorHelper.subtitleText, fontWeight: FontWeight.w500),
              filled: true,
              fillColor: const Color(0xff0fd9d9d9),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.white,
                  width: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _InputHoroscope extends StatelessWidget {
  const _InputHoroscope({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Text(
            'Horoscope:',
            style: Get.textTheme.bodyMedium!.copyWith(
              color: ColorHelper.subtitleText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: TextFormField(
            textAlign: TextAlign.right,
            style: Get.textTheme.bodyMedium!
                .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
            readOnly: true,
            decoration: InputDecoration(
              hintText: '--',
              hintStyle: Get.textTheme.bodyMedium!.copyWith(
                  color: ColorHelper.subtitleText, fontWeight: FontWeight.w500),
              filled: true,
              fillColor: const Color(0xff0fd9d9d9),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.white,
                  width: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _InputWeight extends StatelessWidget {
  const _InputWeight({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileControllerCubit, ProfileControllerState>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Text(
                'Weight:',
                style: Get.textTheme.bodyMedium!.copyWith(
                  color: ColorHelper.subtitleText,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: TextFormField(
                key: Key('weight_input'),
                onChanged: (value) {
                  context
                      .read<ProfileControllerCubit>()
                      .setWeight(int.tryParse(value) ?? 0);
                },
                keyboardType: TextInputType.number,
                initialValue: state.profile.weight.toString(),
                textAlign: TextAlign.right,
                style: Get.textTheme.bodyMedium!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  hintText: 'Add Weight',
                  hintStyle: Get.textTheme.bodyMedium!.copyWith(
                      color: ColorHelper.subtitleText,
                      fontWeight: FontWeight.w500),
                  filled: true,
                  fillColor: const Color(0xff0fd9d9d9),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _InputHeight extends StatelessWidget {
  const _InputHeight({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileControllerCubit, ProfileControllerState>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Text(
                'Height:',
                style: Get.textTheme.bodyMedium!.copyWith(
                    color: ColorHelper.subtitleText,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              flex: 2,
              child: TextFormField(
                key: Key('height_input'),
                initialValue: state.profile.height.toString(),
                textAlign: TextAlign.right,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  context
                      .read<ProfileControllerCubit>()
                      .setHeight(int.tryParse(value) ?? 0);
                },
                style: Get.textTheme.bodyMedium!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  hintText: 'Add Height',
                  hintStyle: Get.textTheme.bodyMedium!.copyWith(
                      color: ColorHelper.subtitleText,
                      fontWeight: FontWeight.w500),
                  filled: true,
                  fillColor: const Color(0xff0fd9d9d9),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _InputGender extends StatelessWidget {
  const _InputGender({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileControllerCubit, ProfileControllerState>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Text(
                'Gender:',
                style: Get.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: ColorHelper.subtitleText,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: DropdownButtonFormField<Gender>(
                borderRadius: BorderRadius.all(Radius.circular(17)),
                dropdownColor: Get.theme.scaffoldBackgroundColor,
                style: Get.textTheme.bodyMedium!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  hintText: 'Select Gender',
                  hintStyle: Get.textTheme.bodyMedium!.copyWith(
                      color: ColorHelper.subtitleText,
                      fontWeight: FontWeight.w500),
                  filled: true,
                  fillColor: const Color(0xff0fd9d9d9),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 20,
                    ),
                  ),
                ),
                value: state.profile.gender,
                items: Gender.values
                    .map(
                      (item) => DropdownMenuItem(
                        value: item,
                        child: Text(
                          item.name.capitalizeFirst.toString(),
                          style: Get.textTheme.bodyMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  context.read<ProfileControllerCubit>().setGender(value!);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _AddImage extends StatefulWidget {
  const _AddImage({
    super.key,
  });

  @override
  State<_AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<_AddImage> {
  File? image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        try {
          final results = await FilePicker.platform.pickFiles(
            allowMultiple: false,
            type: FileType.custom,
            allowedExtensions: ['png', 'jpg'],
          );
          if (results != null) {
            setState(() {
              this.image = File(results.files.single.path!);
            });

            var imageBytes = await image!.readAsBytes();
            String image64 = base64.encode(imageBytes);
            context.read<ProfileControllerCubit>().setImage(image64);
          }
        } catch (err) {
          print(err);
        }
      },
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                color: ColorHelper.imageBackground,
                borderRadius: BorderRadius.all(
                  Radius.circular(17),
                ),
                image: image != null
                    ? DecorationImage(
                        image: FileImage(image!), fit: BoxFit.cover)
                    : null),
            child: const GradientIcon(
              Icons.add,
              gradient: LinearGradient(colors: ColorHelper.goldenGradient),
              size: 30,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            'Add Image',
            style: Get.textTheme.bodyMedium!
                .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class _InputName extends StatelessWidget {
  const _InputName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileControllerCubit, ProfileControllerState>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Text(
                'Display name:',
                style: Get.textTheme.bodyMedium!.copyWith(
                  color: ColorHelper.subtitleText,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: TextFormField(
                key: Key('username_input'),
                initialValue: state.profile.username,
                textAlign: TextAlign.right,
                onChanged: (value) {
                  context.read<ProfileControllerCubit>().setUsername(value);
                },
                style: Get.textTheme.bodyMedium!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  hintText: 'Enter Name',
                  hintStyle: Get.textTheme.bodyMedium!.copyWith(
                      color: ColorHelper.subtitleText,
                      fontWeight: FontWeight.w500),
                  filled: true,
                  fillColor: const Color(0xff0fd9d9d9),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
