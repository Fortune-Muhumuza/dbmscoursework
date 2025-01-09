
-- Creating the tables from the ERD

CREATE TABLE geographical_location (
    Location_ID INT PRIMARY KEY,
    Village VARCHAR(100),
    Parish VARCHAR(100),
    Sub_County VARCHAR(100),
    County VARCHAR(100),
    Region VARCHAR(50),
    Population INT,
    Coordinates VARCHAR(100),
    Malaria_Risk_Level VARCHAR(50),
    Health_Facilities_Count INT,
    ITN_Coverage DECIMAL(5, 2),
    Reported_Cases INT
);

CREATE TABLE supply_chain (
    Supply_ID INT PRIMARY KEY,
    Resource_ID INT,
    Facility_ID INT,
    Quantity_Shipped INT,
    Shipment_Date DATE,
    Expected_Arrival_Date DATE,
    Status VARCHAR(50),
    Added_By INT,
    Update_Date DATE,
    FOREIGN KEY (Resource_ID) REFERENCES resource(Resource_ID),
    FOREIGN KEY (Facility_ID) REFERENCES health_facility(Facility_ID)
);

CREATE TABLE epidemiological_data (
    Data_ID INT PRIMARY KEY,
    Location_ID INT,
    Recorded_Date DATE,
    Cases_Per_Thousand_People INT,
    Aerial_ITN VARCHAR(50),
    Status VARCHAR(50),
    Added_By INT,
    Update_Date DATE,
    FOREIGN KEY (Location_ID) REFERENCES geographical_location(Location_ID)
);

CREATE TABLE patient_data (
    Patient_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Date_Of_Birth DATE,
    Phone_Number VARCHAR(15),
    Next_Of_Kin VARCHAR(100),
    Location_ID INT,
    Date_Added DATE,
    FOREIGN KEY (Location_ID) REFERENCES geographical_location(Location_ID)
);

CREATE TABLE visit_record (
    Visit_ID INT PRIMARY KEY,
    Patient_ID INT,
    Facility_ID INT,
    Visit_Date DATE,
    Added_By INT,
    FOREIGN KEY (Patient_ID) REFERENCES patient_data(Patient_ID),
    FOREIGN KEY (Facility_ID) REFERENCES health_facility(Facility_ID)
);

CREATE TABLE health_facility (
    Facility_ID INT PRIMARY KEY,
    Facility_Name VARCHAR(100),
    Location_ID INT,
    Facility_Type_ID INT,
    Capacity INT,
    Contact_Details VARCHAR(100),
    Date_Added DATE,
    FOREIGN KEY (Location_ID) REFERENCES geographical_location(Location_ID),
    FOREIGN KEY (Facility_Type_ID) REFERENCES facility_type(Facility_Type_ID)
);

CREATE TABLE resource (
    Resource_ID INT PRIMARY KEY,
    Facility_ID INT,
    Resource_Type VARCHAR(50),
    Quantity INT,
    Added_By INT,
    FOREIGN KEY (Facility_ID) REFERENCES health_facility(Facility_ID)
);

CREATE TABLE treatment (
    Treatment_ID INT PRIMARY KEY,
    Treatment_Name VARCHAR(50),
    Treatment_Description TEXT,
    Dosage VARCHAR(50),
    Date_Added DATE
);

CREATE TABLE malaria_cases (
    Case_ID INT PRIMARY KEY,
    Patient_ID INT,
    Facility_ID INT,
    Date_Of_Diagnosis DATE,
    Type_Of_Malaria VARCHAR(50),
    Treatment_ID INT,
    Outcome_ID INT,
    FOREIGN KEY (Patient_ID) REFERENCES patient_data(Patient_ID),
    FOREIGN KEY (Facility_ID) REFERENCES health_facility(Facility_ID),
    FOREIGN KEY (Treatment_ID) REFERENCES treatment(Treatment_ID)
);

CREATE TABLE laboratory_tests (
    Test_ID INT PRIMARY KEY,
    Case_ID INT,
    Test_Name VARCHAR(50),
    Test_Status VARCHAR(50),
    Test_Date DATE,
    Technician_ID INT,
    FOREIGN KEY (Case_ID) REFERENCES malaria_cases(Case_ID)
);

CREATE TABLE user_role (
    Role_ID INT PRIMARY KEY,
    Role_Name VARCHAR(50),
    Role_Description TEXT,
    Added_By INT
);

CREATE TABLE user (
    User_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Preferred_Name VARCHAR(50),
    Role_ID INT,
    Username VARCHAR(50),
    Password VARCHAR(100),
    FOREIGN KEY (Role_ID) REFERENCES user_role(Role_ID)
);

CREATE TABLE referral (
    Referral_ID INT PRIMARY KEY,
    Patient_ID INT,
    Referred_From INT,
    Referred_To INT,
    Referral_Date DATE,
    FOREIGN KEY (Patient_ID) REFERENCES patient_data(Patient_ID),
    FOREIGN KEY (Referred_From) REFERENCES health_facility(Facility_ID),
    FOREIGN KEY (Referred_To) REFERENCES health_facility(Facility_ID)
);

CREATE TABLE training (
    Training_ID INT PRIMARY KEY,
    User_ID INT,
    Training_Type VARCHAR(100),
    Training_Date DATE,
    Completion_Status VARCHAR(50),
    FOREIGN KEY (User_ID) REFERENCES user(User_ID)
);

CREATE TABLE interventions (
    Intervention_ID INT PRIMARY KEY,
    Type VARCHAR(50),
    Location_ID INT,
    Start_Date DATE,
    Outcome VARCHAR(50),
    Date_Added DATE,
    FOREIGN KEY (Location_ID) REFERENCES geographical_location(Location_ID)
);

CREATE TABLE system_log (
    Log_ID INT PRIMARY KEY,
    User_ID INT,
    Activity TEXT,
    Timestamp DATETIME,
    IP_Address VARCHAR(50),
    Location VARCHAR(100),
    FOREIGN KEY (User_ID) REFERENCES user(User_ID)
);

-- Supporting table: facility_type
CREATE TABLE facility_type (
    Facility_Type_ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Description TEXT,
    Date_Updated DATE
);
