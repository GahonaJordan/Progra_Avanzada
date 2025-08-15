import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import 'package:frontoperaciones/viewmodels/operacion_viewmodel.dart';
import 'package:frontoperaciones/views/home_view.dart';
import 'package:provider/provider.dart';

class FakeOperacionViewModel extends OperacionViewModel{
  bool fueInvocado=false;

}