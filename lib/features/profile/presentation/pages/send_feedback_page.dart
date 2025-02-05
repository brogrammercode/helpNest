import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpnest/core/config/error.dart';
import 'package:helpnest/core/utils/common_methods.dart';
import 'package:helpnest/core/utils/common_widgets.dart';
import 'package:helpnest/features/profile/data/models/feedback_model.dart';
import 'package:helpnest/features/profile/presentation/cubit/profile_state.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class SendFeedbackPage extends StatefulWidget {
  const SendFeedbackPage({super.key});

  @override
  State<SendFeedbackPage> createState() => _SendFeedbackPageState();
}

class _SendFeedbackPageState extends State<SendFeedbackPage> {
  final featureController = TextEditingController();
  final descriptionController = TextEditingController();

  final List<String> _features = [
    "UI Issue",
    "Performance",
    "Bug Report",
    "Feature Request",
    "Other"
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: _appBar(context),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: _submitButton(context, state),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  CustomTextFormField(
                    labelText: "Select Feature",
                    controller: featureController,
                    onTap: () => commonBottomSheet(
                        context: context,
                        title: 'Select an option',
                        options: _features,
                        onSelected: (String value) {
                          featureController.text = value;
                        }),
                    suffixIcon: Iconsax.arrow_down_1,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select an option";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomTextFormField(
                    labelText: "Enter Description",
                    controller: descriptionController,
                    maxLines: 10,
                    minLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select an option";
                      }
                      return null;
                    },
                  ),
                  if (state.appFeedbacks.isNotEmpty) ...[
                    SizedBox(height: 20.h),
                    Text(
                      "Your Feedbacks",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20.h),
                    _buildReviewsSection(context, state.appFeedbacks),
                  ],
                  SizedBox(height: 70.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildReviewsSection(
      BuildContext context, List<FeedbackModel> feedbacks) {
    if (feedbacks.isNotEmpty) {
      feedbacks.sort((a, b) => b.creationTD.compareTo(a.creationTD));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: feedbacks.length,
          itemBuilder: (context, index) {
            final feedback = feedbacks[index];
            return _buildReviewCard(context, feedback);
          },
        ),
      ],
    );
  }

  Widget _buildReviewCard(BuildContext context, FeedbackModel feedback) {
    String formattedDate =
        DateFormat('MMM dd').format(feedback.creationTD.toDate());

    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(.3)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(feedback.title,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(formattedDate),
            ],
          ),
          SizedBox(height: 10.h),
          Text(feedback.description),
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Send Feedback",
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Padding _submitButton(BuildContext context, ProfileState state) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: ElevatedButton(
        onPressed: () {
          if (featureController.text.isEmpty ||
              descriptionController.text.isEmpty) {
          } else {
            final td = Timestamp.now();
            context.read<ProfileCubit>().addFeedback(FeedbackModel(
                  id: td.millisecondsSinceEpoch.toString(),
                  rating: 0,
                  module: "",
                  category: "",
                  title: featureController.text,
                  description: descriptionController.text,
                  creationTD: td,
                  createdBy: FirebaseAuth.instance.currentUser?.uid ?? "",
                  deactivate: false,
                ));
            featureController.text = "";
            descriptionController.text = "";
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Submit Feedback",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            if (state.addFeedbackStatus == StateStatus.loading) ...[
              SizedBox(width: 30.w),
              SizedBox(
                height: 20.h,
                width: 20.h,
                child: const CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white),
              )
            ],
          ],
        ),
      ),
    );
  }
}
