import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';

import 'cloud_firestore_mock.dart';

void main() {

  setupCloudFirestoreMocks();

  setUpAll(()async{
    await Firebase.initializeApp();
  });
  testWidgets('Shopping list item', (tester)async{
    
  });
}
