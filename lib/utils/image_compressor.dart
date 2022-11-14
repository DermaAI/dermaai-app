import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<File?> getCompressedImage(File file) async {
  print("Compressing Image");
  var result = await FlutterImageCompress.compressWithFile(
    file.absolute.path,
    minWidth: 2300,
    minHeight: 1500,
    quality: 30,
  );
  print("Compressed Image");
  print("Compressed Image Size: ${result!.lengthInBytes / 1024} KB");

  //Convert Uint8List to File
  File compressedFile = File(file.absolute.path);
  await compressedFile.writeAsBytes(result);

  // var result = await FlutterImageCompress.compressAndGetFile(
  //   file.absolute.path,
  //   targetPath,
  //   quality: 50,
  // );

  // print(file.lengthSync());

  return compressedFile;
}
