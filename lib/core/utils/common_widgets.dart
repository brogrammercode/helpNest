import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:badges/badges.dart' as badge;
class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final TextEditingController controller;
  final int? maxLines;
  final int? minLines;
  final bool isEnabled;
  final TextInputType keyboardType;
  final IconData? suffixIcon;
  final void Function()? onTap;

  const CustomTextFormField({
    required this.labelText,
    this.hintText,
    required this.controller,
    this.maxLines,
    this.minLines,
    this.isEnabled = true,
    this.keyboardType = TextInputType.text,
    super.key,
    this.suffixIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        absorbing: !isEnabled,
        child: TextFormField(
          controller: controller,
          maxLines: maxLines,
          minLines: minLines,
          enabled: isEnabled && onTap == null,
          keyboardType: keyboardType,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(.5),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(.5),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomImageUploader extends StatefulWidget {
  final double height;
  final double width;
  final Function(File) onSelected;
  final Function() onCancel;
  File? image;
  String? imageUrl;
  final bool readOnly;

  CustomImageUploader({
    super.key,
    this.height = 200,
    this.width = double.infinity,
    required this.onSelected,
    required this.onCancel,
    this.image,
    this.imageUrl,
    this.readOnly = false,
  });

  @override
  State<CustomImageUploader> createState() => _CustomImageUploaderState();
}

class _CustomImageUploaderState extends State<CustomImageUploader> {
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        widget.image = File(pickedFile.path);
      });
      widget.onSelected(widget.image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return badge.Badge(
      position: badge.BadgePosition.topEnd(top: 20.h, end: 20.h),
      badgeContent: Icon(Iconsax.close_circle, color: Colors.black, size: 20.r),
      badgeStyle: const badge.BadgeStyle(badgeColor: Colors.white),
      showBadge: widget.image != null,
      onTap: () {
        setState(() {
          widget.image = null;
        });
        widget.onCancel;
      },
      child: GestureDetector(
        // onTap: _pickImage,
        onTap: widget.readOnly ? () {} : _pickImage,
        child: Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(.3)),
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.withOpacity(.1),
          ),
          padding: EdgeInsets.all(
              widget.image != null || widget.imageUrl != null ? 10.w : 0),
          child: widget.image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    widget.image!,
                    fit: BoxFit.cover,
                  ),
                )
              : widget.imageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        errorWidget: (c, u, e) {
                          log("CACHED_IMAGE_ERROR: $e");
                          return const Icon(Iconsax.gallery);
                        },
                        imageUrl: widget.imageUrl ?? "",
                      ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Iconsax.gallery),
                        SizedBox(height: 10.h),
                        Text(
                          "Upload an Image",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
