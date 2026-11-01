WITH MonthlyAppointments AS
(
    SELECT
        YEAR(AppointmentDate) AS AppointmentYear,
        MONTH(AppointmentDate) AS AppointmentMonth,
        COUNT(*) AS TotalAppointments
    FROM Appointments
    GROUP BY
        YEAR(AppointmentDate),
        MONTH(AppointmentDate)
)
SELECT TOP 1
    AppointmentYear,
    AppointmentMonth,
    TotalAppointments
FROM MonthlyAppointments
ORDER BY TotalAppointments DESC;