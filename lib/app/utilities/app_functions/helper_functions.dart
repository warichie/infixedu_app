
class HelperFunctions{
  // png, jpg, jpeg, pdf, doc, docx, webm, oga, mp4, 3gp, mkv
  String getFileExtension(String fileName) => fileName.split('.').last;

  bool isExtensionImage(String fileName) => getFileExtension(fileName) == 'png' || getFileExtension(fileName) == 'jpg' || getFileExtension(fileName) == 'jpeg';
  bool isExtensionFile(String fileName) => getFileExtension(fileName) == 'pdf' || getFileExtension(fileName) == 'doc' || getFileExtension(fileName) == 'docx';

}