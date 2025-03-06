const oracledb = require('oracledb');
const express = require('express');
const cors = require('cors');
const app = express();
const port = 3000;

app.use(cors());
app.use(express.json());

const dbConfig = {
  user: "c##air1",
  password: "air1",
  connectString: "localhost/XE"
};

// ดึงข้อมูลนัดหมายจาก Oracle
app.get('/appointments', async (req, res) => {
  let connection;
  try {
    connection = await oracledb.getConnection(dbConfig);
    const result = await connection.execute("SELECT * FROM appointments");
    res.json(result.rows);
  } catch (err) {
    res.status(500).send(err.message);
  } finally {
    if (connection) {
      await connection.close();
    }
  }
});

app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});
