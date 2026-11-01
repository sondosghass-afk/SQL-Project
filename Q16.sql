SELECT
    (SELECT COUNT(*)
     FROM Patients) AS TotalPatients,

    (SELECT COUNT(*)
     FROM Doctors) AS TotalDoctors,

    (SELECT COUNT(*)
     FROM Appointments) AS TotalAppointments,

    (SELECT COUNT(*)
     FROM Treatments) AS TotalTreatments,

    (SELECT COALESCE(SUM(Cost), 0)
     FROM Treatments) AS TotalRevenue,

    CAST
    (
        (SELECT COALESCE(SUM(Cost), 0) * 1.0
         FROM Treatments)
        /
        NULLIF
        (
            (SELECT COUNT(*)
             FROM Patients),
            0
        )
        AS DECIMAL(10,2)
    ) AS AverageRevenuePerPatient;