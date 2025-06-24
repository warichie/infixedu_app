//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
//
// void main() => runApp(const MaterialApp(home: FileDownloaderScreen()));
//
// class FileDownloaderScreen extends StatefulWidget {
//   const FileDownloaderScreen({Key? key}) : super(key: key);
//
//   @override
//   State createState() => _FileDownloaderScreenState();
// }
//
// class _FileDownloaderScreenState extends State {
//   File? downloadedFile;
//   String downloadMessage = "Press download";
//
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     double fontSize = MediaQuery.of(context).textScaleFactor;
//
//     return SafeArea(
//       child: Scaffold(
//         body: SizedBox(
//           width: width,
//           height: height,
//           child: Column(
//             children: [
//               ///
//               /// downloaded image builder
//               Container(
//                 width: width,
//                 height: height * 0.6,
//                 color: Colors.teal.shade100,
//                 alignment: Alignment.center,
//                 child: Container(
//                   alignment: Alignment.center,
//                   width: width * 0.8,
//                   height: height * 0.4,
//                   child: downloadedFile != null ? Image.file(downloadedFile!) : Text(downloadMessage),
//                 ),
//               ),
//
//               SizedBox(
//                 height: height * 0.1,
//               ),
//
//               ///
//               /// download now button
//               InkWell(
//                 onTap: () {
//                   String url = "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif";
//                   String filename = "my_file_name";
//                   downloadFile(
//                     url: url,
//                     filename: filename,
//                   );
//                 },
//                 child: Container(
//                   width: width * 0.8,
//                   height: height * 0.05,
//                   color: Colors.teal.shade100,
//                   alignment: Alignment.center,
//                   child: Text(
//                     'Download',
//                     style: TextStyle(
//                       fontSize: fontSize * 20,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   ///
//   /// download file function
//   Future downloadFile({
//     required String url,
//     required String filename,
//   }) async {
//     try {
//       HttpClient client = HttpClient();
//       List downloadData = [];
//
//       Directory downloadDirectory;
//
//       if (Platform.isIOS) {
//         downloadDirectory = await getApplicationDocumentsDirectory();
//       } else {
//         downloadDirectory = Directory('/storage/emulated/0/Download');
//         if (!await downloadDirectory.exists()) downloadDirectory = (await getExternalStorageDirectory())!;
//       }
//
//       String filePathName = "${downloadDirectory.path}/$filename";
//       File savedFile = File(filePathName);
//       bool fileExists = await savedFile.exists();
//
//       if (fileExists && mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("File already downloaded")));
//       } else {
//         client.getUrl(Uri.parse(url)).then(
//               (HttpClientRequest request) {
//             setState(() {
//               downloadMessage = "Loading";
//             });
//             return request.close();
//           },
//         ).then(
//               (HttpClientResponse response) {
//             response.listen((d) => downloadData.addAll(d), onDone: () {
//               savedFile.writeAsBytes(downloadData);
//               setState(() {
//                 downloadedFile = savedFile;
//               });
//             });
//           },
//         );
//       }
//     } catch (error) {
//       setState(() {
//         downloadMessage = "Some error occurred -> $error";
//       });
//     }
//   }
// }
//
