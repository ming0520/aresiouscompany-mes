# Steps to Run the Project

## 1. Clone the Repository

```bash
git clone https://github.com/ming0520/aresiouscompany-mes.git
cd aresiouscompany-mes
```

## 2. Install Dependencies

### For the frontend:

```bash
cd mes-frontend
npm install
```

### For the backend:

```bash
cd mes-backend
npm install
```

## 3. Set Up the Database

Create a PostgreSQL database and update the connection details in the backend configuration file (e.g., `config/database.js`).

## 4. Run Migrations (if applicable)

Use a migration tool like Knex or Sequelize to set up the database schema.

## 5. Start the Backend Server

```bash
cd mes-backend
npm start
npm run dev
```

## 6. Start the Frontend Development Server

```bash
cd mes-frontend
npm run serve
```

## 7. Access the Application

- Open your browser and visit [http://localhost:8080](http://localhost:8080) for the frontend.
- The backend API will be available at [http://localhost:3001](http://localhost:3001).

---

# Project Structure

```
aresiouscompany-mes/
├── mes-frontend/           # Frontend (Vue.js)
│   ├── public/            # Static assets
│   ├── src/               # Source code
│   │   ├── assets/        # Images, styles, etc.
│   │   ├── components/    # Reusable Vue components
│   │   ├── views/         # Main views/pages
│   │   ├── App.vue        # Root component
│   │   ├── main.js        # Entry point
│   │   └── router.js      # Vue Router configuration
│   └── package.json       # Frontend dependencies
├── mes-backend/            # Backend (Express.js)
│   ├── config/            # Configuration files
│   ├── controllers/       # API controllers
│   ├── models/            # Database models
│   ├── routes/            # API routes
│   ├── middleware/        # Custom middleware
│   ├── app.js             # Main application file
│   └── package.json       # Backend dependencies
├── docker-compose.yml      # Docker configuration (optional)
└── README.md               # Project documentation
```

---

# API Endpoints

## Production Orders

- `GET /production/orders` - Fetch all production orders.
- `POST /production/orders` - Create a new production order.
- `GET /production/orders/grouped-by-status` - Count production orders grouped by status.
- `GET /production/orders/grouped-by-month-year` - Get production orders grouped by month-year.
- `GET /production/orders/value-by-month-year` - Get total order value grouped by month-year.
- `GET /production/orders/pending-sum` - Get the sum of pending production orders.
- `PUT /production/orders/:id` - Update a production order.
- `DELETE /production/orders/:id` - Delete a production order.

## Quality Inspections

- `GET /quality/inspections/` - Get all quality inspections.
- `GET /quality/inspections/:orderId` - Get all quality inspections for a specific order.
- `POST /quality/inspections` - Add a new quality inspection.
- `PUT /quality/inspections/:id` - Update a quality inspection.

## Defects

- `GET /quality/inspections/:inspectionId/defects` - Get all defects for a specific inspection.
- `POST /quality/defects` - Add a new defect.
- `DELETE /quality/defects/:id` - Delete a defect.

## Machine Utilization

- `GET /metrics/machine-utilization` - Get machine utilization data.
- `GET /metrics/average-machine-utilization` - Get average machine utilization.

## Production Steps

- `GET /production/steps` - Get all production steps.
- `POST /production/steps` - Create a new production step.
- `GET /production/steps/grouped-by-status` - Count production steps grouped by status.
- `PUT /production/steps/:id` - Update a production step.
- `DELETE /production/steps/:id` - Delete a production step.
- `GET /production/steps/incomplete-count` - Get the count of incomplete production steps.

---

# Contributing

Contributions are welcome! If you'd like to contribute, please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bugfix.
3. Commit your changes.
4. Submit a pull request.

---

# License

This project is licensed under the MIT License. See the `LICENSE` file for details.

For any questions or issues, please open an issue on the GitHub repository or contact the maintainers.

