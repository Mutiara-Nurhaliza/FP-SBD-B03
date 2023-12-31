-- Procedure
DELIMITER //

CREATE PROCEDURE GetDonationSummaryByPaymentMethod(IN payment_method VARCHAR(255))
BEGIN
    -- Declare variables for result
    DECLARE total_donation INT;

    -- Get total donation for the specified payment method
    SELECT SUM(b.Jumlah) INTO total_donation
    FROM fp_sbd.barang b
    JOIN fp_sbd.transaksidonasi td ON b.ID_Donasi = td.ID_Donasi
    WHERE td.Metode_Pembayaran = payment_method;

    -- Display the result
    SELECT 'Donation Summary by Payment Method' AS Result,
           CONCAT('Payment Method: ', payment_method) AS 'Payment Method',
           CONCAT('Total Donation: ', total_donation) AS 'Total Donation';

    -- Additional details
    SELECT dd.Nama AS 'Donor Name', td.NoTransaksi AS 'Transaction Number'
    FROM fp_sbd.transaksidonasi td
    JOIN fp_sbd.datadonasi dd ON td.ID_Donasi = dd.ID_Donasi
    WHERE td.Metode_Pembayaran = payment_method;

END //

DELIMITER ;

--Call Procedure
CALL GetDonationSummaryByPaymentMethod('MetodePembayaran');
