---
layout: page
sidebar: right
subheadline: Tips
title: "Python PDF: reportlab"
teaser: "An example of how to use reportlab library"
breadcrumb: true
tags: [scientific-computing, visualization, python]
categories:
    - computing-blog
header:
    title: Reportlab library
    pattern: pattern_jquery-dark-grey-tile.png
author: ramiro_chg
---


> Example of ReportLab PDF changes with Python.

### How introduce changes on PDF files with Python

Here is an example to change PDF files using pyPdf and reportlab python libraries. It introduces a numeration
on the PDF pages. At the same time there are commented several lines (with additional text for a heading). 

{% highlight python %} 
from pyPdf import PdfFileWriter, PdfFileReader
import StringIO
from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import A4
from reportlab.lib.units import inch
from reportlab.lib.colors import Color, red, blue

blue50transparent = Color( 0, 0, 100, alpha=0.2)
from reportlab.graphics.shapes import Rect

#canvas.setFont("Times-Roman", 12)

# read your existing PDF
existing_pdf = PdfFileReader(file("ExamplePDFDossier.pdf", "rb"))
output = PdfFileWriter()

for i in range(existing_pdf.getNumPages()):
    packet = StringIO.StringIO()
    # create a new PDF with Reportlab
    can = canvas.Canvas(packet, pagesize=A4)
    for font in can.getAvailableFonts():
        print font
    #can.rect(225,25,100,100, fill=True, stroke=False)
    #can.setFillColor(blue50transparent)
    can.setFont("Times-BoldItalic", 12)
    #can.drawString(50, 755, "Applicant: Checa-Garcia")
    #can.drawString(250, 755, "Document: Teaching Dossier")
    offset = 0
    if i in [7,8,9,10,41,42,43,44,45]:
       offset = 50
    can.drawString(410, 765+offset, "Dossier Page: %i/%i" % (i+1,existing_pdf.getNumPages()))
 {% endhighlight %}

