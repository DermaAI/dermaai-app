import 'dart:io';
import 'package:derma_ai/constants/descriptions.dart';
import 'package:derma_ai/utils/time_formattor.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'string_opration.dart';

Future<void> generatePdf(String name, String label, String confidence,
    File image, String date) async {
  if (label == 'Normal') {
    label = 'None';
  }
  String para = getDescription(label);

  final pdf = Document();
  final netImage = await networkImage(
      'https://raw.githubusercontent.com/Sunhack-Hackathon/ml-api/main/pdf-logo.png');
  pdf.addPage(
    Page(
      build: (Context context) {
        return Container(
          //padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //LOGO
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                //load asset image using pdf image widget

                Image(netImage,
                    height: 40,
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.topLeft),
              ]),
              //HEAD
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Prediction Report',
                        style: const TextStyle(
                            fontSize: 30, color: PdfColor(0, 0, 0)),
                      ),
                    ),
                    //Divider Line
                    Divider(
                      color: PdfColors.grey,
                      thickness: 2,
                    ),

                    //NAME
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Patient Name: $name',
                            style: const TextStyle(fontSize: 13)),
                        Text('Date: ${getTimeAndDate(date)}',
                            style: const TextStyle(fontSize: 13)),
                      ],
                    ),
                    //Infected Image
                    SizedBox(height: 40),
                    Text('Infected Area Image',
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 15)),
                    SizedBox(height: 20),
                    //Image
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      height: 150,
                      width: 200,
                      decoration: BoxDecoration(
                        color: PdfColors.white,
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                          image: MemoryImage(image.readAsBytesSync()),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    //Disease Name
                    Text(
                      'Detected Disease: ${label.toTitleCase()}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    //Description
                    Text(
                      para,
                    ),
                    SizedBox(height: 30),
                    Text('Result: ${confidence.substring(0, 5)}%'),
                    SizedBox(height: 20),
                    Text('Precise diagnosis: after CNN prediction'),
                    SizedBox(height: 20),
                    Text('Advice: Consultation with a dermatologist'),
                  ],
                ),
              ),
              Spacer(),
              Text(
                  '*This scan result is not a diagnosis, Please, consult your doctor for an accurate diagnosis and treatment recommendation.',
                  style: TextStyle(color: PdfColor.fromHex('#ACACAC')))
            ],
          ),
        );
      },
    ),
  );

  //Save PDF
  print('pdf creation started');
  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/DermaAI ${getTimeAndDate(date)}.pdf';
  final File file = File(path);
  await file.writeAsBytes(await pdf.save());
  print('pdf created');

  //Open PDF
  await OpenFilex.open(path);
}
