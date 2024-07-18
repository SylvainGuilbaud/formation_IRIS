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

}
