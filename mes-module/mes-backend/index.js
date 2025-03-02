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
    const { order_number, product_name, quantity, start_date, due_date, status, order_value} = req.body;
    const result = await pool.query(
      'INSERT INTO production_orders (order_number, product_name, quantity, start_date, due_date, status, order_value) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *',
      [order_number, product_name, quantity, start_date, due_date, status, order_value]
    );
    res.json(result.rows[0]);
  });
  
// Get production orders grouped by month-year
app.get('/production/orders/grouped-by-month-year', async (req, res) => {
  const result = await pool.query(`
    SELECT 
      month_year,
      COUNT(*) AS order_count
    FROM (
      SELECT 
        TO_CHAR(start_date, 'MM-YYYY') AS month_year
      FROM production_orders
    ) AS subquery
    GROUP BY month_year
    ORDER BY TO_DATE(month_year, 'MM-YYYY')
  `);
  res.json(result.rows);
});

// Get total order value grouped by month-year
app.get('/production/orders/value-by-month-year', async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT 
        TO_CHAR(start_date, 'MM-YYYY') AS month_year,
        SUM(order_value) AS total_order_value
      FROM production_orders
      GROUP BY TO_CHAR(start_date, 'MM-YYYY')
      ORDER BY TO_DATE(TO_CHAR(start_date, 'MM-YYYY'), 'MM-YYYY')
    `);
    res.json(result.rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});




// Get the sum of quantities for pending orders
app.get('/production/orders/pending-sum', async (req, res) => {
  const result = await pool.query(
    'SELECT COUNT(order_number) AS total_pending_order_number FROM production_orders WHERE status = $1',
    ['Pending']
  );
  res.json({ total_pending_order_number: result.rows[0].total_pending_order_number });
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
app.get('/quality/inspections/', async (req, res) => {
  const result = await pool.query('SELECT * FROM quality_inspections',);
  res.json(result.rows);
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


// Get machine utilization data with average calculation
app.get('/metrics/average-machine-utilization', async (req, res) => {
  const result = await pool.query('SELECT ROUND(AVG(utilization_percentage), 2) AS average_utilization FROM machine_utilization');
  res.json({ average_utilization: result.rows[0].average_utilization });
});
  
// Get all production steps
app.get('/production/steps', async (req, res) => {
  const result = await pool.query('SELECT * FROM production_steps');
  res.json(result.rows);
});

// Create a new production step
app.post('/production/steps', async (req, res) => {
  const { step_id, order_id, step_name, status, start_time, end_time } = req.body;
  const result = await pool.query(
    'INSERT INTO production_steps (step_id, order_id, step_name, status, start_time, end_time) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *',
    [step_id, order_id, step_name, status, start_time, end_time]
  );
  res.json(result.rows[0]);
});

// Count production steps grouped by status
app.get('/production/steps/grouped-by-status', async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT 
        status,
        COUNT(*) AS step_count
      FROM production_steps
      GROUP BY status
      ORDER BY status
    `);
    res.json(result.rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});


// Update a production step
app.put('/production/steps/:id', async (req, res) => {
  const { id } = req.params;
  const { step_id, order_id, step_name, status, start_time, end_time } = req.body;
  const result = await pool.query(
    'UPDATE production_steps SET step_id = $1, order_id = $2, step_name = $3, status = $4, start_time = $5, end_time = $6 WHERE id = $7 RETURNING *',
    [step_id, order_id, step_name, status, start_time, end_time, id]
  );
  res.json(result.rows[0]);
});

// Delete a production step
app.delete('/production/steps/:id', async (req, res) => {
  const { id } = req.params;
  await pool.query('DELETE FROM production_steps WHERE id = $1', [id]);
  res.json({ message: 'Production step deleted successfully' });
});

// Get the count of production steps with incomplete status
app.get('/production/steps/incomplete-count', async (req, res) => {
  const result = await pool.query(
    'SELECT COUNT(*) AS incomplete_count FROM production_steps WHERE status != $1',
    ['Completed']
  );
  res.json({ incomplete_count: result.rows[0].incomplete_count });
});


app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});