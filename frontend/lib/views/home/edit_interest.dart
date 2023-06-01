import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:youapp_test/blocs/profile/profile_bloc.dart';
import 'package:youapp_test/helper/color_helper.dart';
import 'package:youapp_test/helper/gradient_helper.dart';
import 'package:youapp_test/helper/images_helper.dart';
import 'package:youapp_test/views/widgets/image_background.dart';

import '../../cubits/profile controller/profile_controller_cubit.dart';

class EditInterest extends StatefulWidget {
  EditInterest({
    super.key,
    required this.tags,
  });

  final List<String> tags;

  @override
  State<EditInterest> createState() => _EditInterestState();
}

class _EditInterestState extends State<EditInterest> {
  List<String> tags = [];

  final formKey = GlobalKey<FormState>();

  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    tags = widget.tags;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProfileLoaded) {
          return ImageBackground(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.keyboard_double_arrow_left,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    style: Get.textTheme.bodyMedium!
                                        .copyWith(color: Colors.white),
                                    'Back',
                                  )
                                ],
                              ),
                            ),
                            TextButton(
                                key: Key('save_button'),
                                onPressed: () {
                                  context.read<ProfileBloc>().add(UpdateProfile(
                                      profile: state.profile
                                          .copyWith(interests: tags)));
                                  Get.back();
                                },
                                child: GradientText(
                                  'Save',
                                  style: Get.textTheme.bodyMedium,
                                  gradient: LinearGradient(
                                    colors: ColorHelper.blueGradient,
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                  ),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35),
                        child: GradientText(
                          'Tell everyone about yourself',
                          style: Get.textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.w700),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: ColorHelper.goldenGradient,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Text(
                          'What interest you?',
                          style: Get.textTheme.titleLarge!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: ColorHelper.imageBackground,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Wrap(
                          spacing: 5,
                          children: tags
                              .map((item) => Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                      color: ColorHelper.imageBackground,
                                    ),
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 3),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          child: Text(
                                            '$item',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          onTap: () {
                                            print(tags);
                                          },
                                        ),
                                        const SizedBox(width: 4.0),
                                        InkWell(
                                          child: const Icon(
                                            Icons.cancel,
                                            size: 14.0,
                                            color: Color.fromARGB(
                                                255, 233, 233, 233),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              tags.removeAt(tags.indexWhere(
                                                  (element) =>
                                                      element == item));
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          key: Key('interests_input'),
                          style: Get.textTheme.bodyMedium!
                              .copyWith(color: Colors.white),
                          controller: controller,
                          validator: (value) {
                            if (tags.contains(value)) {
                              return 'tag has been added !';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 0),
                            filled: true,
                            fillColor: ColorHelper.imageBackground,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                          ),
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate() &&
                                value != '') {
                              setState(() {
                                tags.add(value);
                                controller.clear();
                              });
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
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
  }
}
