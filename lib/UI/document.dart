import 'package:flutter/material.dart';
import 'package:pqms/ModelClass/importApplModelClass.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DocumentView extends StatelessWidget {
  DocumentView({super.key, required this.document});

  final IroDocList? document;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        document!.document!.endsWith(".pdf")
            ? GestureDetector(
                onTap: () async {
                  _pdfViewerKey.currentState?.openBookmarkView();
                  showDocumentPdf("${document?.document}", context);
                },
                child: Image.asset(
                  'assets/pdf.png',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ))
            : GestureDetector(
                onTap: () {
                  showImage("${document?.document}", context);
                },
                child: Image.asset(
                  'assets/jpg.png',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ))
      ],
    );
  }

  showDocumentPdf(String? pdf, BuildContext context) async {
    showDialog(
        context: context,
        builder: ((BuildContext context) {
          return SfPdfViewer.network(
            "${pdf}",
            key: _pdfViewerKey,
            onDocumentLoadFailed: (details) {
              Text("Unable to load PDF");
              print("Unable to load PDF");
            },
          );
        }));
  }

  showImage(String photo, BuildContext context) {
    showDialog(
        context: context,
        builder: ((BuildContext context) {
          return AlertDialog(
            actions: [
              Image.network(
                "${photo}",
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                      child: Image.asset(
                    'assets/no_uploaded.png',
                    height: 200,
                    width: 200,
                  ));
                },
              ),
            ],
          );
        }));
  }

  //showDialog
}
