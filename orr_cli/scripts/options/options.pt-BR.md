
# Documentação das tabelas e inserts desenvolvidos para o BD - sobre as OPTIONS

**As opções referem-se às configurações das colunas estabelecidas, visto que o Banco de Dados foi concebido com a capacidade de aceitar tanto as colunas obrigatórias do ORR quanto colunas personalizadas pelos coletivos ou instituições.** 
   
**O modelo padrão contém todas as colunas mínimas do ORR, assegurando a uniformidade das informações relacionadas às áreas de restauração.**

**Outros modelos podem incluir além das colunas mínimas do ORR, ou seja, colunas personalizadas adicionais. Cada coluna com opção prevista torna-se uma tabela no schema options.**

 *Atualmente apenas o Pacto da Mata Atlântica tem colunas extras previstas, por isso existem duas pastas em options: *default* e *pacto_ma*. Outros parceiros poderão desenvolver seus próprios modelos e estes serão adicionados.*
      
           

# Padronização das tabelas "option":

As tabelas de options foram planejadas em conjunto com a ORR e seus colaboradores ao longo do desenvolvimento do BD.   

Elas servem para guardar as respostas estabelecidas pelas instiuições, garantindo que parceiros não preencheram a mesma informação de formas distintas.    

## Cada tabela corresponde a uma informação que foi considerada necessária a respeito dos dados inseridos no BD. 

## Colunas
Todas as tabelas possuem 4 colunas com as seguintes informações: 

- **name_key** : Esta é a primeira coluna que refere-se à uma chave única escrita para identificar uma opção dada à uma coluna. É composta pela abreviação da coluna como prefixo e parte do texto da opção como sufixo. Exemplo: o método principal de restauração 'Sistemas Agroflorestais (SAFs)' terá sua name_key **'met_rest_saf'**. 

- **code_key** : Esta é a segunda coluna que busca de forma simplificada e eficaz guardar as informações no BD. Ela é composta por 3 letras e 2 números, por exemplo: **'mrs10'**. O código utilizado nela busca diminuir o espaço ocupado nas tabelas de 'features' e garantir que o presente dado esteja em consonância com o exigido.   

- **pt** e **en** : As colunas pt e en são preenchidas com a descrição das categorias que cada coluna aborda. Elas são descritas por extenso nos ediomas português brasileiro e inglês. Um exmplo da aplicação das colunas é dado para a tabela método principal de restauração, onde na coluna **pt** a categoria é descrita como **'Sistemas Agroflorestais (SAFs)'** e na coluna **en** é descrito sua versão em tradução da língua inglesa **'Agroforestry Systems (SAFs)'**. Estas colunas são pensadas para ser mais human friendly e já garantir futuras traduções.

## Linhas
As tabelas options trazem em suas linhas as categorias de cada informação que determinada tabela aborda.

## Exemplo de aplicação:

A tabela **metod_princi** tem sua função identificar o Método Principal de Restauração. Nesta tabela há variados métodos de restauração, sendo que cada método é descrito em uma linha da coluna **name_key**, alguns exemplos são:
- Semeadura direta
- Sistemas agroflorestais (SAFs)
- Regeneração Natural com Manejo

Utilizando o método 'Sistemas Agroflorestais - SAF' como exemplo, neste caso, o método também pode ser descrito como 'SAFs' ou como 'Sistemas Agroflorestais (SAFs). Para evitar essas variações de nomenclatura e descrições que levem a erros de interpretação, o usuário optará por uma das categorias já definidas. Neste caso do exemplo, será "Sistemas Agroflorestais - SAF".    

Ao escolher a opção 'Sistemas Agroflorestais (SAFs)', essa categoria terá um código único definido pela coluna **code_key**, que neste caso é **mrs10**. Esse código favorece a organização do BD e pode vir a favorecer quem vai preencher as informações.




