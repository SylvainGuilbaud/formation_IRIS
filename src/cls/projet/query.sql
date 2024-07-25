SELECT 
facture.*,client.*,article.*
FROM data_CSV.facture facture 
left join data_CSV.client client on facture.client = client.id
left join data_CSV.facture_Articles articles on articles.facture = facture.id
left join data_CSV.article article on articles.articles = article.id