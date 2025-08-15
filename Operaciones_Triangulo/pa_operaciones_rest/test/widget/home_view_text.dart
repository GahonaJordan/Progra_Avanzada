import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pa_operaciones_rest/widgets/result_widget.dart';
import 'package:pa_operaciones_rest/viewmodels/operacion_viewmodel.dart';
import 'package:provider/provider.dart';

class FakeOperacionViewModel extends OperacionViewModel{

  bool fueInvocado = false;
}