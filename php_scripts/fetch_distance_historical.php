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

// Nastavenie predvoleného časového rozsahu na 1 hodinu, ak nie je zadaný
$timeRange = isset($_GET['timeRange']) ? $_GET['timeRange'] : '1h';

// Určte správny interval na základe zvoleného časového rozsahu
switch ($timeRange) {
    case '1h':
        $interval = 'INTERVAL 1 HOUR';
        break;
    case '2h':
        $interval = 'INTERVAL 2 HOUR';
        break;
    case '4h':
        $interval = 'INTERVAL 4 HOUR';
        break;
    case '6h':
        $interval = 'INTERVAL 6 HOUR';
        break;
    case '12h':
        $interval = 'INTERVAL 12 HOUR';
        break;
    case '1d':
        $interval = 'INTERVAL 1 DAY';
        break;
    case '1w':
        $interval = 'INTERVAL 1 WEEK';
        break;
    default:
        $interval = 'INTERVAL 1 HOUR'; // Default interval nastavený na 1 hodinu
        break;
}

// Získanie údajov o vzdialenosti z tabuľky `distance_table` pre zvolený časový rozsah
$sql = "SELECT distance, timestamp FROM distance_table WHERE timestamp >= NOW() - $interval ORDER BY timestamp";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $historicalData = array();
    while ($row = $result->fetch_assoc()) {
        $historicalData[] = array(
            'distance' => $row['distance'],
            'timestamp' => $row['timestamp']
        );
    }

    // Návrat údajov vo formáte JSON
    header('Content-Type: application/json');
    echo json_encode($historicalData);
} else {
    echo "No distance sensor data found.";
}

// Uzatvorenie pripojenia k databáze
$conn->close();
?>

