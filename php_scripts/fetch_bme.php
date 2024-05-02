<?php
// Nastavenie prístupu k skriptu z rôznych domén
header("Access-Control-Allow-Origin: *");

// Parametre pripojenia k MySQL databáze
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

// Získanie údajov o teplote, vlhkosti a tlaku vzduchu
$sql = "SELECT temperature, humidity, pressure FROM bme_table ORDER BY timestamp DESC LIMIT 1";     // Získanie najnovších hodnôt
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $data = array(
        'temperature' => $row["temperature"],
        'humidity' => $row["humidity"],
        'pressure' => $row["pressure"]
    );

    // Návrat údajov vo formáte JSON
    header('Content-Type: application/json');
    echo json_encode($data);
} else {
    echo "No BME data found.";
}

// Uzatvorenie pripojenia k databáze
$conn->close();
?>

