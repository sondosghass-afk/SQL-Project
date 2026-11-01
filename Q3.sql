WITH PatientSpending AS
(
    SELECT
        P.PatientID,
        P.FirstName,
        P.LastName,
        COALESCE(SUM(T.Cost), 0) AS TotalSpending
    FROM Patients AS P
    LEFT JOIN Appointments AS A
        ON P.PatientID = A.PatientID
    LEFT JOIN Treatments AS T
        ON A.AppointmentID = T.AppointmentID
    GROUP BY
        P.PatientID,
        P.FirstName,
        P.LastName
)
SELECT *
FROM PatientSpending
WHERE TotalSpending >
(
    SELECT AVG(TotalSpending * 1.0)
    FROM PatientSpending
);