import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  FirebaseStorage storage = FirebaseStorage.instanceFor(
    bucket: 'gs://study-wyth-me.appspot.com'
  );

  uploadFile() {

  }
}