import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpnest/core/config/error.dart';
import 'package:helpnest/core/config/routes.dart';
import 'package:helpnest/core/utils/common_widgets.dart';
import 'package:helpnest/features/profile/data/models/service_provier_model.dart';
import 'package:helpnest/features/profile/presentation/cubit/profile_state.dart';

class BecomeProviderPage extends StatefulWidget {
  const BecomeProviderPage({super.key});

  @override
  State<BecomeProviderPage> createState() => _BecomeProviderPageState();
}

class _BecomeProviderPageState extends State<BecomeProviderPage> {
  TextEditingController serviceController = TextEditingController();
  List<String> selectedServiceIDs = [];
  File? _aadhar;
  File? _pan;
  File? _experience;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.error != const CommonError()) {
          log(state.error.consoleMessage);
        } else if (state.requestServiceProviderAccessStatus ==
            StateStatus.success) {
          Navigator.pushReplacementNamed(
              context, AppRoutes.becomeProviderStatusPage);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Become a Service Provider",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: ElevatedButton(
              onPressed: state.requestServiceProviderAccessStatus ==
                      StateStatus.loading
                  ? () {}
                  : () {
                      if (serviceController.text.isNotEmpty &&
                          _aadhar != null &&
                          _pan != null &&
                          _experience != null) {
                        context
                            .read<ProfileCubit>()
                            .requestServiceProviderAccess(
                                ServiceProviderModel(
                                    id: FirebaseAuth
                                            .instance.currentUser?.uid ??
                                        "",
                                    aadharCardImageURL: "",
                                    panCardImageURL: "",
                                    status: "submitted",
                                    approvedTD: Timestamp.now(),
                                    approvedBy: "",
                                    serviceID: "",
                                    experienceDocImageURL: "",
                                    creationTD: Timestamp.now(),
                                    createdBy: FirebaseAuth
                                            .instance.currentUser?.uid ??
                                        "",
                                    deactivate: false),
                                _aadhar,
                                _pan,
                                _experience);
                      }
                    },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Request Verification",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  if (state.requestServiceProviderAccessStatus ==
                      StateStatus.loading) ...[
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
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormField(
                    labelText: "Select Service",
                    controller: serviceController,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 20.h),
                  Text("Aadhar Card",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10.h),
                  CustomImageUploader(
                    onSelected: (File file) => setState(() => _aadhar = file),
                    image: _aadhar,
                    onCancel: () => setState(() => _aadhar = null),
                  ),
                  SizedBox(height: 20.h),
                  Text("PAN Card",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10.h),
                  CustomImageUploader(
                    onSelected: (File file) => setState(() => _pan = file),
                    image: _pan,
                    onCancel: () => setState(() => _pan = null),
                  ),
                  SizedBox(height: 20.h),
                  Text("Experience Certificate",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10.h),
                  CustomImageUploader(
                    onSelected: (File file) =>
                        setState(() => _experience = file),
                    image: _experience,
                    onCancel: () => setState(() => _experience = null),
                  ),
                  SizedBox(height: 200.h)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
