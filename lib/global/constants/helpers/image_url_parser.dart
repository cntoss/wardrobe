import 'dart:core';

class ImageUrl {
  final String path;
  final String file;
  final String? size;
  final Map<String, String> resolver = {
    '1080': 'large',
    '640': '640px',
    '480': 'medium',
    '360': '360px',
    '240': 'small',
    '120': '120px',
    '60': 'extra-small'
  };
  ImageUrl({required this.path, required this.file,  this.size});

  String parse() {
    switch (size) {
      case '1080':
        return '$path${resolver['1080']}/$file';
      case '640':
        return '$path${resolver['640']}/$file';
      case '480':
        return '$path${resolver['480']}/$file';
      case '360':
        return '$path${resolver['360']}/$file';
      case '240':
        return '$path${resolver['240']}/$file';
      case '120':
        return '$path${resolver['120']}/$file';
      case '60':
        return '$path${resolver['60']}/$file';
      default:
        return '$path$file';
    }
  }
}
