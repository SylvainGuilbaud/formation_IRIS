-- TOP Clients par montant
SELECT 
client.nomclient, round(sum(facture.montanttotalttc),2) montant, count(*) nb_factures
FROM data_CSV.client client
left outer join data_CSV.facture facture on client.id = facture.client
group by client.id
order by montant desc ,nb_factures desc;

-- TOP Clients par nombre de factures
SELECT 
client.nomclient, count(*) nb_factures, round(sum(facture.montanttotalttc),2) montant 
FROM data_CSV.client client
left outer join data_CSV.facture facture on client.id = facture.client
group by client.id
order by nb_factures desc,montant desc;

-- ALL factures
SELECT 
facture.*,client.*,article.*
FROM data_CSV.facture facture 
left join data_CSV.client client on facture.client = client.id
left join data_CSV.facture_Articles articles on articles.facture = facture.id
left join data_CSV.article article on articles.articles = article.id;

-- CHECK MONTANTS
SELECT 
s.facture->numérofacture ref,sum(a.prixunitaire * a.quantite), f.montanttotalht, f.montanttotalttc
FROM data_CSV.facture_Articles s
left outer join data_CSV.article a on s.articles = a.id
left outer join data_CSV.facture f on f.id = s.facture
group by s.facture