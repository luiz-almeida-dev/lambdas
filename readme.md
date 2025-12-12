# Guia de Atualização das Métricas

Este documento descreve todo o processo necessário para rodar a **seed**, executar a **função agregadora** e habilitar todas as funcionalidades de métricas dentro do aplicativo.

---

## 📌 1. Executando a Seed Inicial

### \*\*1.1 Rodar arquivo `init.sql` (projeto `api_gallart`)

- Se você **ainda não possui banco criado**, execute o arquivo completo.
- Se você **já possui banco funcional**, execute **apenas as tabelas que estão após o tópico `metricas`** dentro do arquivo.

### \*\*1.2 Rodar `seed.sql`

No seu banco já conectado:

- Execute o arquivo `seed.sql` presente neste projeto.
- **Antes de rodar**, altere:
  - IDs dos produtos
  - IDs da galeria (id do usuário)

⚠️ Certifique-se de escolher IDs que existam no seu banco atual.

---

## 📌 2. Configurando a Conexão com o Banco

Edite o arquivo **`db.js`** e preencha corretamente todas as variáveis de ambiente exigidas para conectar ao seu banco PostgreSQL.

---

## 📌 3. Executando a Agregação de Métricas

Com os dados populados, vamos gerar as tabelas agregadas.

No arquivo **`aggregate.ts`**, localize a linha:

```ts
now.setUTCDate(now.getUTCDate() - 3);
```

Ajuste o valor **`-3`** para o número de dias desejado. Exemplo:

- `-1` → agrega 1 dia atrás
- `-7` → agrega o dia 7
- `0` → agrega o dia atual

Após executar o script com sucesso, todas as métricas estarão devidamente agregadas.

---

## 📌 4. Rotas Liberadas Após a Agregação

### ### **🔹 Métricas Diárias por Produto**

```
/metrics/products/id-do-produto/daily?s=2025-12-09&e=2025-12-12
```

### ### **🔹 Métricas Diárias por Galeria**

```
/metrics/gallery/id-da-galleria/daily?s=2025-12-09&e=2025-12-12
```

### Parâmetros:

- **s** → start date
- **e** → end date

### Comportamento:

- Se **s e e não forem enviados**, retorna **apenas o dia atual**.
- Se apenas **s** ou apenas **e** for enviado, retorna **somente o dia informado**.
- Com ambos parâmetros → retorna objetos de métricas por dia dentro do intervalo.
- Ideal para **montagem de gráficos**.

---

## 📌 5. Rotas de Métricas Mensais (Resumo)

### **🔹 Por Produto**

```
/metrics/products/id-do-produto/summary?m=2025-12
```

### **🔹 Por Galeria**

```
/metrics/gallery/id-da-gallery/summary?m=2025-12
```

### Comportamento:

- Use o parâmetro **m** no formato `YYYY-MM` para especificar o mês.
- Se não enviar **m**, será retornado automaticamente o mês atual.

---

## ✔️ Pronto!

Seguindo este guia, você terá:

- Banco preparado
- Seeds válidas
- Dados agregados
- Todas as rotas de métricas funcionando corretamente
