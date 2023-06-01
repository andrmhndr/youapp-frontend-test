import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:youapp_test/blocs/profile/profile_bloc.dart';
import 'package:youapp_test/helper/color_helper.dart';
import 'package:youapp_test/models/profile_model.dart';
import 'package:youapp_test/views/home/edit_interest.dart';

class InterestContainer extends StatefulWidget {
  const InterestContainer({
    super.key,
  });

  @override
  State<InterestContainer> createState() => _InterestContainerState();
}

class _InterestContainerState extends State<InterestContainer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Interest',
                        style: Get.textTheme.bodyMedium!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                    IconButton(
                      key: Key('edit_interest'),
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 16,
                      ),
                      onPressed: () {
                        Get.to(() => EditInterest(
                              tags: state.profile.interests!,
                            ));
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                AnimatedContainer(
                  padding: const EdgeInsets.only(right: 24),
                  duration: const Duration(milliseconds: 500),
                  height: state.profile.interests!.length == 0 ? 30 : null,
                  curve: Curves.easeIn,
                  child: state.profile.interests!.length == 0
                      ? Text(
                          'Add in your interest to find a better match',
                          style: Get.textTheme.bodyMedium!
                              .copyWith(color: ColorHelper.subtitleText),
                        )
                      : Wrap(
                          children: state.profile.interests!
                              .map(
                                (item) => Container(
                                  margin: EdgeInsets.only(right: 5, bottom: 5),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                      color: ColorHelper.interestBox,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100))),
                                  child: Text(
                                    item,
                                    style: Get.textTheme.bodyLarge!
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                ),
                const SizedBox(
                  height: 10,
                ),
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
