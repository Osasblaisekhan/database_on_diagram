-- Patients Table
CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL
);

-- Medical Histories Table
CREATE TABLE medical_histories (
    id SERIAL PRIMARY KEY,
    admitted_at TIMESTAMP NOT NULL,
    patient_id INT REFERENCES patients(id) ON DELETE CASCADE,
    status VARCHAR(255) NOT NULL
);

-- Invoices Table
CREATE TABLE invoices (
    id SERIAL PRIMARY KEY NOT NULL,
    total_amount DECIMAL(10, 2),
    generated_at TIMESTAMP,
    patient_id INT REFERENCES patients(id) ON DELETE CASCADE,
    medical_history_id INT REFERENCES medical_histories(id) ON DELETE CASCADE
);

-- Treatments Table
CREATE TABLE treatments (
    id SERIAL PRIMARY KEY NOT NULL,
    type VARCHAR(255)
);

-- Invoice Items Table
CREATE TABLE invoice_items (
    id SERIAL PRIMARY KEY,
    unit_price DECIMAL(10, 2),
    quantity INT,
    invoice_id INT REFERENCES invoices(id) ON DELETE CASCADE
);

-- Join Table for Treatments and Invoices
CREATE TABLE invoice_treatments (
    invoice_id INT REFERENCES invoices(id) ON DELETE CASCADE,
    treatment_id INT REFERENCES treatments(id) ON DELETE CASCADE,
    PRIMARY KEY (invoice_id, treatment_id)
);

-- Adding Foreign Key Indexes
CREATE INDEX idx_patients_id ON medical_histories(patient_id);
CREATE INDEX idx_patients_id ON invoices(patient_id);
CREATE INDEX idx_medical_history_id ON invoices(medical_history_id);
CREATE INDEX idx_invoice_id ON invoice_items(invoice_id);
CREATE INDEX idx_treatment_id ON invoice_treatments(treatment_id);