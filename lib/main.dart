import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:test_pdf_web/save_file_web.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo PDF',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          // color: Color(0xFF280B91),
          color: Color(0xff3E7485),
          onPressed: () {
            _createPDF();
          },
          child: Text(
            "แสดงรายงาน PDF",
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Future<List<int>> _readData(String name) async {
    final ByteData data = await rootBundle.load('assets/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  Future _createPDF() async {
//Creates a new PDF document
    PdfDocument document = PdfDocument();
    document.pageSettings.size = PdfPageSize.a4;
    final page = document.pages.add();

    //create title page on pdf
    page.graphics.drawString(
      "ทดสอบการที่แปลงเป็น PDF ค่ะ กดที่นี้ได้เลยค่ะ",
      PdfTrueTypeFont(
          await _readData('fonts/google_fonts/THSarabunNew Bold.ttf'), 22),
      brush: PdfBrushes.black,
      bounds: const Rect.fromLTWH(20, 100, 0, 0),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.justify,
      ),
    );
    //save pdf on device
    List<int> bytes = document.save();

    // //Download the output file

    await FileSaveHelper.saveAndLaunchFile(bytes, "ทดสอบ.pdf");
    //Dispose the document
    document.dispose();
  }
}
