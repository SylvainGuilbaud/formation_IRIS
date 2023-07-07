Class python.demo
{

ClassMethod CreateSamplePDF(fileloc As %String) As %Status [ Language = python ]
{
    import iris
    import canvas
    #; set canvaslib = ##class(%SYS.Python).Import("canvas")
    #; set canvas = canvaslib.Canvas(fileloc)
    #; do canvas.drawImage("/data/images/iris.png", 150, 600)
    #; do canvas.drawImage("/data/images/python.png", 150, 200)
    #; do canvas.setFont("Helvetica-Bold", 24)
    #; do canvas.drawString(25, 450, "InterSystems IRIS & Python. Perfect Together.")
    #; do canvas.save()

    #; from reportlab.pdfgen import canvas
    #; c = canvas.Canvas("hello.pdf")
    #; c.drawString(100, 100, "Welcome to Reportlab!")
    #; c.showPage()
    #; c.save()

    #; from reportlab.pdfgen import canvas

    pdf = canvas.Canvas("example.pdf")
    img = "/data/images/iris.png"
    pdf.drawImage(img, x=100, y=100)
    pdf.save()
}

}
