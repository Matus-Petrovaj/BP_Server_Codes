<?php
// Nastavenie prístupu k skriptu z rôznych domén
header("Access-Control-Allow-Origin: *");

// Zapnutie zobrazenia chýb
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Parametre pripojenia k MariaDB/MySQL databáze
$servername = "localhost";
$username = "paterson";
$password = "MP115348";
$dbname = "Lab_DB";

// Pripojenie k databáze
$conn = new mysqli($servername, $username, $password, $dbname);

// Kontrola pripojenia
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Získanie ID zariadenia z GET parametrov
$device_id = isset($_GET['ID']) ? intval($_GET['ID']) : 0;

// Kontrola platnosti ID zariadenia
if ($device_id <= 0) {
    echo "Error: Invalid or no device ID provided.";
    exit;
}

// Kontrola príchodu údajov z BME280 senzora
if (isset($_GET['bme2801']) && isset($_GET['bme2802']) && isset($_GET['bme2803'])) {
    $temperature = $_GET['bme2801'];
    $humidity = $_GET['bme2802'];
    $pressure = $_GET['bme2803'];

    // Kontrola, či hodnoty nie sú prázdne a sú numerické
    if (!empty($temperature) && !empty($humidity) && !empty($pressure) &&
        is_numeric($temperature) && is_numeric($humidity) && is_numeric($pressure)) {

        // Dynamické vytvorenie názvu tabuľky podľa ID zariadenia
        $bme_table_name = "node_" . $device_id . "_bme_table";

        // Vloženie údajov do tabuľky bme_table
        $stmt = $conn->prepare("INSERT INTO $bme_table_name (temperature, humidity, pressure) VALUES (?, ?, ?)");
        $stmt->bind_param("ddd", $temperature, $humidity, $pressure);

        // Vykonanie prípravy a vloženie údajov
        if ($stmt->execute()) {
            echo "BME Record added successfully";
        } else {
            echo "Error adding BME record: " . $stmt->error;
        }

        $stmt->close();
    } else {
        echo "Error: Invalid or empty BME values received.";
    }
} // Kontrola príchodu údajov z plynového senzora
elseif (isset($_GET['gasSensor'])) {
    $ppm = $_GET['gasSensor'];

    // Kontrola, či hodnota nie je prázdna a je numerická
    if (!empty($ppm) && is_numeric($ppm)) {

        // Dynamické vytvorenie názvu tabuľky podľa ID zariadenia
        $gas_table_name = "node_" . $device_id . "_gas_table";

        // Vloženie údajov do tabuľky gas_table
        $stmt = $conn->prepare("INSERT INTO $gas_table_name (ppm, timestamp) VALUES (?, NOW())");
        $stmt->bind_param("d", $ppm);

        // Vykonanie prípravy a vloženie údajov
        if ($stmt->execute()) {
            echo "Gas Record added successfully";
        } else {
            echo "Error adding gas record: " . $stmt->error;
        }

        $stmt->close();
    } else {
        echo "Error: Invalid or empty gas sensor value received.";
    }
} else {
    echo "Error: Data not received. Received data: " . print_r($_GET, true);
}

// Uzatvorenie pripojenia k databáze
$conn->close();
?>
