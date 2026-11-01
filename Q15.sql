WITH PatientVisits AS
(
    SELECT
        PatientID,
        COUNT(*) AS TotalVisits
    FROM Appointments
    GROUP BY PatientID
),
PatientTreatments AS
(
    SELECT
        A.PatientID,
        COUNT(T.TreatmentID) AS TotalTreatments,
        SUM(T.Cost) AS TotalSpending
    FROM Appointments AS A
    LEFT JOIN Treatments AS T
        ON A.AppointmentID = T.AppointmentID
    GROUP BY A.PatientID
),
PatientPrescriptions AS
(
    SELECT
        A.PatientID,
        COUNT(PR.PrescriptionID) AS TotalPrescriptions
    FROM Appointments AS A
    LEFT JOIN Prescriptions AS PR
        ON A.AppointmentID = PR.AppointmentID
    GROUP BY A.PatientID
)
SELECT
    P.PatientID,
    P.FirstName + ' ' + P.LastName AS PatientName,
    COALESCE(V.TotalVisits, 0) AS TotalVisits,
    COALESCE(T.TotalTreatments, 0) AS TotalTreatments,
    COALESCE(PR.TotalPrescriptions, 0) AS TotalPrescriptions,
    COALESCE(T.TotalSpending, 0) AS TotalSpending
FROM Patients AS P
LEFT JOIN PatientVisits AS V
    ON P.PatientID = V.PatientID
LEFT JOIN PatientTreatments AS T
    ON P.PatientID = T.PatientID
LEFT JOIN PatientPrescriptions AS PR
    ON P.PatientID = PR.PatientID
ORDER BY TotalSpending DESC;