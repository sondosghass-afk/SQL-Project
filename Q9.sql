WITH RankedAppointments AS
(
    SELECT
        P.PatientID,
        P.FirstName,
        P.LastName,
        A.AppointmentID,
        A.AppointmentDate,
        ROW_NUMBER() OVER
        (
            PARTITION BY A.PatientID
            ORDER BY
                A.AppointmentDate,
                A.AppointmentID
        ) AS AppointmentRank
    FROM Patients AS P
    INNER JOIN Appointments AS A
        ON P.PatientID = A.PatientID
)
SELECT *
FROM RankedAppointments
WHERE AppointmentRank = 1
ORDER BY PatientID;