import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:locteca/model/mainRound.dart';
import 'package:locteca/model/sendCoin.dart';
import 'package:pdf/pdf.dart' as newPdfForPrintingLibrary;
import 'package:printing/printing.dart';

import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:open_file/open_file.dart' as open_file;

class PrintCoinRecipt {
  final SendCoin sendCoin;

   final df = new DateFormat('dd-MM-yyyy ', 'en');
  final tf = new DateFormat('hh:mm a', 'en');
  PrintCoinRecipt(this.sendCoin);
  Future<void> generateInvoice() async {
    //Create a PDF document.
    final PdfDocument document = PdfDocument();
    
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    //Get page client size
    final Size pageSize = page.getClientSize();
    //Draw rectangle
    // page.graphics.drawRectangle(
    //     bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
    //     pen: PdfPen(PdfColor(142, 170, 219, 255)));
    //Generate PDF grid.
    final PdfGrid grid = getGrid();
     
  
     

  
    //Draw the header section by creating text element
    final PdfLayoutResult result = drawHeader(page, pageSize, grid);
    //Draw grid
   // drawGrid(page, grid, result);

    //Add invoice footer
    drawFooter(page, pageSize);
    //Save and launch the document
    final List<int> bytes = document.save();
    //Dispose the document.
    document.dispose();

  

    //Get the storage folder location using path_provider package.
    final Directory directory =
        await path_provider.getApplicationDocumentsDirectory();
    final String path = directory.path;
    final File file = File('$path/output.pdf');
    await file.writeAsBytes(bytes);
    //Launch the file (used open_file package)
    //
   
    await open_file.OpenFile.open('$path/output.pdf');
  }

  //Draws the invoice header
  PdfLayoutResult drawHeader(PdfPage page, Size pageSize, PdfGrid grid) {
    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(240, 174, 43)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90));
    //Draw string
    page.graphics.drawString(
        'Loteca 2.0', PdfStandardFont(PdfFontFamily.helvetica, 30),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
        brush: PdfSolidBrush(PdfColor(66, 140, 214)));

// Passing round package value
    page.graphics.drawString(sendCoin.coinsTransferred.toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 18),
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
        brush: PdfBrushes.white,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle));

    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 12);
    //Draw string
    page.graphics.drawString('Coins', contentFont,
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(400, -30, pageSize.width - 400, 66),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));
    //Create data foramt and convert it to text.
    final DateFormat format = DateFormat.yMMMMd('en_US');
    final String invoiceNumber = 'Invoice Number: 2058557939\r\n\r\nDate: ' +
        format.format(DateTime.now());
    final Size contentSize = contentFont.measureString(invoiceNumber);
    String userStringData =
        '''Bill To:\n\n${sendCoin.user.name}\n${sendCoin.user.phone}\n${sendCoin.user.email}''';

     String agentStringData = 
        '''Bill From: \n\n${sendCoin.agent.name}\n${sendCoin.agent.phone}\n${sendCoin.agent.email}''' ;

    /////////////

     PdfTextElement(text: agentStringData, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 120,
            contentSize.width + 30, pageSize.height - 120)) ;

    PdfTextElement(
            text:
                "Coins Transferred\nTransfer Date : ${df.format(DateTime.parse(sendCoin.coinsTransferDate))} ${tf.format(DateTime.parse(sendCoin.coinsTransferDate))}",
            font: contentFont)
        .draw(
            page: page,
            bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 328),
                200, contentSize.width + 50, pageSize.height - 120));

    // PdfTextElement(
    //         text:
    //             "Starting Date : ${mainRound.round.startingDate}\nEnding Date : ${mainRound.round.endingDate}",
    //         font: contentFont)
    //     .draw(
    //         page: page,
    //         bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30),
    //             200, contentSize.width + 50, pageSize.height - 120));

    return PdfTextElement(text: userStringData, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(30, 120,
            pageSize.width - (contentSize.width + 30), pageSize.height - 120));
  }

  //Draws the grid
  void drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
    Rect totalPriceCellBounds;
    Rect quantityCellBounds;
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    //Draw the PDF grid and get the result.
    result = grid.draw(
        page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 100, 0, 0));

    // //Draw grand total.
    // page.graphics.drawString('Grand Total',
    //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
    //     bounds: Rect.fromLTWH(
    //         quantityCellBounds.left,
    //         result.bounds.bottom + 10,
    //         quantityCellBounds.width,
    //         quantityCellBounds.height));
    // page.graphics.drawString(10.toString(),
    //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
    //     bounds: Rect.fromLTWH(
    //         totalPriceCellBounds.left,
    //         result.bounds.bottom + 10,
    //         totalPriceCellBounds.width,
    //         totalPriceCellBounds.height));
  }

  //Draw the invoice footer data.
  void drawFooter(PdfPage page, Size pageSize) {
    final PdfPen linePen =
        PdfPen(PdfColor(142, 170, 219, 255), dashStyle: PdfDashStyle.custom);
    linePen.dashPattern = <double>[3, 3];
    //Draw line
    page.graphics.drawLine(linePen, Offset(0, pageSize.height - 50),
        Offset(pageSize.width, pageSize.height - 50));

    const String footerContent =
        '''inc.brixton@gmail.com\nPowered by Brixton Inc.''';

    //Added 30 as a margin for the layout
    page.graphics.drawString(
        footerContent, PdfStandardFont(PdfFontFamily.helvetica, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.right),
        bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 35, 0, 0));

    const String footerContent2 = '''Loteca 2.0\n(C) All Rights Reserved''';
    page.graphics.drawString(
        footerContent2, PdfStandardFont(PdfFontFamily.helvetica, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.right),
        bounds:
            Rect.fromLTWH(pageSize.width - 400, pageSize.height - 35, 0, 0));
  }

  //Create PDF grid and return
  PdfGrid getGrid() {
    //Create a PDF grid
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: 5);
    //Create the header row of the grid.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    //Set style
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.cells[0].value = 'Championship'.tr().toString();
    headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[1].value = 'Time A';

    headerRow.cells[2].value = 'Time B';
    //   headerRow.cells[1].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[3].value = 'Selected Answer';
    headerRow.cells[4].value = 'Happening Date';
    // headerRow.cells[2].stringFormat.alignment = PdfTextAlignment.right;
    // headerRow.cells[3].value = 'Quantity';
    // headerRow.cells[4].value = 'Total';

    // mainRound.userAnswers.forEach((element) {
    //   addProducts(element.championShip, element.teamA, element.teamB,
    //       element.winner, element.happeningDate, grid);
    // });
    // //Add rows
    // addProducts("Game name", 'CA-1098', 'AWC Logo Cap', "New answer",
    //     "20-02-2021", grid);
    // addProducts("Game name", 'CA-1098', 'AWC Logo Cap', "New answer",
    //     "20-02-2021", grid);
    // addProducts("Game name", 'CA-1098', 'AWC Logo Cap', "New answer",
    //     "20-02-2021", grid);
    // addProducts("Game name", 'CA-1098', 'AWC Logo Cap', "New answer",
    //     "20-02-2021", grid);
    // addProducts("Game name", 'CA-1098', 'AWC Logo Cap', "New answer",
    //     "20-02-2021", grid);
    // addProducts("Game name", 'CA-1098', 'AWC Logo Cap', "New answer",
    //     "20-02-2021", grid);
    // addProducts("Game name", 'CA-1098', 'AWC Logo Cap', "New answer",
    //     "20-02-2021", grid);
    // addProducts("Game name", 'CA-1098', 'AWC Logo Cap', "New answer",
    //     "20-02-2021", grid);
    // addProducts("Game name", 'CA-1098', 'AWC Logo Cap', "New answer",
    //     "20-02-2021", grid);
    // addProducts("Game name", 'CA-1098', 'AWC Logo Cap', "New answer",
    //     "20-02-2021", grid);
    // addProducts("Game name", 'CA-1098', 'AWC Logo Cap', "New answer",
    //     "20-02-2021", grid);
    // addProducts("Game name", 'CA-1098', 'AWC Logo Cap', "New answer",
    //     "20-02-2021", grid);

    // addProducts('LJ-0192', 'Long-Sleeve Logo Jersey,M', 49.99, 3, 149.97, grid);
    // addProducts('So-B909-M', 'Mountain Bike Socks,M', 9.5, 2, 19, grid);
    // addProducts('LJ-0192', 'Long-Sleeve Logo Jersey,M', 49.99, 4, 199.96, grid);
    // addProducts('FK-5136', 'ML Fork', 175.49, 6, 1052.94, grid);
    // addProducts('HL-U509', 'Sports-100 Helmet,Black', 34.99, 1, 34.99, grid);
    //Apply the table built-in style
    grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
    //Set gird columns width
    grid.columns[1].width = 100;
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        if (j == 0) {
          cell.stringFormat.alignment = PdfTextAlignment.center;
        }
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }
    return grid;
  }

  //Create and row for the grid.
  void addProducts(String gameName, String teamA, String teamB,
      String userAnswer, String happeningDate, PdfGrid grid) {
    final PdfGridRow row = grid.rows.add();
    row.cells[0].value = gameName;
    row.cells[1].value = teamA;
    row.cells[2].value = teamB;
    row.cells[3].value = userAnswer;
    row.cells[4].value = happeningDate;
  }

  //Get the total amount.
  // double getTotalAmount(PdfGrid grid) {
  //   double total = 0;
  //   for (int i = 0; i < grid.rows.count; i++) {
  //     final String value = grid.rows[i].cells[grid.columns.count - 1].value;
  //     total += double.parse(value);
  //   }
  //   return total;
  // }
}
