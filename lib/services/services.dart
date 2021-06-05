import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electricity_calc/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

part 'auth_services.dart';
part 'activity_services.dart';
part 'device_services.dart';
part 'calculate_services.dart';