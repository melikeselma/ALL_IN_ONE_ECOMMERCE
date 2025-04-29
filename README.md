# 🛒 ALL_IN_ONE_ECOMMERCE

## Overview
This project is a fork and enhancement of an original e-commerce database design project. Built using **PostgreSQL**, it simulates a fully functional e-commerce platform at the database level. The system supports:

- Customer & product management  
- Order and inventory tracking  
- Logical relational modeling  
- Real-world inspired scenarios and triggers  
- Well-documented database schema and EER diagrams

## Features
- **Entity-Relationship Design**: Clear mapping of all e-commerce concepts into an EER model.
- **Relational Model**: Properly normalized relational schema implementation.
- **SQL Schema**: Create, populate, and manage tables using PostgreSQL.
- **Triggers & Constraints**: Enforce business rules automatically.
- **Data Requirement Analysis**: Functional and non-functional requirements defined in a structured way.

## Installation & Setup

### Prerequisites
- PostgreSQL 13+
- pgAdmin (optional, for GUI)

### Clone Repository
```sh
git clone https://github.com/melikeselma/ALL_IN_ONE_ECOMMERCE.git
cd ALL_IN_ONE_ECOMMERCE
```
### Import SQL to PostgreSQL
```bash
psql -U your_user -d your_database -f db/create_tables.sql
psql -U your_user -d your_database -f db/triggers.sql
```

## 📘 Usage
This project helps you understand how to model the core components of an e-commerce system at the database level. The usage steps are as follows:

## 📄 Review Requirements
Read the functional requirement documents in the DataRequirments/ folder to understand the system logic and modeling decisions.

## 🧩 Understand the Structure
The diagrams in EER/ and the RelationalModel.pdf file show the relationships and database structure in detail.

## 🧪 Simulate Data
Run the SQL commands in the db/ folder to simulate operations like customer registration, product management, and order processes.

## 🗂️ Example ER Concepts Modeled
The key entities and concepts modeled in this project include:
* Users (Admins, Customers)
* Products & Categories
* Orders & Order Details
* Cart and Inventory Management
* Addresses, Payments, and Shipping processes

## 🧪 Testing
You can test database operations and trigger logic using psql command line or tools like pgAdmin.

## 🤝 Contributing
This project is a fork, with additional contributions and improvements made to the original structure. Pull requests are welcome. Please test and document your code before submitting.

## 📜 License
This project is licensed under the MIT License.

<hr/>

👩‍💻 Developed by: melikeselma

🧬 Original Repo: TRextabat/ALL_IN_ONE_ECOMMERCE
