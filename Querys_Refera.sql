/* Candidata: Maria Victória Fernandes Vaz */

/* Consulta 1: Valor total das vendas e dos fretes por produto e ordem de venda 
    Dados ordenados pela data de venda */
SELECT
    V.Data,
    P.ProdutoID,
    SUM(P.Valor) AS Valor_Total_Produtos,
    SUM(V.ValorFrete) AS Valor_Total_Fretes,
    SUM(P.Valor + V.ValorFrete) AS Valor_Total_Venda
FROM
    vendas V
JOIN
    produtos P ON V.CupomID = P.CupomID 
GROUP BY
    P.ProdutoID
ORDER BY
    YEAR(STR_TO_DATE(V.Data, '%d/%m/%Y')),
    MONTH(STR_TO_DATE(V.Data, '%d/%m/%Y')),
    DAY(STR_TO_DATE(V.Data, '%d/%m/%Y'));

/* Consulta 2: Valor de venda por tipo de produto 
    O tipo do produto é dado por CupomID + ProdutoID */
SELECT
    P.ProdutoID,
    P.CupomID,
    P.Valor As Valor_De_Venda
FROM
    produtos P
ORDER BY
    P.ProdutoID;

/* Consulta 3: Quantidade e valor das vendas por dia, mês, ano */
SELECT
    STR_TO_DATE(V.Data, '%d/%m/%Y') AS Data,
    COUNT(*) AS Quantidade_De_Vendas,
    SUM(P.Valor) AS Valor_Total_Das_Vendas
FROM
    Vendas V
JOIN
    Produtos P ON V.CupomID = P.CupomID
GROUP BY
    V.Data
ORDER BY
    YEAR(STR_TO_DATE(V.Data, '%d/%m/%Y')),
    MONTH(STR_TO_DATE(V.Data, '%d/%m/%Y')),
    DAY(STR_TO_DATE(V.Data, '%d/%m/%Y'));

/* Consulta 4: Lucro dos meses
    Coloquei também o ano de cada mês 
    para que o resultado faça mais sentido */
SELECT 
    MONTH(STR_TO_DATE(V.Data, '%d/%m/%Y')) AS Mes,
    YEAR(STR_TO_DATE(V.Data, '%d/%m/%Y')) AS Ano,
    SUM(P.ValorLiquido) AS Lucro_Do_Mes
FROM 
    Vendas V
JOIN 
    Produtos P ON V.CupomID = P.CupomID
GROUP BY
    Mes,
    Ano
ORDER BY
    Ano,
    Mes;

/* Consulta 5: Venda por produto */
SELECT
    P.ProdutoID,
    COUNT(*) AS Total_De_Vendas 	
FROM
    produtos P
JOIN
    vendas V ON V.CupomID = P.CupomID
GROUP BY
    P.ProdutoID
ORDER BY
    P.ProdutoID;

/* Consulta 6: Venda por cliente, cidade do cliente e estado
    Como não há o estado do cliente na tabelas, coloquei o 
    país no lugar */
SELECT 
    C.Cliente, 
    C.NomeContato, 
    C.Cidade, 
    C.Pais AS Estado_Pais,
    COUNT(*) AS Vendas
FROM
    clientes C
JOIN
    vendas V ON C.ClienteID = V.ClienteID
GROUP BY
    C.ClienteID;

/* Consulta 7: Média de produtos vendidos */
SELECT
    AVG(ProdutosVendidos) AS Media_Produtos_Vendidos
FROM
    (
        SELECT
            V.CupomID,
            COUNT(*) AS ProdutosVendidos
        FROM
            vendas V
        JOIN
            produtos P ON V.CupomID = P.CupomID
        GROUP BY
            V.CupomID
    ) AS Consulta_Vendas;


/* Consulta 8: Média de compras que um cliente faz  */
SELECT AVG(NumeroDeCompras) AS Media_De_Compras_Por_Cliente
FROM (
    SELECT C.ClienteID, COUNT(V.ClienteID) AS NumeroDeCompras
    FROM clientes C
    JOIN vendas V ON C.ClienteID = V.ClienteID
    GROUP BY C.ClienteID
) AS Contagem;
