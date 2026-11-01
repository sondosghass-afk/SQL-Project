WITH DoctorStats AS
(
    SELECT
        D.DoctorID,
        D.FirstName,
        D.LastName,
        COUNT(DISTINCT A.PatientID) AS NumberOfPatients,
        COUNT(DISTINCT A.AppointmentID) AS NumberOfAppointments,
        COALESCE(SUM(T.Cost), 0) AS RevenueGenerated
    FROM Doctors AS D
    LEFT JOIN Appointments AS A
        ON D.DoctorID = A.DoctorID
    LEFT JOIN Treatments AS T
        ON A.AppointmentID = T.AppointmentID
    GROUP BY
        D.DoctorID,
        D.FirstName,
        D.LastName
)
SELECT
    DoctorID,
    FirstName + ' ' + LastName AS DoctorName,
    NumberOfPatients,
    NumberOfAppointments,
    RevenueGenerated,
    RANK() OVER
    (
        ORDER BY RevenueGenerated DESC
    ) AS RevenueRank
FROM DoctorStats
ORDER BY RevenueGenerated DESC;