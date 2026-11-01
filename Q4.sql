WITH DoctorAppointments AS
(
    SELECT
        D.DoctorID,
        D.FirstName,
        D.LastName,
        COUNT(A.AppointmentID) AS TotalAppointments
    FROM Doctors AS D
    LEFT JOIN Appointments AS A
        ON D.DoctorID = A.DoctorID
    GROUP BY
        D.DoctorID,
        D.FirstName,
        D.LastName
)
SELECT *
FROM DoctorAppointments
WHERE TotalAppointments >
(
    SELECT AVG(TotalAppointments * 1.0)
    FROM DoctorAppointments
);