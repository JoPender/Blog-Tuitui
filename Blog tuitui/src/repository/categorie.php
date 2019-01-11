<?php
/*
 * Import de la bibliothèque de fonctions gérant les requêtes SQL
 */
include "db.php";


$displayCat = $db -> prepare
('
  SELECT *
  FROM categorie;
');

$displayCat -> execute();
$displayCat_result = $displayCat -> fetchAll(PDO::FETCH_ASSOC);




 ?>
