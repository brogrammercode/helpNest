import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:helpnest/core/config/color.dart';
import 'package:helpnest/features/auth/data/models/user_model.dart';
import 'package:iconsax/iconsax.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<String?> uploadFileAndGetUrl(
    {required File file, required String path, String bucket = "users"}) async {
  try {
    final supabase = Supabase.instance.client;

    await supabase.storage.from(bucket).upload(
          path,
          file,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
        );

    String fileUrl = supabase.storage.from(bucket).getPublicUrl(path);

    dev.log('File uploaded successfully! File URL: $fileUrl');

    return fileUrl;
  } catch (e) {
    dev.log("UPLOAD_FILE_ERROR: $e");
    return null;
  }
}


Future<void> commonDialog({
  required BuildContext context,
  required String title,
  required String description,
  required String cancelText,
  required VoidCallback cancelOnTap,
  required String agreeText,
  required VoidCallback agreeOnTap,
  Color color = AppColors.red500,
  required IconData icon,
}) async {
  await showDialog(
    useSafeArea: false,
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 30.h),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.r)),
                  backgroundColor: color),
              icon: Icon(
                icon,
                color: Colors.white,
                size: 30.r,
              )),
          SizedBox(height: 30.h),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30.h),
          ElevatedButton(
              onPressed: agreeOnTap,
              style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r))),
              child: Text(
                agreeText,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
              ))
        ],
      ),
    ),
  );
}

Future<void> commonBottomSheet({
  required BuildContext context,
  required String title,
  required List<String> options,
  required ValueChanged<String> onSelected,
}) {
  return showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Select an option",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold)),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    padding: EdgeInsets.zero,
                    constraints:
                        BoxConstraints(minWidth: 24.r, minHeight: 24.r),
                    style: IconButton.styleFrom(
                        padding: EdgeInsets.all(2.r),
                        backgroundColor: Colors.grey.withOpacity(.3),
                        shape: const CircleBorder()),
                    icon: Icon(
                      CupertinoIcons.multiply,
                      size: 16.r,
                    ),
                  )
                ],
              ),
            ),
            Divider(height: 1.r, color: Colors.grey.withOpacity(.2)),
            ...options.map((option) => InkWell(
                  onTap: () {
                    onSelected(option);
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                    child: Row(
                      children: [
                        const Icon(Iconsax.clock),
                        SizedBox(width: 20.w),
                        Text(option,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      );
    },
  );
}

Future<UserLocationModel> getUserLocationFromPosition(Position position) async {
  try {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;

      String continent = _getContinentFromCountry(place.country ?? "");

      return UserLocationModel(
        city: place.subAdministrativeArea ?? "",
        area: place.locality ?? "",
        pincode: place.postalCode ?? "",
        locality: place.thoroughfare ?? "",
        state: place.administrativeArea ?? "",
        country: place.country ?? "",
        continent: continent,
        geopoint: GeoPoint(position.latitude, position.longitude),
        updateTD: Timestamp.now(),
      );
    } else {
      throw Exception("No placemarks found");
    }
  } catch (e) {
    dev.log("ERROR_GETTING_LOCATION_DATA: $e");
    rethrow;
  }
}

// 🔹 Helper function to get continent based on country
String _getContinentFromCountry(String country) {
  const Map<String, String> countryToContinent = {
    "India": "Asia",
    "United States": "North America",
    "Canada": "North America",
    "Brazil": "South America",
    "United Kingdom": "Europe",
    "Germany": "Europe",
    "Australia": "Australia",
    "South Africa": "Africa",
    "Japan": "Asia",
  };

  return countryToContinent[country] ?? "Unknown";
}


/// 🌍 Calculates distance between points using the Haversine formula.
double calculateDistance({
  (double, double)? point1,
  (double, double)? point2,
  List<(double, double)>? points,
}) {
  const double R = 6371; // 🌎 Earth radius in km

  double degToRad(double deg) => deg * (pi / 180);

  double haversine(double lat1, double lon1, double lat2, double lon2) {
    double dLat = degToRad(lat2 - lat1);
    double dLon = degToRad(lon2 - lon1);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(degToRad(lat1)) *
            cos(degToRad(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  /// 📍 Distance between two points
  if (point1 != null && point2 != null) {
    return haversine(point1.$1, point1.$2, point2.$1, point2.$2);
  }

  /// 🛣️ Total distance for multiple points
  if (points != null && points.length > 1) {
    double totalDistance = 0.0;
    for (int i = 0; i < points.length - 1; i++) {
      totalDistance += haversine(
        points[i].$1,
        points[i].$2,
        points[i + 1].$1,
        points[i + 1].$2,
      );
    }
    return totalDistance;
  }

  throw ArgumentError(
      '⚠️ Provide either (point1 & point2) or a list of points.');
}

String mapImage({required List<GeoPoint> points}) {
  if (points.isEmpty) {
    throw ArgumentError("Points list cannot be empty");
  }

  // If only one point, show a single marker
  if (points.length == 1) {
    return "https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/"
        "pin-l+000000(${points.first.longitude},${points.first.latitude})"
        "/auto/800x800?padding=120&access_token=pk.eyJ1Ijoic2F1cmFiaC10ZWNoMjYwMyIsImEiOiJjbDk4b2FwemQwcTU4M3BtdjYzNHNkc3d1In0.K3wmWSc7atSi-EqkGtKbwg";
  }

  // Start (black) and End (green) markers
  String markers =
      "pin-l+000000(${points.first.longitude},${points.first.latitude}),"
      "pin-l+006600(${points.last.longitude},${points.last.latitude})";

  // Generate polyline path
  String path = points.map((p) => "${p.longitude},${p.latitude}").join(";");

  return "https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/"
      "$markers,"
      "path-5+ff0000-0.8($path)"
      "/auto/800x800?padding=120&access_token=pk.eyJ1Ijoic2F1cmFiaC10ZWNoMjYwMyIsImEiOiJjbDk4b2FwemQwcTU4M3BtdjYzNHNkc3d1In0.K3wmWSc7atSi-EqkGtKbwg";
}
