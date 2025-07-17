// views/pdf_viewer_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatelessWidget {
  final File pdfFile;

  const PdfViewerScreen({Key? key, required this.pdfFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View PDF")),
      body: SfPdfViewer.file(pdfFile),
    );
  }
}
