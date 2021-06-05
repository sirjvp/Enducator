import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electricity_calc/models/models.dart';
import 'package:electricity_calc/services/services.dart';
import 'package:electricity_calc/shared/shared.dart';
import 'package:electricity_calc/ui/widgets/widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


part 'splash.dart';
part 'login.dart';
part 'register.dart';
part 'home.dart';
part 'report.dart';
part 'reportdetail.dart';
part 'detaildevice.dart';
part 'adddevice.dart';
part 'myaccount.dart';
part 'setting.dart';
part 'editprofile.dart';