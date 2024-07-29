import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfViewerPage extends StatelessWidget {
  final String filePath;

  const PdfViewerPage({required this.filePath, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voir le PDF'),
      ),
      body: PdfViewer(
        filePath: filePath,
      ),
    );
  }
}

class PdfViewer extends StatefulWidget {
  final String filePath;

  const PdfViewer({required this.filePath, super.key});

  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  late PdfController _pdfController;

  @override
  void initState() {
    super.initState();
    _pdfController = PdfController(
      document: PdfDocument.openFile(widget.filePath),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PdfView(
      controller: _pdfController,
    );
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }
}
