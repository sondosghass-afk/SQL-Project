SELECT
    P.PatientID,
    P.FirstName,
    P.LastName,
    A.AppointmentID,
    A.AppointmentDate,
    LEAD(A.AppointmentDate) OVER
    (
        PARTITION BY A.PatientID
        ORDER BY A.AppointmentDate
    ) AS NextAppointmentDate
FROM Appointments AS A
INNER JOIN Patients AS P
    ON A.PatientID = P.PatientID
ORDER BY
    A.PatientID,
    A.AppointmentDate;