// app.js
const express = require('express');
const sql = require('mssql');
const cors = require('cors');
const bodyParser = require('body-parser');

const app = express();
const port = 3000;

app.use(cors());
app.use(bodyParser.json());

const dbConfig = {
  user: 'fazendatech',
  password: 'Fazenda123',
  server: 'fazendatech.database.windows.net', // ou o IP do seu servidor
  database: 'Fazendatech',
  options: {
    encrypt: true, // Habilita a criptografia
    enableArithAbort: true,
  }
};

sql.connect(config, err => {
    if (err) {
      console.error('Erro ao conectar ao banco de dados:', err);
      return;
    }
    console.log('Conectado ao banco de dados!');
  });


// Rota para cadastrar usuário
app.post('/register', async (req, res) => {
    const { nome, cpf, email, senha, endereco } = req.body;

    // Validações simples
    if (!nome || !cpf || !email || !senha || !endereco) {
        return res.status(400).json({ message: 'Todos os campos são obrigatórios.' });
    }

    try {
        // Conectando ao banco de dados
        await sql.connect(config);

        // Verificando se o CPF ou e-mail já existem
        const result = await sql.query`SELECT * FROM Cliente WHERE cpf = ${cpf} OR email = ${email}`;
        if (result.recordset.length > 0) {
            return res.status(409).json({ message: 'CPF ou e-mail já cadastrados.' });
        }

        // Inserindo um novo usuário
        await sql.query`INSERT INTO Cliente (nome_cliente, cpf, email, senha, endereco) VALUES (${nome}, ${cpf}, ${email}, ${senha}, ${endereco})`;

        return res.status(201).json({ message: 'Usuário cadastrado com sucesso.' });
    } catch (error) {
        console.error(error); // Exibir erro no console
        return res.status(500).json({ message: 'Erro ao cadastrar o usuário.', error });
    } finally {
        await sql.close(); // Fecha a conexão com o banco de dados
    }
});

// Rota para login
app.post('/login', async (req, res) => {
    try {
        const { email, password } = req.body;
        await sql.connect(config);
        const result = await sql.query`SELECT * FROM Cliente WHERE email = ${email} AND senha = ${password}`;
        if (result.recordset.length > 0) {
            res.status(200).send(result.recordset[0]);
        } else {
            res.status(401).send('Credenciais inválidas');
        }
    } catch (err) {
        console.error(err);
        res.status(500).send('Erro ao fazer login');
    }
});

let poolPromise; // Declaramos a variável aqui

// Função para criar a conexão
const createPool = async () => {
  try {
    poolPromise = await new sql.ConnectionPool(config).connect();
    console.log('Conectado ao banco de dados!');
    return poolPromise;
  } catch (err) {
    console.error('Erro ao conectar ao banco de dados:', err);
    process.exit(1); // Encerra o processo se a conexão falhar
  }
};

createPool();

app.get('/search', async (req, res) => {
    const query = req.query.query; // Obtém a consulta da URL
    try {
      if (!poolPromise) {
        throw new Error('Conexão não estabelecida');
      }
      const pool = await poolPromise; // Aguarda a conexão
      const result = await pool.request()
        .input('query', sql.VarChar, `%${query}%`) // Usa parâmetro para evitar SQL Injection
        .query('SELECT * FROM Produto WHERE nome LIKE @query');
      
      res.json(result.recordset);
    } catch (err) {
      console.error('Erro ao buscar produtos:', err);
      res.status(500).send('Erro ao buscar produtos');
    }
  });

app.listen(port, () => {
    console.log(`API rodando em http://localhost:${port}`);
});
