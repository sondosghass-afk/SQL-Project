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
SELECT
    RANK() OVER
    (
        ORDER BY TotalSpending DESC
    ) AS SpendingRank,
    FirstName + ' ' + LastName AS PatientName,
    TotalSpending,
    CAST
    (
        100.0 * TotalSpending
        / NULLIF(SUM(TotalSpending) OVER (), 0)
        AS DECIMAL(10,2)
    ) AS PercentageOfTotalRevenue
FROM PatientSpending
ORDER BY
    TotalSpending DESC;