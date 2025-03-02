const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const { Pool } = require('pg');

const app = express();
const port = 3001;

app.use(cors());
app.use(bodyParser.json());

const pool = new Pool({
  user: 'service_serious',
  host: 'localhost',
  database: 'mes_db',
  password: 'serious123',
  port: 5432,
});

// Get all production orders
app.get('/production/orders', async (req, res) => {
    const result = await pool.query('SELECT * FROM production_orders');
    res.json(result.rows);
  });
  
  // Create a new production order
  app.post('/production/orders', async (req, res) => {
    const { order_number, product_name, quantity, start_date, due_date, status } = req.body;
    const result = await pool.query(
      'INSERT INTO production_orders (order_number, product_name, quantity, start_date, due_date, status) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *',
      [order_number, product_name, quantity, start_date, due_date, status]
    );
    res.json(result.rows[0]);
  });
  
// Update a production order
app.put('/production/orders/:id', async (req, res) => {
const { id } = req.params;
const { status } = req.body;
const result = await pool.query(
    'UPDATE production_orders SET status = $1 WHERE id = $2 RETURNING *',
    [status, id]
);
res.json(result.rows[0]);
});

// Delete a production order
app.delete('/production/orders/:id', async (req, res) => {
const { id } = req.params;
await pool.query('DELETE FROM production_orders WHERE id = $1', [id]);
res.json({ message: 'Order deleted' });
});

// Get all quality inspections for a specific order
app.get('/quality/inspections/:orderId', async (req, res) => {
const { orderId } = req.params;
const result = await pool.query('SELECT * FROM quality_inspections WHERE order_id = $1', [orderId]);
res.json(result.rows);
});

// Add a new quality inspection
app.post('/quality/inspections', async (req, res) => {
const { order_id, inspector_name, inspection_date, status, notes } = req.body;
const result = await pool.query(
    'INSERT INTO quality_inspections (order_id, inspector_name, inspection_date, status, notes) VALUES ($1, $2, $3, $4, $5) RETURNING *',
    [order_id, inspector_name, inspection_date, status, notes]
);
res.json(result.rows[0]);
});

// Update a quality inspection
app.put('/quality/inspections/:id', async (req, res) => {
const { id } = req.params;
const { status, notes } = req.body;
const result = await pool.query(
    'UPDATE quality_inspections SET status = $1, notes = $2 WHERE id = $3 RETURNING *',
    [status, notes, id]
);
res.json(result.rows[0]);
});




// Get all defects for a specific inspection
app.get('/quality/inspections/:inspectionId/defects', async (req, res) => {
    const { inspectionId } = req.params;
    const result = await pool.query('SELECT * FROM defects WHERE inspection_id = $1', [inspectionId]);
    res.json(result.rows);
  });
  
// Add a new defect
app.post('/quality/defects', async (req, res) => {
    const { inspection_id, defect_type, severity, description } = req.body;
    const result = await pool.query(
    'INSERT INTO defects (inspection_id, defect_type, severity, description) VALUES ($1, $2, $3, $4) RETURNING *',
    [inspection_id, defect_type, severity, description]
    );
    res.json(result.rows[0]);
});

// Delete a defect
app.delete('/quality/defects/:id', async (req, res) => {
    const { id } = req.params;
    await pool.query('DELETE FROM defects WHERE id = $1', [id]);
    res.json({ message: 'Defect deleted' });
});


// Get machine utilization data
app.get('/metrics/machine-utilization', async (req, res) => {
  const result = await pool.query('SELECT * FROM machine_utilization ORDER BY recorded_at DESC');
  res.json(result.rows);
});

  
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});