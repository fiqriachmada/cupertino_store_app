import 'package:flutter/cupertino.dart';
import 'package:cupertino_store_app/model/app_state_model.dart';

import 'package:cupertino_store_app/app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppStateModel()..loadProducts(),
      child: const CupertinoStoreApp(),
    ),
  );
}
