Class python.facture Extends %RegisteredObject
{

/// Description
ClassMethod genereFacture() As %Status [ Language = python ]
{
from reportlab.lib import colors
from reportlab.lib.pagesizes import letter
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle, Paragraph, Spacer
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.units import inch

def generate_invoice_pdf(invoice_number, date, client, amount, payment_link):
    # Création du document PDF
    filename = f"facture_{invoice_number}.pdf"
    doc = SimpleDocTemplate(filename, pagesize=letter)
    elements = []

    # Styles
    styles = getSampleStyleSheet()
    title_style = styles['Heading1']
    normal_style = styles['Normal']
    link_style = ParagraphStyle(
        'LinkStyle',
        parent=normal_style,
        textColor=colors.blue,
        underline=True
    )

    # Titre
    elements.append(Paragraph(f"Facture {invoice_number}", title_style))
    elements.append(Spacer(1, 12))

    # Informations de la facture
    data = [
        ["Date:", date],
        ["Client:", client],
        ["Montant total:", f"{amount} €"]
    ]
    
    table = Table(data, colWidths=[2*inch, 4*inch])
    table.setStyle(TableStyle([
        ('FONTNAME', (0,0), (-1,-1), 'Helvetica'),
        ('FONTSIZE', (0,0), (-1,-1), 10),
        ('TEXTCOLOR', (0,0), (0,-1), colors.grey),
        ('ALIGN', (0,0), (-1,-1), 'LEFT'),
        ('VALIGN', (0,0), (-1,-1), 'MIDDLE'),
    ]))
    elements.append(table)
    elements.append(Spacer(1, 12))

    # Détails de la facture (exemple simplifié)
    data = [
        ["Description", "Quantité", "Prix unitaire", "Total"],
        ["Prestation de service", "1", f"{amount} €", f"{amount} €"],
    ]
    
    table = Table(data, colWidths=[2.5*inch, 1.5*inch, 1.5*inch, 1.5*inch])
    table.setStyle(TableStyle([
        ('BACKGROUND', (0,0), (-1,0), colors.grey),
        ('TEXTCOLOR', (0,0), (-1,0), colors.whitesmoke),
        ('ALIGN', (0,0), (-1,-1), 'CENTER'),
        ('FONTNAME', (0,0), (-1,0), 'Helvetica-Bold'),
        ('FONTSIZE', (0,0), (-1,0), 10),
        ('BOTTOMPADDING', (0,0), (-1,0), 12),
        ('BACKGROUND', (0,1), (-1,-1), colors.beige),
        ('TEXTCOLOR', (0,1), (-1,-1), colors.black),
        ('ALIGN', (0,1), (-1,-1), 'CENTER'),
        ('FONTNAME', (0,1), (-1,-1), 'Helvetica'),
        ('FONTSIZE', (0,1), (-1,-1), 10),
        ('TOPPADDING', (0,1), (-1,-1), 6),
        ('BOTTOMPADDING', (0,-1), (-1,-1), 6),
        ('GRID', (0,0), (-1,-1), 1, colors.black)
    ]))
    elements.append(table)
    elements.append(Spacer(1, 24))

    # Lien de paiement
    link_text = f"<a href='{payment_link}' color='blue'>Cliquez ici pour payer en ligne</a>"
    elements.append(Paragraph(link_text, link_style))

    # Génération du PDF
    doc.build(elements)
    print(f"Facture PDF générée : {filename}")

# Utilisation de la fonction
generate_invoice_pdf(
    invoice_number="FAC-2024-001",
    date="18/07/2024",
    client="Dupont SARL",
    amount="1500,00",
    payment_link="https://mon-site-de-paiement.com/payer/FAC-2024-001"
)
}

/// Description
ClassMethod genereFactureLogo() As %Status [ Language = python ]
{
from reportlab.lib import colors
from reportlab.lib.pagesizes import A4
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle, Paragraph, Spacer, Image
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.units import cm
from reportlab.pdfgen import canvas

class NumberedCanvas(canvas.Canvas):
    def __init__(self, *args, **kwargs):
        canvas.Canvas.__init__(self, *args, **kwargs)
        self._saved_page_states = []

    def showPage(self):
        self._saved_page_states.append(dict(self.__dict__))
        self._startPage()

    def save(self):
        num_pages = len(self._saved_page_states)
        for state in self._saved_page_states:
            self.__dict__.update(state)
            self.draw_page_number(num_pages)
            canvas.Canvas.showPage(self)
        canvas.Canvas.save(self)

    def draw_page_number(self, page_count):
        self.setFont("Helvetica", 9)
        self.drawRightString(20*cm, 1*cm, f"Page {self._pageNumber} sur {page_count}")

def generate_invoice_pdf(invoice_number, date, client, items, total, payment_link):
    filename = f"facture_{invoice_number}.pdf"
    doc = SimpleDocTemplate(filename, pagesize=A4, topMargin=2*cm, bottomMargin=2*cm)
    elements = []

    styles = getSampleStyleSheet()
    styles.add(ParagraphStyle(name='Center', alignment=1))
    styles.add(ParagraphStyle(name='Right', alignment=2))
    styles.add(ParagraphStyle(name='Left', alignment=0))

    # En-tête
    logo = Image("memocomLogo.png", width=4*cm, height=2*cm)  # Assurez-vous d'avoir un logo.png
    header = Table([[logo, Paragraph("Votre Entreprise SA<br/>123 Rue du Commerce<br/>75001 Paris, France<br/>Tél: 01 23 45 67 89", styles['Normal'])]], 
                   colWidths=[4*cm, None])
    header.setStyle(TableStyle([('ALIGN', (0,0), (-1,-1), 'LEFT'),
                                ('VALIGN', (0,0), (-1,-1), 'TOP')]))
    elements.append(header)
    elements.append(Spacer(1, 1*cm))

    # Titre de la facture
    elements.append(Paragraph(f"Facture N° {invoice_number}", styles['Heading1']))
    elements.append(Spacer(1, 0.5*cm))

    # Informations client et facture
    data = [
        ["Date de facturation:", date, "Client:", client],
        ["Échéance:", "À réception", "Adresse:", "456 Avenue du Client"],
        ["", "", "", "75002 Paris, France"]
    ]
    info_table = Table(data, colWidths=[4*cm, 5*cm, 3*cm, 6*cm])
    info_table.setStyle(TableStyle([('FONT', (0,0), (-1,-1), 'Helvetica'),
                                    ('FONT', (0,0), (0,-1), 'Helvetica-Bold'),
                                    ('FONT', (2,0), (2,-1), 'Helvetica-Bold'),
                                    ('ALIGN', (0,0), (-1,-1), 'LEFT'),
                                    ('VALIGN', (0,0), (-1,-1), 'TOP')]))
    elements.append(info_table)
    elements.append(Spacer(1, 1*cm))

    # Détails de la facture
    data = [["Description", "Quantité", "Prix unitaire", "Total"]]
    for item in items:
        data.append([item['description'], str(item['quantity']), f"{item['unit_price']:.2f} €", f"{item['quantity'] * item['unit_price']:.2f} €"])
    data.append(["", "", "Total HT", f"{total:.2f} €"])
    data.append(["", "", "TVA (20%)", f"{total * 0.2:.2f} €"])
    data.append(["", "", "Total TTC", f"{total * 1.2:.2f} €"])

    items_table = Table(data, colWidths=[8*cm, 3*cm, 4*cm, 3*cm])
    items_table.setStyle(TableStyle([('BACKGROUND', (0,0), (-1,0), colors.grey),
                                     ('TEXTCOLOR', (0,0), (-1,0), colors.whitesmoke),
                                     ('ALIGN', (0,0), (-1,-1), 'CENTER'),
                                     ('FONT', (0,0), (-1,0), 'Helvetica-Bold'),
                                     ('FONT', (0,1), (-1,-1), 'Helvetica'),
                                     ('FONTSIZE', (0,0), (-1,-1), 10),
                                     ('BOTTOMPADDING', (0,0), (-1,0), 12),
                                     ('BACKGROUND', (0,1), (-1,-1), colors.beige),
                                     ('TEXTCOLOR', (0,1), (-1,-1), colors.black),
                                     ('ALIGN', (0,1), (-1,-1), 'CENTER'),
                                     ('FONTSIZE', (0,1), (-1,-1), 10),
                                     ('TOPPADDING', (0,1), (-1,-1), 6),
                                     ('BOTTOMPADDING', (0,-1), (-1,-1), 6),
                                     ('GRID', (0,0), (-1,-1), 1, colors.black)]))
    elements.append(items_table)
    elements.append(Spacer(1, 1*cm))

    # Lien de paiement
    link_style = ParagraphStyle('LinkStyle', parent=styles['Normal'], textColor=colors.blue, alignment=1)
    link_text = f"<a href='{payment_link}' color='blue'>Cliquez ici pour payer en ligne</a>"
    elements.append(Paragraph(link_text, link_style))

    # Pied de page
    footer_text = "Merci pour votre confiance. Pour toute question, n'hésitez pas à nous contacter."
    elements.append(Spacer(1, 1*cm))
    elements.append(Paragraph(footer_text, styles['Center']))

    # Génération du PDF
    doc.build(elements, canvasmaker=NumberedCanvas)
    print(f"Facture PDF générée : {filename}")

# Utilisation de la fonction
items = [
    {"description": "Consultation", "quantity": 2, "unit_price": 500.00},
    {"description": "Développement", "quantity": 10, "unit_price": 100.00},
    {"description": "Maintenance", "quantity": 1, "unit_price": 300.00}
]
total = sum(item['quantity'] * item['unit_price'] for item in items)

generate_invoice_pdf(
    invoice_number="FAC-2024-002",
    date="18/07/2024",
    client="Dupont SARL",
    items=items,
    total=total,
    payment_link="https://mon-site-de-paiement.com/payer/FAC-2024-002"
)
}

}
