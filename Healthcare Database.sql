-- Question--Data Warehouse schema for a healthcare-related use case

# Step 1: Create Dimension Tables
CREATE DATABASE HealthcareDW;
USE HealthcareDW;

# Step 1: Create Fact Table

CREATE TABLE Fact_Treatment (

    Treatment_ID INT PRIMARY KEY AUTO_INCREMENT,
    Patient_ID INT,
    Doctor_ID INT,
    Hospital_ID INT,
    Diagnosis_ID INT,
    Procedure_ID INT,
    Admission_date DATE,
    Discharge_date DATE,
    Treatment_cost DECIMAL(10,2),
    Insurance_coverage DECIMAL(10,2),
	Payment_amount DECIMAL(10,2),
    Outcome_ID INT,
    FOREIGN KEY (Patient_ID) REFERENCES Dim_Patient(Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Dim_Doctor(Doctor_ID),
    FOREIGN KEY (Hospital_ID) REFERENCES Dim_Hospital(Hospital_ID),
    FOREIGN KEY (Diagnosis_ID) REFERENCES Dim_Diagnosis(Diagnosis_ID),
    FOREIGN KEY (Procedure_ID) REFERENCES Dim_Procedure(Procedure_ID),
    FOREIGN KEY (Outcome_ID) REFERENCES Dim_Outcome(Outcome_ID)
);

# Step 2: Create Dimension Table;

# Patient Dimension Table
CREATE TABLE Dim_Patient (
    Patient_ID INT PRIMARY KEY AUTO_INCREMENT,
    First_name VARCHAR(100),
    Last_name VARCHAR(100),
    Gender VARCHAR(10),
    Birth_date DATE,
    Blood_type VARCHAR(5),
    Address TEXT,
    City VARCHAR(50),
    State VARCHAR(50),
    Zip_code VARCHAR(10),
    insurance_ID INT
    
);

# Doctor Dimension Table
CREATE TABLE Dim_Doctor (
    Doctor_ID INT PRIMARY KEY AUTO_INCREMENT,
    First_name VARCHAR(100),
    Last_name VARCHAR(100),
    Specialty VARCHAR(100),
    Hospital_ID INT
);

# Hospital Dimension Table
CREATE TABLE Dim_Hospital (
    Hospital_id INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Type VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50)
);

# Diagnosis Dimension Table
CREATE TABLE Dim_Diagnosis (
    Diagnosis_ID INT PRIMARY KEY AUTO_INCREMENT,
    Diagnosis_code VARCHAR(20),
    Description TEXT
);

# Procedure Dimension Table
CREATE TABLE Dim_Procedure (
    Procedure_ID INT PRIMARY KEY AUTO_INCREMENT,
    Procedure_code VARCHAR(20),
    Description TEXT
);

# Outcome Dimension Table
CREATE TABLE Dim_Outcome (
    Outcome_ID INT PRIMARY KEY AUTO_INCREMENT,
    Outcome_desc VARCHAR(100)
);

# Insurance Dimension Table
CREATE TABLE Dim_Insurance (
    Insurance_ID INT PRIMARY KEY AUTO_INCREMENT,
    Provider_name VARCHAR(100)
);

# Step 3: Insert Sample Data;

# Insert data into Fact_Treatment
INSERT INTO Fact_Treatment (
Patient_ID, 
Doctor_ID, 
Hospital_ID, 
Diagnosis_ID,
Procedure_ID, 
Admission_date, 
Discharge_date, 
Treatment_cost, 
Insurance_coverage, 
Payment_amount, 
Outcome_ID)
VALUES 
(1, 1, 1, 1, 1, '2025-01-10', '2025-01-25', 3000, 4000, 2000, 1),
(2, 2, 2, 2, 2, '2025-03-05', '2025-03-20', 15000, 10000, 3000, 2);

# Insert data into Dim_Patient
INSERT INTO Dim_Patient (first_name, last_name, gender, birth_date, blood_type, address, city, state, zip_code, insurance_id)
VALUES 
('Dina', 'Shakya', 'Male', '1995-07-15', 'O+', '28930 Colorado Bend Dr', 'Katy', 'TX', '77494', 1),
('Pragya', 'Kuikel', 'Female', '1996-02-20', 'O-', '3518 Sunbrust Ct', 'Katy', 'TX', '77494', 2);

# Insert data into Dim_Doctor
INSERT INTO Dim_Doctor (first_name, last_name, specialty, hospital_id)
VALUES 
('Stephanie', 'Roy', 'Cardiology', 1),
('Jeffery', 'Luzader', 'Orthopedics', 2);

#Insert data into Dim_Hospital
INSERT INTO Dim_Hospital (name, type, city, state)
VALUES 
('Texas medical Center', 'Public', 'Houston', 'TX'),
('Memorial Herman', 'Private', 'Katy', 'CA');

# Insert data into Dim_Diagnosis
INSERT INTO Dim_Diagnosis (diagnosis_code, description)
VALUES 
('I10', 'Cancer'),
('E11', 'Type 2 Diabetes');

# Insert data into Dim_Procedure
INSERT INTO Dim_Procedure (procedure_code, description)
VALUES 
('CPT001', 'Lab Test'),
('CPT002', 'Knee Replacement');

# Insert data into Dim_Outcome
INSERT INTO Dim_Outcome (outcome_desc)
VALUES 
('Recovered'),
('Under Treatment');

# Insert data into Dim_Insurance
INSERT INTO Dim_Insurance (provider_name) VALUES ('United'), ('Medicare'), ('Aetna');


# Step 4: Run Queries for Insights

# Calculate total treatment cost by hospital;


SELECT h.name AS Hospital, SUM(t.treatment_cost) AS Total_Cost
FROM Fact_Treatment t
JOIN Dim_Hospital h ON t.hospital_id = h.hospital_id
GROUP BY h.name;

# Find most common diagnoses;
SELECT d.description AS Diagnosis, COUNT(t.treatment_id) AS Count
FROM Fact_Treatment t
JOIN Dim_Diagnosis d ON t.diagnosis_id = d.diagnosis_id
GROUP BY d.description
ORDER BY Count;

# Average length of stay per hospital;
SELECT h.name AS Hospital, 
       AVG(DATEDIFF(t.discharge_date, t.admission_date)) AS Avg_Stay_Days
FROM Fact_Treatment t
JOIN Dim_Hospital h ON t.hospital_id = h.hospital_id
GROUP BY h.name;

# Total revenue from patient payments by doctor
SELECT d.first_name, d.last_name, SUM(t.payment_amount) AS Total_Revenue
FROM Fact_Treatment t
JOIN Dim_Doctor d ON t.doctor_id = d.doctor_id
GROUP BY d.first_name, d.last_name
ORDER BY Total_Revenue;