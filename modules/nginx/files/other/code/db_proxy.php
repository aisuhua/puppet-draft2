<?php
try {
    $dbh = new PDO('mysql:host=192.168.1.168;dbname=test', 'aisuhua', '123456');
    foreach($dbh->query('SELECT * from test') as $row) {
        print_r($row);
    }
    $dbh = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}